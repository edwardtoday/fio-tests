#!/usr/bin/env bash
set -euo pipefail

# fio quick/standard/full/db benchmark for macOS (posixaio) and Linux (libaio).
#
# Usage:
#   bash run-fio.sh [--profile quick|standard|full|db] [--system NAME] [--out DIR] [target-dir]
#
# Notes:
# - Creates a temporary file "fio-test.bin" in target-dir and deletes it on exit.
# - Writes logs to --out (default: target-dir). Logs are kept.
# - On push, this script is auto-synced to Linode Object Storage via GitHub Actions.

PROFILE="standard"
SYSTEM_NAME=""
TARGET_DIR="."
OUT_DIR=""
UPLOAD_CHOICE="ask" # ask|yes|no
UPLOAD_MODE=""      # update|create (optional, used only when uploading)
WEBHOOK_URL="${FIO_TESTS_WEBHOOK_URL:-}"
WEBHOOK_SECRET="${FIO_TESTS_WEBHOOK_SECRET:-}"
SYSTEM_NAME_ENV="${FIO_TESTS_SYSTEM:-}"
UPLOAD_REPO="edwardtoday/fio-tests"
EMIT_RUN_JSON="yes"
FINALIZE_ONLY="no"
MANIFEST_OVERRIDE=""
RUN_ID_OVERRIDE=""
REUSE_EXISTING="yes"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile)
      PROFILE="${2:-}"; shift 2 ;;
    --system)
      SYSTEM_NAME="${2:-}"; shift 2 ;;
    --out)
      OUT_DIR="${2:-}"; shift 2 ;;
    --upload)
      UPLOAD_CHOICE="yes"; shift ;;
    --no-upload)
      UPLOAD_CHOICE="no"; shift ;;
    --force|--no-reuse)
      REUSE_EXISTING="no"; shift ;;
    --reuse)
      REUSE_EXISTING="yes"; shift ;;
    --finalize-only)
      FINALIZE_ONLY="yes"; shift ;;
    --manifest)
      MANIFEST_OVERRIDE="${2:-}"; shift 2 ;;
    --run-id)
      RUN_ID_OVERRIDE="${2:-}"; shift 2 ;;
    --mode)
      UPLOAD_MODE="${2:-}"; shift 2 ;;
    --webhook-url)
      WEBHOOK_URL="${2:-}"; shift 2 ;;
    --webhook-secret)
      WEBHOOK_SECRET="${2:-}"; shift 2 ;;
    --repo)
      UPLOAD_REPO="${2:-}"; shift 2 ;;
    --no-run-json)
      EMIT_RUN_JSON="no"; shift ;;
    -h|--help)
      cat <<'EOF'
Usage: bash run-fio.sh [--profile quick|standard|full|db] [--system NAME] [--out DIR] [target-dir]

Optional upload (default: ask/no):
  --upload / --no-upload
  --mode update|create
  --webhook-url URL            (or env: FIO_TESTS_WEBHOOK_URL)
  --webhook-secret SECRET      (or env: FIO_TESTS_WEBHOOK_SECRET)
  --repo OWNER/REPO            (default: edwardtoday/fio-tests)

Reuse behavior (default: reuse existing fio JSON):
  --reuse                      Reuse existing `fio-*.fio.json` when it matches expected params
  --force / --no-reuse          Always rerun all cases and overwrite `fio-*.fio.json`

Finalize / upload existing artifacts (no fio run):
  --finalize-only
  --manifest PATH              (default: latest fio-manifest-*.tsv under --out)
  --run-id RUN_ID              (resolves to --out/fio-manifest-RUN_ID.tsv)

Run JSON output:
  By default, writes a normalized run JSON to --out directory.
  Disable with: --no-run-json
Defaults: profile=standard, target-dir=".", out=target-dir
EOF
      exit 0
      ;;
    *)
      TARGET_DIR="$1"; shift ;;
  esac
done

if [[ -z "${OUT_DIR}" ]]; then
  OUT_DIR="${TARGET_DIR%/}"
else
  OUT_DIR="${OUT_DIR%/}"
fi

mkdir -p "${OUT_DIR}"

ENGINE="$( [[ "$(uname -s)" == "Darwin" ]] && echo posixaio || echo libaio )"
FILENAME="${TARGET_DIR%/}/fio-test.bin"

if [[ "${UPLOAD_CHOICE}" == "ask" && -t 0 ]]; then
  read -r -p "是否上传到 ${UPLOAD_REPO}？(y/N) " ans || true
  case "${ans:-}" in
    y|Y|yes|YES) UPLOAD_CHOICE="yes" ;;
    *) UPLOAD_CHOICE="no" ;;
  esac
fi

if [[ "${UPLOAD_CHOICE}" == "yes" && -z "${SYSTEM_NAME}" && -t 0 ]]; then
  read -r -p "被测系统名称（必填）： " SYSTEM_NAME || true
fi

if [[ "${UPLOAD_CHOICE}" == "yes" && -z "${SYSTEM_NAME}" && -n "${SYSTEM_NAME_ENV}" ]]; then
  SYSTEM_NAME="${SYSTEM_NAME_ENV}"
fi

if [[ "${UPLOAD_CHOICE}" == "yes" && -z "${SYSTEM_NAME}" && ! -t 0 && -r /dev/tty ]]; then
  # curl | bash 会导致 stdin 非 TTY，这里改用 /dev/tty 读交互输入
  read -r -p "被测系统名称（必填）： " SYSTEM_NAME </dev/tty || true
fi

if [[ "${UPLOAD_CHOICE}" == "yes" && -z "${SYSTEM_NAME}" ]]; then
  echo "ERROR: upload requested but system name is empty; pass --system, or set FIO_TESTS_SYSTEM, or run with an interactive TTY" >&2
  exit 2
fi

if [[ "${UPLOAD_CHOICE}" == "yes" && -z "${UPLOAD_MODE}" && -t 0 ]]; then
  read -r -p "上传模式：update/create（默认 update）： " UPLOAD_MODE || true
  UPLOAD_MODE="${UPLOAD_MODE:-update}"
fi

if [[ -z "${SYSTEM_NAME}" && -t 0 ]]; then
  read -r -p "系统名（可选，仅本地标记用）： " SYSTEM_NAME || true
fi

echo "profile: ${PROFILE}"
echo "system: ${SYSTEM_NAME:-"(not set)"}"
echo "fio engine: ${ENGINE}"
echo "target file: ${FILENAME}"
echo "log dir: ${OUT_DIR}"
echo "reuse existing fio json: ${REUSE_EXISTING}"

cleanup() {
  rm -f "${FILENAME}"
}
trap cleanup EXIT HUP INT TERM

fio_json_matches() {
  local path="$1" expected_json="$2"
  python3 - "$path" "$expected_json" <<'PY'
import json, sys, re
path = sys.argv[1]
expected = json.loads(sys.argv[2])
def parse_size(v):
  if v is None:
    return None
  if isinstance(v, (int, float)):
    return int(v)
  s = str(v).strip()
  if not s:
    return None
  if s.isdigit():
    return int(s)
  m = re.fullmatch(r'(\d+)([kKmMgGtT])', s)
  if m:
    num = int(m.group(1))
    unit = m.group(2).lower()
    mul = {'k':1024,'m':1024**2,'g':1024**3,'t':1024**4}[unit]
    return num * mul
  # best-effort for things like 1024MiB / 1GiB
  m = re.fullmatch(r'(\d+)\s*(KiB|MiB|GiB|TiB)', s)
  if m:
    num = int(m.group(1))
    unit = m.group(2)
    mul = {'KiB':1024,'MiB':1024**2,'GiB':1024**3,'TiB':1024**4}[unit]
    return num * mul
  return None

try:
  doc = json.load(open(path, 'r', encoding='utf-8'))
except Exception:
  sys.exit(1)

go = doc.get('global options') or {}
def has_flag(k):
  return k in go

for k, want in expected.items():
  if k == 'time_based':
    if bool(want) and not has_flag('time_based'):
      sys.exit(2)
    if (not bool(want)) and has_flag('time_based'):
      sys.exit(2)
    continue
  if k == 'size_bytes':
    got = parse_size(go.get('size'))
    if got is None:
      sys.exit(2)
    if int(want) != int(got):
      sys.exit(2)
    continue
  got = go.get(k)
  # fio often serializes numbers as strings
  if isinstance(want, bool):
    if str(int(want)) != str(got):
      sys.exit(2)
    continue
  if isinstance(want, int):
    if str(want) != str(got):
      sys.exit(2)
    continue
  if want is None:
    if got is not None:
      sys.exit(2)
    continue
  if str(want) != str(got):
    sys.exit(2)

sys.exit(0)
PY
}

run_json() {
  local cmd="$1" json_out="$2" expected_json="$3"
  if [[ "${REUSE_EXISTING}" == "yes" && -f "${json_out}" ]]; then
    if ! command -v python3 >/dev/null 2>&1; then
      echo "---- python3 not found; cannot validate reuse; rerun: ${json_out}"
    elif fio_json_matches "${json_out}" "${expected_json}"; then
      echo "---- reuse: ${json_out}"
      return 0
    fi
    echo "---- existing ${json_out} does not match expected params; rerun"
  fi

  cleanup_sysv_shm_leaks() {
    if [[ "$(uname -s)" != "Darwin" ]]; then
      return 0
    fi
    if ! command -v ipcs >/dev/null 2>&1 || ! command -v ipcrm >/dev/null 2>&1; then
      return 0
    fi
    local user
    user="$(id -un)"
    # macOS kern.sysv.shmall/shmmax are small by default; fio may leak SysV shm segments on interruption.
    # Only clean segments that are:
    # - owned by current user
    # - key is private (0x00000000)
    # - nattch == 0 (no process attached)
    ipcs -m -a 2>/dev/null | awk -v user="${user}" 'NR>3 && $1=="m" && $3=="0x00000000" && $5==user && $9==0 {print $2}' | while read -r seg_id; do
      ipcrm -m "${seg_id}" >/dev/null 2>&1 || true
    done
  }

  echo "---- running: ${cmd}"
  local errf
  errf="$(mktemp -t fio_err.XXXXXX)"
  # Use fio JSON output so n8n / index.html can reliably extract IOPS/BW/p95/p99.
  if eval "${cmd} --output-format=json --output='${json_out}'" 2>"${errf}"; then
    rm -f "${errf}"
    echo "---- done: ${json_out}"
    return 0
  fi

  if rg -q "failed to setup shm segment" "${errf}" 2>/dev/null || grep -q "failed to setup shm segment" "${errf}"; then
    echo "WARN: fio failed to setup shm; attempting to cleanup leaked SysV shm segments and retry once..." >&2
    cleanup_sysv_shm_leaks
    if eval "${cmd} --output-format=json --output='${json_out}'" 2>>"${errf}"; then
      rm -f "${errf}"
      echo "---- done: ${json_out}"
      return 0
    fi
  fi

  cat "${errf}" >&2
  rm -f "${errf}"
  return 1
}

bytes_free() {
  # 1K blocks available in POSIX df output
  local blocks
  blocks="$(df -kP "${TARGET_DIR%/}" | awk 'NR==2 {print $4}')"
  if [[ -z "${blocks}" ]]; then
    echo 0
    return
  fi
  echo $((blocks * 1024))
}

min_bytes() {
  local a="$1" b="$2"
  if (( a < b )); then echo "$a"; else echo "$b"; fi
}

percent_bytes() {
  local base="$1" pct="$2"
  echo $((base * pct / 100))
}

size_to_bytes() {
  local s="${1:-}"
  if [[ -z "${s}" ]]; then
    return 1
  fi
  if [[ "${s}" =~ ^[0-9]+$ ]]; then
    printf '%s' "${s}"
    return 0
  fi
  if [[ "${s}" =~ ^([0-9]+)([kKmMgGtT])$ ]]; then
    local n="${BASH_REMATCH[1]}"
    local u="${BASH_REMATCH[2],,}"
    local mul=1
    case "${u}" in
      k) mul=$((1024)) ;;
      m) mul=$((1024*1024)) ;;
      g) mul=$((1024*1024*1024)) ;;
      t) mul=$((1024*1024*1024*1024)) ;;
    esac
    printf '%s' $((n * mul))
    return 0
  fi
  return 1
}

standard_size_for_random="1G"
standard_runtime_s=120
seq_runtime_s_standard=120

short_sustained_randwrite_runtime_s=180

run_ts_compact="$(date -u +%Y%m%dT%H%M%SZ)"
run_ts_iso="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

sha256_20() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum | awk '{print substr($1,1,20)}'
  else
    shasum -a 256 | awk '{print substr($1,1,20)}'
  fi
}

system_hash=""
if [[ -n "${SYSTEM_NAME}" ]]; then
  system_hash="$(printf 'fio-tests/system/v1\0%s' "${SYSTEM_NAME}" | sha256_20)"
fi

run_id="${run_ts_compact}"
if [[ -n "${system_hash}" ]]; then
  run_id="${run_id}_${system_hash}"
fi

if [[ -n "${RUN_ID_OVERRIDE}" ]]; then
  run_id="${RUN_ID_OVERRIDE}"
fi

manifest_path="${OUT_DIR}/fio-manifest-${run_id}.tsv"
run_json_path="${OUT_DIR}/fio-run-${run_id}.json"

if [[ -n "${MANIFEST_OVERRIDE}" ]]; then
  manifest_path="${MANIFEST_OVERRIDE}"
  run_id="$(basename "${manifest_path}")"
  run_id="${run_id#fio-manifest-}"
  run_id="${run_id%.tsv}"
  run_json_path="${OUT_DIR}/fio-run-${run_id}.json"
fi

if [[ "${FINALIZE_ONLY}" == "yes" && -z "${MANIFEST_OVERRIDE}" && -z "${RUN_ID_OVERRIDE}" ]]; then
  latest_manifest="$(ls -1t "${OUT_DIR}"/fio-manifest-*.tsv 2>/dev/null | head -n 1 || true)"
  if [[ -z "${latest_manifest}" ]]; then
    echo "ERROR: --finalize-only requires an existing manifest; none found under: ${OUT_DIR}" >&2
    exit 2
  fi
  manifest_path="${latest_manifest}"
  run_id="$(basename "${manifest_path}")"
  run_id="${run_id#fio-manifest-}"
  run_id="${run_id%.tsv}"
  run_json_path="${OUT_DIR}/fio-run-${run_id}.json"
fi

if [[ "${FINALIZE_ONLY}" == "yes" ]]; then
  # Reconstruct timestamps from run_id prefix (YYYYMMDDTHHMMSSZ).
  run_ts_compact="${run_id%%_*}"
  if command -v python3 >/dev/null 2>&1; then
    run_ts_iso="$(python3 - <<'PY' "${run_ts_compact}"
import sys
ts = sys.argv[1]
print(f"{ts[0:4]}-{ts[4:6]}-{ts[6:8]}T{ts[9:11]}:{ts[11:13]}:{ts[13:15]}Z")
PY
)"
  fi
fi

json_path() {
  local name="$1"
  echo "${OUT_DIR}/fio-${name}.fio.json"
}

append_manifest() {
  # TSV columns:
  # json_path, rw, bs, qd, numjobs, direct, ioengine, fdatasync, rwmixread, time_based, runtime_s,
  # size_policy_mode, size_policy_fixed_bytes, size_policy_pct_free, size_effective_bytes
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' "$@" >>"${manifest_path}"
}

run_rand() {
  local rw="$1" bs="$2" qd="$3" runtime="$4" size="$5" name="$6"
  local out; out="$(json_path "${name}")"
  local expected
  local size_bytes=""
  size_bytes="$(size_to_bytes "${size}" 2>/dev/null || true)"
  expected="{\"rw\":\"${rw}\",\"bs\":\"${bs}\",\"iodepth\":${qd},\"ioengine\":\"${ENGINE}\",\"direct\":1,\"numjobs\":1,\"runtime\":${runtime},\"time_based\":true"
  if [[ -n "${size_bytes}" ]]; then
    expected+=",\"size_bytes\":${size_bytes}"
  fi
  expected+="}"
  run_json "fio --filename='${FILENAME}' --size=${size} --direct=1 --rw=${rw} --bs=${bs} --ioengine=${ENGINE} --iodepth=${qd} --runtime=${runtime} --numjobs=1 --time_based --group_reporting --name=${name} --eta-newline=1" "${out}" "${expected}"
  append_manifest "${out}" "${rw}" "${bs}" "${qd}" "1" "1" "${ENGINE}" "0" "" "1" "${runtime}" "fixed" "$((1024*1024*1024))" "" "$((1024*1024*1024))"
}

run_randrw_mix() {
  local mix_read="$1" bs="$2" qd="$3" runtime="$4" size="$5" name="$6"
  local out; out="$(json_path "${name}")"
  local expected
  local size_bytes=""
  size_bytes="$(size_to_bytes "${size}" 2>/dev/null || true)"
  expected="{\"rw\":\"randrw\",\"rwmixread\":${mix_read},\"bs\":\"${bs}\",\"iodepth\":${qd},\"ioengine\":\"${ENGINE}\",\"direct\":1,\"numjobs\":1,\"runtime\":${runtime},\"time_based\":true"
  if [[ -n "${size_bytes}" ]]; then
    expected+=",\"size_bytes\":${size_bytes}"
  fi
  expected+="}"
  run_json "fio --filename='${FILENAME}' --size=${size} --direct=1 --rw=randrw --rwmixread=${mix_read} --bs=${bs} --ioengine=${ENGINE} --iodepth=${qd} --runtime=${runtime} --numjobs=1 --time_based --group_reporting --name=${name} --eta-newline=1" "${out}" "${expected}"
  append_manifest "${out}" "randrw" "${bs}" "${qd}" "1" "1" "${ENGINE}" "0" "${mix_read}" "1" "${runtime}" "fixed" "$((1024*1024*1024))" "" "$((1024*1024*1024))"
}

run_seq() {
  local rw="$1" bs="$2" qd="$3" runtime="$4" name="$5"
  local out; out="$(json_path "${name}")"
  local expected
  expected="{\"rw\":\"${rw}\",\"bs\":\"${bs}\",\"iodepth\":${qd},\"ioengine\":\"${ENGINE}\",\"direct\":1,\"numjobs\":1,\"runtime\":${runtime},\"time_based\":true}"
  run_json "fio --filename='${FILENAME}' --direct=1 --rw=${rw} --bs=${bs} --ioengine=${ENGINE} --iodepth=${qd} --runtime=${runtime} --numjobs=1 --time_based --group_reporting --name=${name} --eta-newline=1" "${out}" "${expected}"
  append_manifest "${out}" "${rw}" "${bs}" "${qd}" "1" "1" "${ENGINE}" "0" "" "1" "${runtime}" "fixed" "$((1024*1024*1024))" "" ""
}

run_sustained_randwrite_short() {
  # short sustained randwrite: 3 minutes, fixed 1G working set, QD4.
  local out; out="$(json_path "sustained-randwrite-4k-qd4-3m")"
  local expected
  expected="{\"rw\":\"randwrite\",\"bs\":\"4k\",\"iodepth\":4,\"ioengine\":\"${ENGINE}\",\"direct\":1,\"numjobs\":1,\"runtime\":${short_sustained_randwrite_runtime_s},\"time_based\":true,\"size_bytes\":1073741824}"
  run_json "fio --filename='${FILENAME}' --size=${standard_size_for_random} --direct=1 --rw=randwrite --bs=4k --ioengine=${ENGINE} --iodepth=4 --runtime=${short_sustained_randwrite_runtime_s} --numjobs=1 --time_based --group_reporting --name=sustained-randwrite-4k-qd4-3m --eta-newline=1" "${out}" "${expected}"
  append_manifest "${out}" "randwrite" "4k" "4" "1" "1" "${ENGINE}" "0" "" "1" "${short_sustained_randwrite_runtime_s}" "fixed" "$((1024*1024*1024))" "" "$((1024*1024*1024))"
}

run_fsync() {
  local rw="$1" bs="$2" qd="$3" runtime="$4" size="$5" name="$6"
  # Buffered + sync engine + fdatasync is closer to DB "write + fsync" path than O_DIRECT/libaio.
  local out; out="$(json_path "${name}")"
  local expected
  local size_bytes=""
  size_bytes="$(size_to_bytes "${size}" 2>/dev/null || true)"
  expected="{\"rw\":\"${rw}\",\"bs\":\"${bs}\",\"iodepth\":${qd},\"ioengine\":\"sync\",\"direct\":0,\"fdatasync\":1,\"numjobs\":1,\"runtime\":${runtime},\"time_based\":true"
  if [[ -n "${size_bytes}" ]]; then
    expected+=",\"size_bytes\":${size_bytes}"
  fi
  expected+="}"
  run_json "fio --filename='${FILENAME}' --size=${size} --direct=0 --rw=${rw} --bs=${bs} --ioengine=sync --iodepth=${qd} --runtime=${runtime} --numjobs=1 --time_based --group_reporting --fdatasync=1 --name=${name} --eta-newline=1" "${out}" "${expected}"
  append_manifest "${out}" "${rw}" "${bs}" "${qd}" "1" "0" "sync" "1" "" "1" "${runtime}" "fixed" "$((1024*1024*1024))" "" "$((1024*1024*1024))"
}

run_quick() {
  # quick 必须是 full/standard 的子集：参数保持一致，便于横向比较
  run_rand "randwrite" "4k" 1 "${standard_runtime_s}" "${standard_size_for_random}" "randwrite-4k-qd1"
  run_rand "randread"  "4k" 1 "${standard_runtime_s}" "${standard_size_for_random}" "randread-4k-qd1"
  run_seq "read"  "1M" 64 "${seq_runtime_s_standard}" "seq-read-1m"
  run_seq "write" "1M" 64 "${seq_runtime_s_standard}" "seq-write-1m"
  run_sustained_randwrite_short
}

run_standard() {
  local qd
  # 4K randread/randwrite @ QD1/QD4/QD16/QD32
  for qd in 1 4 16 32; do
    run_rand "randwrite" "4k" "${qd}" "${standard_runtime_s}" "${standard_size_for_random}" "randwrite-4k-qd${qd}"
    run_rand "randread"  "4k" "${qd}" "${standard_runtime_s}" "${standard_size_for_random}" "randread-4k-qd${qd}"
  done

  # 4K randrw 70/30 @ QD1 + QD4
  run_randrw_mix 70 "4k" 1 "${standard_runtime_s}" "${standard_size_for_random}" "randrw70-4k-qd1"
  run_randrw_mix 70 "4k" 4 "${standard_runtime_s}" "${standard_size_for_random}" "randrw70-4k-qd4"

  # Sequential read/write (larger block sizes)
  run_seq "read"  "128k" 64 "${seq_runtime_s_standard}" "seq-read-128k"
  run_seq "write" "128k" 64 "${seq_runtime_s_standard}" "seq-write-128k"
  run_seq "read"  "1M" 64 "${seq_runtime_s_standard}" "seq-read-1m"
  run_seq "write" "1M" 64 "${seq_runtime_s_standard}" "seq-write-1m"
  run_seq "read"  "4M" 64 "${seq_runtime_s_standard}" "seq-read-4m"
  run_seq "write" "4M" 64 "${seq_runtime_s_standard}" "seq-write-4m"

  # Short sustained random write (3min) for quick checks and comparability.
  run_sustained_randwrite_short
}

run_full() {
  run_standard

  local free_bytes size16g size60
  free_bytes="$(bytes_free)"
  size16g=$((16 * 1024 * 1024 * 1024))
  size60="$(percent_bytes "${free_bytes}" 60)"
  local sustained_size
  if (( free_bytes >= size16g )); then
    sustained_size="${size16g}"
  else
    sustained_size="${size60}"
  fi

  if (( sustained_size < 1024 * 1024 * 1024 )); then
    echo "WARN: free space too small for sustained write test, skipped (free=${free_bytes}B)"
  else
    local out; out="$(json_path "sustained-write-1m")"
    local expected
    expected="{\"rw\":\"write\",\"bs\":\"1M\",\"iodepth\":64,\"ioengine\":\"${ENGINE}\",\"direct\":1,\"numjobs\":1,\"time_based\":false,\"size_bytes\":${sustained_size}}"
    run_json "fio --filename='${FILENAME}' --size=${sustained_size} --direct=1 --rw=write --bs=1M --ioengine=${ENGINE} --iodepth=64 --numjobs=1 --group_reporting --name=sustained-write-1m --eta-newline=1" "${out}" "${expected}"
    append_manifest "${out}" "write" "1M" "64" "1" "1" "${ENGINE}" "0" "" "0" "" "fixed_or_pct_free" "${size16g}" "60" "${sustained_size}"
  fi

  # Sustained random write (10min). Default size is min(4GiB, 60% free).
  local size4g rand_size
  size4g=$((4 * 1024 * 1024 * 1024))
  rand_size="$(min_bytes "${size4g}" "${size60}")"
  if (( rand_size < 1024 * 1024 * 1024 )); then
    echo "WARN: free space too small for sustained randwrite test, skipped (free=${free_bytes}B)"
  else
    local out; out="$(json_path "sustained-randwrite-4k-qd4-10m")"
    local expected
    expected="{\"rw\":\"randwrite\",\"bs\":\"4k\",\"iodepth\":4,\"ioengine\":\"${ENGINE}\",\"direct\":1,\"numjobs\":1,\"runtime\":600,\"time_based\":true,\"size_bytes\":${rand_size}}"
    run_json "fio --filename='${FILENAME}' --size=${rand_size} --direct=1 --rw=randwrite --bs=4k --ioengine=${ENGINE} --iodepth=4 --runtime=600 --numjobs=1 --time_based --group_reporting --name=sustained-randwrite-4k-qd4-10m --eta-newline=1" "${out}" "${expected}"
    append_manifest "${out}" "randwrite" "4k" "4" "1" "1" "${ENGINE}" "0" "" "1" "600" "min_fixed_or_pct_free" "${size4g}" "60" "${rand_size}"
  fi

  # DB-like additions (buffered + fdatasync; and 8K/16K random @QD1/QD4).
  local bs qd
  for bs in 8k 16k; do
    for qd in 1 4; do
      run_rand "randwrite" "${bs}" "${qd}" "${standard_runtime_s}" "${standard_size_for_random}" "dblike-randwrite-${bs}-qd${qd}"
      run_rand "randread"  "${bs}" "${qd}" "${standard_runtime_s}" "${standard_size_for_random}" "dblike-randread-${bs}-qd${qd}"
    done
  done
  run_fsync "write" "4k" 1 60 "1G" "dblike-fdatasync-write-4k-qd1"
}

run_db() {
  local runtime="${standard_runtime_s}"
  local size="${standard_size_for_random}"
  local bs
  for bs in 4k 8k 16k; do
    run_rand "randwrite" "${bs}" 1 "${runtime}" "${size}" "db-randwrite-${bs}-qd1"
    run_rand "randread"  "${bs}" 1 "${runtime}" "${size}" "db-randread-${bs}-qd1"
    run_rand "randwrite" "${bs}" 4 "${runtime}" "${size}" "db-randwrite-${bs}-qd4"
    run_rand "randread"  "${bs}" 4 "${runtime}" "${size}" "db-randread-${bs}-qd4"
  done

  # fdatasync / fsync-like writes (buffered)
  run_fsync "write" "4k" 1 60 "1G" "db-fdatasync-write-4k-qd1"
  run_fsync "write" "8k" 1 60 "1G" "db-fdatasync-write-8k-qd1"
  run_fsync "write" "16k" 1 60 "1G" "db-fdatasync-write-16k-qd1"
}

if [[ "${FINALIZE_ONLY}" != "yes" ]]; then
  case "${PROFILE}" in
    quick) run_quick ;;
    standard) run_standard ;;
    full) run_full ;;
    db) run_db ;;
    *)
      echo "ERROR: unknown profile: ${PROFILE} (expected: quick|standard|full|db)" >&2
      exit 2
      ;;
  esac
fi

if [[ "${EMIT_RUN_JSON}" == "yes" && -n "${SYSTEM_NAME}" ]]; then
  if command -v python3 >/dev/null 2>&1; then
    python3 - <<'PY' "${manifest_path}" "${run_json_path}" "${UPLOAD_REPO}" "${UPLOAD_MODE:-update}" "${SYSTEM_NAME}" "${system_hash}" "${run_id}" "${run_ts_iso}" "${run_ts_compact}" "${ENGINE}" "${TARGET_DIR}" "${OUT_DIR}" "${PROFILE}"
import hashlib
import json
import os
import sys
from datetime import datetime

manifest_path, out_path = sys.argv[1], sys.argv[2]
repo, mode = sys.argv[3], sys.argv[4]
system, system_hash = sys.argv[5], sys.argv[6]
run_id, ts_iso, ts_compact = sys.argv[7], sys.argv[8], sys.argv[9]
engine, target_dir, out_dir, invoked_profile = sys.argv[10], sys.argv[11], sys.argv[12], sys.argv[13]

def sha256_20(data: bytes) -> str:
  return hashlib.sha256(data).hexdigest()[:20]

def canonical(obj) -> bytes:
  return json.dumps(obj, ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode("utf-8")

def normalize_ioengine(ioengine: str) -> str:
  # Treat macOS posixaio and Linux libaio as the same comparable "native aio" case.
  return "native_aio" if ioengine in ("posixaio", "libaio") else ioengine

def case_key(case_sig: dict) -> str:
  return sha256_20(b"fio-tests/case/v2\0" + canonical(case_sig))

def to_mib_s(bw_bytes: float) -> float:
  return float(bw_bytes) / (1024.0 * 1024.0)

def ns_to_ms(ns: float) -> float:
  return float(ns) / 1_000_000.0

def pick_percentile(percentiles: dict, key: str):
  v = percentiles.get(key)
  if v is None:
    return None
  return ns_to_ms(v)

def extract_op(job: dict, op: str):
  part = job.get(op, {})
  if not part:
    return None
  io_bytes = part.get("io_bytes") or 0
  total_ios = part.get("total_ios") or 0
  if io_bytes == 0 and total_ios == 0:
    return None
  iops = part.get("iops")
  bw_bytes = part.get("bw_bytes")
  if bw_bytes is None and part.get("bw") is not None:
    bw_bytes = part["bw"] * 1024
  clat = part.get("clat_ns") or {}
  per = clat.get("percentile") or {}
  p95 = pick_percentile(per, "95.000000")
  p99 = pick_percentile(per, "99.000000")
  if iops is None and bw_bytes is None and p95 is None and p99 is None:
    return None
  return {
    "iops": None if iops is None else float(iops),
    "bw_mib_s": None if bw_bytes is None else to_mib_s(bw_bytes),
    "clat_p95_ms": p95,
    "clat_p99_ms": p99,
  }

cases = []
with open(manifest_path, "r", encoding="utf-8") as f:
  for line in f:
    line = line.rstrip("\n")
    if not line:
      continue
    cols = line.split("\t")
    (
      fio_path, rw, bs, qd, numjobs, direct, ioengine, fdatasync, rwmixread,
      time_based, runtime_s, sp_mode, sp_fixed, sp_pct, size_eff
    ) = cols

    size_policy = {"mode": sp_mode}
    if sp_fixed:
      size_policy["fixed_bytes"] = int(sp_fixed)
    if sp_pct:
      size_policy["pct_free"] = int(sp_pct)

    ioengine_raw = ioengine
    ioengine_norm = normalize_ioengine(ioengine_raw)

    case_sig = {
      "rw": rw,
      "bs": bs,
      "qd": int(qd),
      "numjobs": int(numjobs),
      "direct": int(direct),
      "ioengine": ioengine_norm,
      "fdatasync": int(fdatasync),
      "rwmixread": None if not rwmixread else int(rwmixread),
      "time_based": int(time_based),
      "runtime_s": None if not runtime_s else int(runtime_s),
      "size_policy": size_policy,
    }

    fio = json.load(open(fio_path, "r", encoding="utf-8"))
    job = fio["jobs"][0]
    ops = {}
    for op in ("read", "write"):
      extracted = extract_op(job, op)
      if extracted is not None:
        ops[op] = extracted

    cases.append({
      "case_key": case_key(case_sig),
      "case": case_sig,
      "ioengine_raw": ioengine_raw,
      "size_effective_bytes": None if not size_eff else int(size_eff),
      "fio_json_path": os.path.basename(fio_path),
      "ops": ops,
    })

payload = {
  "repo": repo,
  "mode": mode,
  "run": {
    "run_id": run_id,
    "system": system,
    "system_hash": system_hash,
    "timestamp": ts_iso,
    "timestamp_compact": ts_compact,
    "invoked_profile": invoked_profile,
    "engine": engine,
    "target_dir": target_dir,
    "out_dir": out_dir,
  },
  "cases": cases,
}

with open(out_path, "w", encoding="utf-8") as out:
  json.dump(payload, out, ensure_ascii=False, indent=2, sort_keys=True)
print(f"Run JSON written to: {out_path}")
PY
  else
    echo "WARN: python3 not found, skip run JSON output"
  fi
fi

echo "Artifacts written to:"
echo "  ${manifest_path}"
ls -1 "${OUT_DIR}"/fio-*.fio.json 2>/dev/null | sed 's/^/  /' || true

if [[ "${UPLOAD_CHOICE}" == "yes" ]]; then
  if [[ -z "${WEBHOOK_URL}" && "${UPLOAD_REPO}" == "edwardtoday/fio-tests" ]]; then
    WEBHOOK_URL="https://n8n.sansi.io/webhook/fio-tests-372bba2a-faab-4927-b839-f8e7a1e0d7b5"
  fi
  if [[ -z "${WEBHOOK_URL}" ]]; then
    echo "ERROR: upload requested but webhook url not set; use --webhook-url or env FIO_TESTS_WEBHOOK_URL" >&2
    exit 3
  fi
  if [[ "${EMIT_RUN_JSON}" != "yes" || ! -f "${run_json_path}" ]]; then
    echo "ERROR: upload requested but run JSON not available" >&2
    exit 3
  fi

  echo "---- uploading to webhook: ${WEBHOOK_URL}"
  if [[ -n "${WEBHOOK_SECRET}" ]]; then
    curl -fsS -X POST -H "Content-Type: application/json" -H "Authorization: Bearer ${WEBHOOK_SECRET}" --data-binary @"${run_json_path}" "${WEBHOOK_URL}" >/dev/null
  else
    curl -fsS -X POST -H "Content-Type: application/json" --data-binary @"${run_json_path}" "${WEBHOOK_URL}" >/dev/null
  fi
  echo "---- upload done"
fi
