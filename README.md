# fio 测试说明

GitHub Pages 报告页面：`https://edwardtoday.github.io/fio-tests/`（首页为 `index.html`）。

测试结果 Markdown：`results/`（`results/*.md`）。

## 一键脚本（推荐）

仓库提供 `run-fio.sh`，按平台自动选择 `posixaio/libaio`，并输出日志到目标目录：

- `fio-randread.log`（4K 随机读，QD=4）
- `fio-randwrite.log`（4K 随机写，QD=4）
- `fio-seq-read.log`（1M 顺序读，QD=64）
- `fio-seq-write.log`（1M 顺序写，QD=64）

当前目录运行（示例固定用 `.`）：

```sh
curl -fsSL https://raw.githubusercontent.com/edwardtoday/fio-tests/refs/heads/main/run-fio.sh | bash -s -- .
```

需要 sudo（当前目录无写权限或需要直写设备）：

```sh
curl -fsSL https://raw.githubusercontent.com/edwardtoday/fio-tests/refs/heads/main/run-fio.sh | sudo bash -s -- .
```

备用脚本地址（Linode Object Storage）：

- HTTPS：`https://us-east-1.linodeobjects.com/sansi-share/2025/run-fio.sh`
- HTTP（兼容 Amazon Linux 1 这种 curl 不支持 https 的环境）：`http://us-east-1.linodeobjects.com/sansi-share/2025/run-fio.sh`

Amazon Linux 1 (AL AMI 2018.03) 如遇 `curl: (1) Protocol "https" not supported or disabled in libcurl`：

```sh
curl -fsSL http://us-east-1.linodeobjects.com/sansi-share/2025/run-fio.sh | bash -s -- .
```

如需继续使用 HTTPS，可先升级/安装带 TLS 的 curl（是否可用取决于系统仓库版本）：

```sh
sudo yum install -y curl nss ca-certificates || sudo yum update -y curl
```

## macOS 与 Linux 手动测试命令（可选）

- macOS：`--ioengine=posixaio`
  - 随机写（4K，QD=4）：`fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randwrite --bs=4k --ioengine=posixaio --iodepth=4 --runtime=120 --numjobs=1 --time_based --group_reporting --name=randwrite-qd4 --eta-newline=1`
  - 随机读（4K，QD=4）：`fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randread --bs=4k --ioengine=posixaio --iodepth=4 --runtime=120 --numjobs=1 --time_based --group_reporting --name=randread-qd4 --eta-newline=1`
  - 顺序读：`fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-read --eta-newline=1`
  - 顺序写：`fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-write --eta-newline=1`

- Linux：`--ioengine=libaio`（如缺失，先安装 `fio` 和 `libaio1`）
  - 随机写（4K，QD=4）：`fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=4 --runtime=120 --numjobs=1 --time_based --group_reporting --name=randwrite-qd4 --eta-newline=1`
  - 随机读（4K，QD=4）：`fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randread --bs=4k --ioengine=libaio --iodepth=4 --runtime=120 --numjobs=1 --time_based --group_reporting --name=randread-qd4 --eta-newline=1`
  - 顺序读：`fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-read --eta-newline=1`
  - 顺序写：`fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-write --eta-newline=1`

完成后删除测试文件：`rm ./fio-test.bin`
