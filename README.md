# fio 测试说明

GitHub Pages 报告页面：`https://edwardtoday.github.io/fio-tests/`（首页为 `index.html`，内容与 `fio-report.html` 一致）。

## macOS 与 Linux 手动测试命令

- macOS：`--ioengine=posixaio`
  - 随机读写 IOPS：`fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randrw --bs=4k --ioengine=posixaio --iodepth=256 --runtime=120 --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1`
  - 顺序读：`fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-read --eta-newline=1`
  - 顺序写：`fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-write --eta-newline=1`

- Linux：`--ioengine=libaio`（如缺失，先安装 `fio` 和 `libaio1`）
  - 随机读写 IOPS：`fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randrw --bs=4k --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1`
  - 顺序读：`fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-read --eta-newline=1`
  - 顺序写：`fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-write --eta-newline=1`

完成后删除测试文件：`rm ./fio-test.bin`

## 一键脚本（示例）

仓库提供 `run-fio.sh`，按平台自动选择 `posixaio/libaio`，输出日志：

- `fio-iops.log`
- `fio-seq-read.log`
- `fio-seq-write.log`

在当前目录运行（默认路径为`.`，也可省略参数）：
```sh
bash run-fio.sh .
# 或：bash run-fio.sh
```

如托管脚本到 HTTPS（当前脚本地址已托管为 `https://us-east-1.linodeobjects.com/sansi-share/2025/run-fio.sh`），一行执行：
```sh
curl -fsSL https://us-east-1.linodeobjects.com/sansi-share/2025/run-fio.sh | bash -s -- .
```

若当前目录需 sudo 权限：
```sh
curl -fsSL https://us-east-1.linodeobjects.com/sansi-share/2025/run-fio.sh | sudo bash -s -- .
```

如需要 `sudo`（无写权限或设备需直写），在命令前加 `sudo`。
* Amazon Linux 1 (AL AMI 2018.03) 如遇 `curl: (1) Protocol "https" not supported or disabled in libcurl`，先更新/安装带 TLS 的 curl：`sudo yum install -y curl nss ca-certificates`（或 `sudo yum update -y curl`）后再运行上述一键命令。
