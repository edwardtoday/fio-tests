#!/usr/bin/env bash
set -euo pipefail

# Simple fio smoke test for macOS (posixaio) and Linux (libaio).
# Usage: bash run-fio.sh [target-dir]  # default is current directory

TARGET_DIR="${1:-.}"
ENGINE="$( [[ "$(uname -s)" == "Darwin" ]] && echo posixaio || echo libaio )"

FILENAME="${TARGET_DIR%/}/fio-test.bin"
LOG_DIR="${TARGET_DIR%/}"
IOPS_LOG="${LOG_DIR}/fio-iops.log"
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

run "fio --filename='${FILENAME}' --size=1G --direct=1 --rw=randrw --bs=4k --ioengine=${ENGINE} --iodepth=256 --runtime=120 --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1" "${IOPS_LOG}"

run "fio --filename='${FILENAME}' --direct=1 --rw=read --bs=1M --ioengine=${ENGINE} --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-read --eta-newline=1" "${SEQ_READ_LOG}"

run "fio --filename='${FILENAME}' --direct=1 --rw=write --bs=1M --ioengine=${ENGINE} --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-write --eta-newline=1" "${SEQ_WRITE_LOG}"

echo "Logs written to:"
printf '  %s\n  %s\n  %s\n' "${IOPS_LOG}" "${SEQ_READ_LOG}" "${SEQ_WRITE_LOG}"
