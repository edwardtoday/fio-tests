# fio 测试说明

GitHub Pages 报告页面：`https://edwardtoday.github.io/fio-tests/`（首页为 `index.html`）。

测试结果 Markdown：`results/`（`results/*.md`）。

维护者：如需搭建 n8n 上报通道（不让跑测试的人接触 GitHub 凭证），见 `docs/n8n-setup.md`。

## 开发：聚合结构化数据

将 `results/runs/*.json` 聚合为 `results/data.json`：

```sh
python3 scripts/aggregate_runs.py
```

## 一键脚本（推荐）

仓库提供 `run-fio.sh`，按平台自动选择 `posixaio/libaio`，支持多套 profile，并输出 JSON 结果到目标目录：

- `fio-*.fio.json`：每个 case 的 fio 原始 JSON 输出（用于提取 IOPS/MiB/s/p95/p99）
- `fio-run-<run_id>.json`：归一化后的结构化结果（包含 `case_key`、指标与元信息）
- `fio-manifest-<run_id>.tsv`：脚本内部的 case 清单（辅助调试）

Profile：

- `quick`：`full/standard` 的子集（参数一致，仅减少 case 数量）：4K 随机读/写 @QD1 + 1M 顺序读/写 + 4K 持续随机写（3min，QD4）
- `standard`：4K 随机读/写 @QD1/@QD4/@QD16/@QD32 + 4K randrw 70/30 @QD1/@QD4 + 顺序读/写（128K/1M/4M）+ 4K 持续随机写（3min，QD4）
- `full`：`standard` + 持续顺序写（16GiB 或可用空间 60%）+ 持续随机写（10min）+ DB-like（buffered+fdatasync + 8K/16K 随机读写 @QD1/@QD4）
- `db`：4K/8K/16K 随机读/写 @QD1/@QD4 + `fdatasync` 写入测试（buffered）

当前目录运行（示例固定用 `.`）：

```sh
curl -fsSL https://raw.githubusercontent.com/edwardtoday/fio-tests/refs/heads/main/run-fio.sh | bash -s -- --profile quick .
```

默认行为：脚本会复用当前目录中已存在且“参数匹配”的 `fio-*.fio.json`，只补跑缺失的 case（避免重复耗时）；如需强制全部重跑，可加 `--force`。

如需上传（`curl | bash` 场景建议显式提供系统名；否则脚本会尝试从 `/dev/tty` 交互读取，或从 `FIO_TESTS_SYSTEM` 读取）：

```sh
curl -fsSL https://raw.githubusercontent.com/edwardtoday/fio-tests/refs/heads/main/run-fio.sh | \
env FIO_TESTS_WEBHOOK_SECRET='<secret>' \
bash -s -- --profile full --upload --system 'Your-System-Name' .
```

注意：示例中的 URL 不要加尖括号（`<...>`），否则会被 shell 当作重定向导致语法错误。

说明：当 `--repo` 为默认值 `edwardtoday/fio-tests` 且未设置 `FIO_TESTS_WEBHOOK_URL` 时，脚本会使用默认 webhook URL；如你 fork 了仓库或使用自建 n8n，请显式设置 `FIO_TESTS_WEBHOOK_URL` 或使用 `--webhook-url`。

注意：在 `cmd1 | cmd2` 这种管道里，把 `FIO_TESTS_WEBHOOK_SECRET=...` 写在 `curl` 前面只会影响 `curl` 进程，不会传递给 `bash`；请按上面的写法用 `env ... bash` 或者提前 `export FIO_TESTS_WEBHOOK_SECRET=...`。

如遇 SSH 断线等原因导致脚本中断，但目录里已经生成了 `fio-manifest-*.tsv` 与 `fio-*.fio.json`，可用 `--finalize-only` 重新生成 `fio-run-*.json` 并上传（不会重跑 fio）：

```sh
FIO_TESTS_WEBHOOK_URL='https://n8n.sansi.io/webhook/fio-tests-372bba2a-faab-4927-b839-f8e7a1e0d7b5' \
FIO_TESTS_WEBHOOK_SECRET='<secret>' \
curl -fsSL https://raw.githubusercontent.com/edwardtoday/fio-tests/refs/heads/main/run-fio.sh | bash -s -- --finalize-only --upload --system 'Your-System-Name' .
```

需要 sudo（当前目录无写权限或需要直写设备）：

```sh
curl -fsSL https://raw.githubusercontent.com/edwardtoday/fio-tests/refs/heads/main/run-fio.sh | sudo bash -s -- --profile quick .
```

可选：上传到 webhook（需要配置 `FIO_TESTS_WEBHOOK_URL`，可选 `FIO_TESTS_WEBHOOK_SECRET`）：

```sh
FIO_TESTS_WEBHOOK_URL='https://your-n8n/webhook/...' \
curl -fsSL https://raw.githubusercontent.com/edwardtoday/fio-tests/refs/heads/main/run-fio.sh | \
env FIO_TESTS_WEBHOOK_SECRET='<secret>' \
bash -s -- --profile quick --upload --system 'Your-System-Name' .
```

备用脚本地址（Linode Object Storage）：

- HTTPS：`https://us-east-1.linodeobjects.com/sansi-share/2025/run-fio.sh`
- HTTP（兼容 Amazon Linux 1 这种 curl 不支持 https 的环境）：`http://us-east-1.linodeobjects.com/sansi-share/2025/run-fio.sh`

仓库在每次 push 后会通过 GitHub Actions 自动把 `run-fio.sh` 同步到上述 Linode Object Storage 地址（需在仓库 Secrets 配置 `LINODE_OBJECT_STORAGE_ACCESS_KEY` / `LINODE_OBJECT_STORAGE_SECRET_KEY`）。

Amazon Linux 1 (AL AMI 2018.03) 如遇 `curl: (1) Protocol "https" not supported or disabled in libcurl`：

```sh
curl -fsSL http://us-east-1.linodeobjects.com/sansi-share/2025/run-fio.sh | bash -s -- --profile quick .
```

如需继续使用 HTTPS，可先升级/安装带 TLS 的 curl（是否可用取决于系统仓库版本）：

```sh
sudo yum install -y curl nss ca-certificates || sudo yum update -y curl
```

## macOS 与 Linux 手动测试命令（可选）

- macOS：`--ioengine=posixaio`
  - 随机写（4K，QD=1）：`fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randwrite --bs=4k --ioengine=posixaio --iodepth=1 --runtime=60 --numjobs=1 --time_based --group_reporting --name=randwrite-4k-qd1 --eta-newline=1`
  - 随机读（4K，QD=1）：`fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randread --bs=4k --ioengine=posixaio --iodepth=1 --runtime=60 --numjobs=1 --time_based --group_reporting --name=randread-4k-qd1 --eta-newline=1`
  - 顺序读：`fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-read --eta-newline=1`
  - 顺序写：`fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-write --eta-newline=1`

- Linux：`--ioengine=libaio`（如缺失，先安装 `fio` 和 `libaio1`）
  - 随机写（4K，QD=1）：`fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --runtime=60 --numjobs=1 --time_based --group_reporting --name=randwrite-4k-qd1 --eta-newline=1`
  - 随机读（4K，QD=1）：`fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randread --bs=4k --ioengine=libaio --iodepth=1 --runtime=60 --numjobs=1 --time_based --group_reporting --name=randread-4k-qd1 --eta-newline=1`
  - 顺序读：`fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-read --eta-newline=1`
  - 顺序写：`fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-write --eta-newline=1`

完成后删除测试文件：`rm ./fio-test.bin`
