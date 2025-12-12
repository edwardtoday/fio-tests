#!/usr/bin/env bash
set -euo pipefail

# Simple fio smoke test for macOS (posixaio) and Linux (libaio).
# Usage: bash run-fio.sh [target-dir]  # default is current directory

TARGET_DIR="${1:-.}"
ENGINE="$( [[ "$(uname -s)" == "Darwin" ]] && echo posixaio || echo libaio )"

FILENAME="${TARGET_DIR%/}/fio-test.bin"
LOG_DIR="${TARGET_DIR%/}"
RANDREAD_LOG="${LOG_DIR}/fio-randread.log"
RANDWRITE_LOG="${LOG_DIR}/fio-randwrite.log"
SEQ_READ_LOG="${LOG_DIR}/fio-seq-read.log"
SEQ_WRITE_LOG="${LOG_DIR}/fio-seq-write.log"

echo "fio engine: ${ENGINE}"
echo "target file: ${FILENAME}"

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

# Random IO: QD=4 is more realistic for typical OS workloads than QD=256.
# Measure randread/randwrite separately to avoid mixing effects in a single randrw run.
run "fio --filename='${FILENAME}' --size=1G --direct=1 --rw=randwrite --bs=4k --ioengine=${ENGINE} --iodepth=4 --runtime=120 --numjobs=1 --time_based --group_reporting --name=randwrite-qd4 --eta-newline=1" "${RANDWRITE_LOG}"

run "fio --filename='${FILENAME}' --size=1G --direct=1 --rw=randread --bs=4k --ioengine=${ENGINE} --iodepth=4 --runtime=120 --numjobs=1 --time_based --group_reporting --name=randread-qd4 --eta-newline=1" "${RANDREAD_LOG}"

run "fio --filename='${FILENAME}' --direct=1 --rw=read --bs=1M --ioengine=${ENGINE} --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-read --eta-newline=1" "${SEQ_READ_LOG}"

run "fio --filename='${FILENAME}' --direct=1 --rw=write --bs=1M --ioengine=${ENGINE} --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-write --eta-newline=1" "${SEQ_WRITE_LOG}"

echo "Logs written to:"
printf '  %s\n  %s\n  %s\n  %s\n' "${RANDREAD_LOG}" "${RANDWRITE_LOG}" "${SEQ_READ_LOG}" "${SEQ_WRITE_LOG}"
