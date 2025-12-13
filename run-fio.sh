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

PROFILE="standard"
SYSTEM_NAME=""
TARGET_DIR="."
OUT_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile)
      PROFILE="${2:-}"; shift 2 ;;
    --system)
      SYSTEM_NAME="${2:-}"; shift 2 ;;
    --out)
      OUT_DIR="${2:-}"; shift 2 ;;
    -h|--help)
      cat <<'EOF'
Usage: bash run-fio.sh [--profile quick|standard|full|db] [--system NAME] [--out DIR] [target-dir]
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

if [[ -z "${SYSTEM_NAME}" && -t 0 ]]; then
  read -r -p "系统名（可选）： " SYSTEM_NAME || true
fi

echo "profile: ${PROFILE}"
echo "system: ${SYSTEM_NAME:-"(not set)"}"
echo "fio engine: ${ENGINE}"
echo "target file: ${FILENAME}"
echo "log dir: ${OUT_DIR}"

cleanup() {
  rm -f "${FILENAME}"
}
trap cleanup EXIT

run() {
  local cmd="$1" log="$2"
  echo "---- running: ${cmd}"
  eval "${cmd} | tee \"${log}\""
  echo "---- done: ${log}"
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

standard_size_for_random="1G"
standard_runtime_s=120
quick_runtime_s=60
seq_runtime_s_standard=120
seq_runtime_s_quick=60

log_path() {
  local name="$1"
  echo "${OUT_DIR}/fio-${PROFILE}-${name}.log"
}

run_rand() {
  local rw="$1" bs="$2" qd="$3" runtime="$4" size="$5" name="$6"
  run "fio --filename='${FILENAME}' --size=${size} --direct=1 --rw=${rw} --bs=${bs} --ioengine=${ENGINE} --iodepth=${qd} --runtime=${runtime} --numjobs=1 --time_based --group_reporting --name=${name} --eta-newline=1" "$(log_path "${name}")"
}

run_randrw_mix() {
  local mix_read="$1" bs="$2" qd="$3" runtime="$4" size="$5" name="$6"
  run "fio --filename='${FILENAME}' --size=${size} --direct=1 --rw=randrw --rwmixread=${mix_read} --bs=${bs} --ioengine=${ENGINE} --iodepth=${qd} --runtime=${runtime} --numjobs=1 --time_based --group_reporting --name=${name} --eta-newline=1" "$(log_path "${name}")"
}

run_seq() {
  local rw="$1" bs="$2" qd="$3" runtime="$4" name="$5"
  run "fio --filename='${FILENAME}' --direct=1 --rw=${rw} --bs=${bs} --ioengine=${ENGINE} --iodepth=${qd} --runtime=${runtime} --numjobs=1 --time_based --group_reporting --name=${name} --eta-newline=1" "$(log_path "${name}")"
}

run_fsync() {
  local rw="$1" bs="$2" qd="$3" runtime="$4" size="$5" name="$6"
  # Buffered + sync engine + fdatasync is closer to DB "write + fsync" path than O_DIRECT/libaio.
  run "fio --filename='${FILENAME}' --size=${size} --direct=0 --rw=${rw} --bs=${bs} --ioengine=sync --iodepth=${qd} --runtime=${runtime} --numjobs=1 --time_based --group_reporting --fdatasync=1 --name=${name} --eta-newline=1" "$(log_path "${name}")"
}

run_quick() {
  run_rand "randwrite" "4k" 1 "${quick_runtime_s}" "${standard_size_for_random}" "randwrite-4k-qd1"
  run_rand "randread"  "4k" 1 "${quick_runtime_s}" "${standard_size_for_random}" "randread-4k-qd1"
  run_seq "read"  "1M" 64 "${seq_runtime_s_quick}" "seq-read-1m"
  run_seq "write" "1M" 64 "${seq_runtime_s_quick}" "seq-write-1m"
}

run_standard() {
  # 4K randread/randwrite @ QD1 + QD4
  run_rand "randwrite" "4k" 1 "${standard_runtime_s}" "${standard_size_for_random}" "randwrite-4k-qd1"
  run_rand "randread"  "4k" 1 "${standard_runtime_s}" "${standard_size_for_random}" "randread-4k-qd1"
  run_rand "randwrite" "4k" 4 "${standard_runtime_s}" "${standard_size_for_random}" "randwrite-4k-qd4"
  run_rand "randread"  "4k" 4 "${standard_runtime_s}" "${standard_size_for_random}" "randread-4k-qd4"

  # 4K randrw 70/30 @ QD1 + QD4
  run_randrw_mix 70 "4k" 1 "${standard_runtime_s}" "${standard_size_for_random}" "randrw70-4k-qd1"
  run_randrw_mix 70 "4k" 4 "${standard_runtime_s}" "${standard_size_for_random}" "randrw70-4k-qd4"

  # 1M sequential read/write
  run_seq "read"  "1M" 64 "${seq_runtime_s_standard}" "seq-read-1m"
  run_seq "write" "1M" 64 "${seq_runtime_s_standard}" "seq-write-1m"
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
    run "fio --filename='${FILENAME}' --size=${sustained_size} --direct=1 --rw=write --bs=1M --ioengine=${ENGINE} --iodepth=64 --numjobs=1 --group_reporting --name=sustained-write-1m --eta-newline=1" "$(log_path "sustained-write-1m.log")"
  fi

  # Sustained random write (10min). Default size is min(4GiB, 60% free).
  local size4g rand_size
  size4g=$((4 * 1024 * 1024 * 1024))
  rand_size="$(min_bytes "${size4g}" "${size60}")"
  if (( rand_size < 1024 * 1024 * 1024 )); then
    echo "WARN: free space too small for sustained randwrite test, skipped (free=${free_bytes}B)"
  else
    run "fio --filename='${FILENAME}' --size=${rand_size} --direct=1 --rw=randwrite --bs=4k --ioengine=${ENGINE} --iodepth=4 --runtime=600 --numjobs=1 --time_based --group_reporting --name=sustained-randwrite-4k-qd4-10m --eta-newline=1" "$(log_path "sustained-randwrite-4k-qd4-10m.log")"
  fi
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

echo "Logs written to:"
ls -1 "${OUT_DIR}"/fio-"${PROFILE}"-*.log 2>/dev/null | sed 's/^/  /' || true
