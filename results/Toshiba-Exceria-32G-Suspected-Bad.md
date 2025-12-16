# Toshiba-Exceria-32G（疑似坏卡样本）性能测试

备注：这张卡随机写 IOPS 异常低，疑似介质故障或兼容性问题；结果仅用于展示“异常样本”，不代表该型号正常水平。

介质：Toshiba Exceria 32G（SD 卡，挂载点：`/Volumes/DR-05X`；系统名：`Toshiba-Exceria-32G-Suspected-Bad`）

使用脚本：`run-fio.sh`（macOS：`ioengine=posixaio`）

运行命令：

```sh
cd /Volumes/DR-05X
curl -fsSL https://raw.githubusercontent.com/edwardtoday/fio-tests/refs/heads/main/run-fio.sh | bash -s -- .
```

说明：脚本会在当前目录创建临时文件 `fio-test.bin`，跑完自动删除；日志保留为 `fio-*.log`。

## 随机写（fio-randwrite.log）

```text
randwrite-qd4: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=4
fio-3.41
Starting 1 process
randwrite-qd4: Laying out IO file (1 file / 1024MiB)

randwrite-qd4: (groupid=0, jobs=1): err= 0: pid=51776: Fri Dec 12 23:34:08 2025
  write: IOPS=1, BW=5771B/s (5771B/s)(696KiB/123484msec); 0 zone resets
    slat (nsec): min=0, max=75000, avg=2298.85, stdev=5923.63
    clat (msec): min=4, max=29886, avg=2838.67, stdev=5291.87
     lat (msec): min=4, max=29886, avg=2838.67, stdev=5291.87
    clat percentiles (msec):
     |  1.00th=[    5],  5.00th=[    5], 10.00th=[    5], 20.00th=[    5],
     | 30.00th=[    8], 40.00th=[    9], 50.00th=[  207], 60.00th=[  919],
     | 70.00th=[ 2567], 80.00th=[ 3540], 90.00th=[11073], 95.00th=[16308],
     | 99.00th=[17113], 99.50th=[17113], 99.90th=[17113], 99.95th=[17113],
     | 99.99th=[17113]
   bw (  KiB/s): min=    7, max=  219, per=100.00%, avg=40.94, stdev=54.54, samples=33
   iops        : min=    1, max=   54, avg= 9.64, stdev=13.71, samples=33
  lat (msec)   : 10=40.80%, 50=2.30%, 100=4.02%, 250=5.17%, 500=1.15%
  lat (msec)   : 750=2.30%, 1000=8.05%, 2000=4.60%, >=2000=31.61%
  cpu          : usr=0.00%, sys=0.01%, ctx=592, majf=0, minf=9
  IO depths    : 1=2.3%, 2=4.6%, 4=93.1%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,174,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=4

Run status group 0 (all jobs):
  WRITE: bw=5771B/s (5771B/s), 5771B/s-5771B/s (5771B/s-5771B/s), io=696KiB (713kB), run=123484-123484msec
```

## 随机读（fio-randread.log）

```text
randread-qd4: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=4
fio-3.41
Starting 1 process

randread-qd4: (groupid=0, jobs=1): err= 0: pid=51919: Fri Dec 12 23:36:09 2025
  read: IOPS=1461, BW=5848KiB/s (5988kB/s)(685MiB/120002msec)
    slat (nsec): min=0, max=209000, avg=1047.40, stdev=1441.12
    clat (usec): min=660, max=930281, avg=2734.29, stdev=12598.65
     lat (usec): min=662, max=930282, avg=2735.33, stdev=12598.65
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    3], 20.00th=[    3],
     | 30.00th=[    3], 40.00th=[    3], 50.00th=[    3], 60.00th=[    3],
     | 70.00th=[    3], 80.00th=[    3], 90.00th=[    3], 95.00th=[    3],
     | 99.00th=[    4], 99.50th=[    4], 99.90th=[    8], 99.95th=[   16],
     | 99.99th=[  860]
   bw (  KiB/s): min=   31, max= 6561, per=100.00%, avg=5977.32, stdev=1307.06, samples=231
   iops        : min=    7, max= 1640, avg=1494.00, stdev=326.82, samples=231
  lat (usec)   : 750=0.01%
  lat (msec)   : 2=0.02%, 4=99.68%, 10=0.22%, 20=0.03%, 50=0.02%
  lat (msec)   : 100=0.01%, 750=0.01%, 1000=0.02%
  cpu          : usr=0.42%, sys=2.50%, ctx=543974, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=175432,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=4

Run status group 0 (all jobs):
   READ: bw=5848KiB/s (5988kB/s), 5848KiB/s-5848KiB/s (5988kB/s-5988kB/s), io=685MiB (719MB), run=120002-120002msec
```

## 顺序读（fio-seq-read.log）

```text
throughput-read: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-read: (groupid=0, jobs=1): err= 0: pid=52090: Fri Dec 12 23:38:10 2025
  read: IOPS=78, BW=78.1MiB/s (81.9MB/s)(9389MiB/120186msec)
    slat (nsec): min=0, max=407000, avg=2211.42, stdev=5033.37
    clat (msec): min=119, max=1040, avg=204.77, stdev=75.19
     lat (msec): min=119, max=1040, avg=204.77, stdev=75.19
    clat percentiles (msec):
     |  1.00th=[  144],  5.00th=[  167], 10.00th=[  176], 20.00th=[  182],
     | 30.00th=[  192], 40.00th=[  192], 50.00th=[  194], 60.00th=[  205],
     | 70.00th=[  205], 80.00th=[  205], 90.00th=[  222], 95.00th=[  241],
     | 99.00th=[  439], 99.50th=[  953], 99.90th=[ 1028], 99.95th=[ 1045],
     | 99.99th=[ 1045]
   bw (  KiB/s): min= 8062, max=96565, per=100.00%, avg=81016.98, stdev=11399.91, samples=234
   iops        : min=    7, max=   94, avg=78.68, stdev=11.18, samples=234
  lat (msec)   : 250=96.57%, 500=2.53%, 750=0.04%, 1000=0.62%, 2000=0.23%
  cpu          : usr=0.05%, sys=0.68%, ctx=36707, majf=0, minf=1100
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.5%, 16=52.4%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.8%, 8=1.1%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=9389,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=78.1MiB/s (81.9MB/s), 78.1MiB/s-78.1MiB/s (81.9MB/s-81.9MB/s), io=9389MiB (9845MB), run=120186-120186msec
```

## 顺序写（fio-seq-write.log）

```text
throughput-write: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-write: (groupid=0, jobs=1): err= 0: pid=52232: Fri Dec 12 23:40:14 2025
  write: IOPS=10, BW=10.5MiB/s (11.0MB/s)(1285MiB/122340msec); 0 zone resets
    slat (nsec): min=1000, max=1386.0k, avg=26799.22, stdev=52243.13
    clat (msec): min=343, max=4378, avg=1519.75, stdev=665.15
     lat (msec): min=343, max=4378, avg=1519.78, stdev=665.15
    clat percentiles (msec):
     |  1.00th=[  443],  5.00th=[  676], 10.00th=[  701], 20.00th=[  827],
     | 30.00th=[ 1116], 40.00th=[ 1385], 50.00th=[ 1519], 60.00th=[ 1603],
     | 70.00th=[ 1804], 80.00th=[ 2039], 90.00th=[ 2333], 95.00th=[ 2702],
     | 99.00th=[ 3842], 99.50th=[ 4144], 99.90th=[ 4396], 99.95th=[ 4396],
     | 99.99th=[ 4396]
   bw (  KiB/s): min= 2007, max=38149, per=100.00%, avg=14590.80, stdev=8469.68, samples=178
   iops        : min=    1, max=   37, avg=13.48, stdev= 8.38, samples=178
  lat (msec)   : 500=1.79%, 750=16.34%, 1000=8.17%, 2000=53.23%, >=2000=20.47%
  cpu          : usr=0.02%, sys=0.13%, ctx=5598, majf=0, minf=11
  IO depths    : 1=0.1%, 2=0.2%, 4=0.3%, 8=47.4%, 16=52.1%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=97.9%, 8=1.7%, 16=0.4%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,1285,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=10.5MiB/s (11.0MB/s), 10.5MiB/s-10.5MiB/s (11.0MB/s-11.0MB/s), io=1285MiB (1347MB), run=122340-122340msec
```
