# Lexar-Silver-Plus-64G 性能测试

介质：Lexar Silver Plus 64G（挂载点：`/Volumes/Untitled`）

使用脚本：`run-fio.sh`（macOS：`ioengine=posixaio`）

运行命令：

```sh
cd /Volumes/Untitled
curl -fsSL https://raw.githubusercontent.com/edwardtoday/fio-tests/refs/heads/main/run-fio.sh | bash -s -- .
```

说明：脚本会在当前目录创建临时文件 `fio-test.bin`，跑完自动删除；日志保留为 `fio-*.log`。

## 随机写（fio-randwrite.log）

```text
randwrite-qd4: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=4
fio-3.41
Starting 1 process
randwrite-qd4: Laying out IO file (1 file / 1024MiB)

randwrite-qd4: (groupid=0, jobs=1): err= 0: pid=78784: Sat Dec 13 09:28:17 2025
  write: IOPS=828, BW=3313KiB/s (3393kB/s)(388MiB/120004msec); 0 zone resets
    slat (nsec): min=0, max=27009k, avg=1793.02, stdev=85734.89
    clat (nsec): min=1000, max=6024.5M, avg=4825297.02, stdev=51027234.03
     lat (usec): min=5, max=6024.5k, avg=4827.09, stdev=51027.36
    clat percentiles (usec):
     |  1.00th=[      6],  5.00th=[   2737], 10.00th=[   3130],
     | 20.00th=[   3490], 30.00th=[   3687], 40.00th=[   3818],
     | 50.00th=[   4015], 60.00th=[   4178], 70.00th=[   4293],
     | 80.00th=[   4424], 90.00th=[   4686], 95.00th=[   4883],
     | 99.00th=[  17695], 99.50th=[  24773], 99.90th=[  83362],
     | 99.95th=[ 120062], 99.99th=[1098908]
   bw (  KiB/s): min=   31, max= 4419, per=100.00%, avg=3686.43, stdev=909.12, samples=214
   iops        : min=    7, max= 1104, avg=921.20, stdev=227.25, samples=214
  lat (usec)   : 2=0.01%, 10=1.74%, 20=0.12%, 50=0.04%, 100=0.01%
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.13%, 4=47.86%, 10=48.94%, 20=0.36%, 50=0.61%
  lat (msec)   : 100=0.12%, 250=0.04%, 500=0.01%, 1000=0.01%, 2000=0.01%
  lat (msec)   : >=2000=0.01%
  cpu          : usr=0.24%, sys=3.43%, ctx=312601, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.2%, 4=99.8%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,99396,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=4

Run status group 0 (all jobs):
  WRITE: bw=3313KiB/s (3393kB/s), 3313KiB/s-3313KiB/s (3393kB/s-3393kB/s), io=388MiB (407MB), run=120004-120004msec
```

## 随机读（fio-randread.log）

```text
randread-qd4: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=4
fio-3.41
Starting 1 process

randread-qd4: (groupid=0, jobs=1): err= 0: pid=79656: Sat Dec 13 09:30:18 2025
  read: IOPS=3406, BW=13.3MiB/s (14.0MB/s)(1597MiB/120001msec)
    slat (nsec): min=0, max=3596.0k, avg=893.01, stdev=7086.42
    clat (usec): min=5, max=11579, avg=1172.80, stdev=182.59
     lat (usec): min=6, max=11580, avg=1173.69, stdev=182.87
    clat percentiles (usec):
     |  1.00th=[ 1029],  5.00th=[ 1074], 10.00th=[ 1090], 20.00th=[ 1123],
     | 30.00th=[ 1139], 40.00th=[ 1156], 50.00th=[ 1172], 60.00th=[ 1172],
     | 70.00th=[ 1188], 80.00th=[ 1205], 90.00th=[ 1221], 95.00th=[ 1254],
     | 99.00th=[ 1303], 99.50th=[ 1614], 99.90th=[ 4146], 99.95th=[ 4490],
     | 99.99th=[ 4817]
   bw (  KiB/s): min=12518, max=14807, per=100.00%, avg=13635.01, stdev=214.57, samples=238
   iops        : min= 3129, max= 3701, avg=3408.43, stdev=53.63, samples=238
  lat (usec)   : 10=0.02%, 20=0.01%, 50=0.01%, 500=0.01%, 750=0.01%
  lat (usec)   : 1000=0.24%
  lat (msec)   : 2=99.30%, 4=0.32%, 10=0.10%, 20=0.01%
  cpu          : usr=0.89%, sys=3.99%, ctx=1247445, majf=0, minf=11
  IO depths    : 1=0.1%, 2=0.1%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=408728,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=4

Run status group 0 (all jobs):
   READ: bw=13.3MiB/s (14.0MB/s), 13.3MiB/s-13.3MiB/s (14.0MB/s-14.0MB/s), io=1597MiB (1674MB), run=120001-120001msec
```

## 顺序读（fio-seq-read.log）

```text
throughput-read: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-read: (groupid=0, jobs=1): err= 0: pid=80589: Sat Dec 13 09:32:18 2025
  read: IOPS=86, BW=86.8MiB/s (91.0MB/s)(10.2GiB/120139msec)
    slat (nsec): min=0, max=338000, avg=1616.44, stdev=3854.59
    clat (msec): min=36, max=311, avg=184.31, stdev=14.19
     lat (msec): min=37, max=311, avg=184.31, stdev=14.19
    clat percentiles (msec):
     |  1.00th=[  148],  5.00th=[  161], 10.00th=[  163], 20.00th=[  174],
     | 30.00th=[  182], 40.00th=[  184], 50.00th=[  186], 60.00th=[  194],
     | 70.00th=[  194], 80.00th=[  197], 90.00th=[  197], 95.00th=[  199],
     | 99.00th=[  207], 99.50th=[  211], 99.90th=[  232], 99.95th=[  243],
     | 99.99th=[  300]
   bw (  KiB/s): min=77053, max=99555, per=100.00%, avg=88919.17, stdev=2943.21, samples=238
   iops        : min=   75, max=   97, avg=86.62, stdev= 2.89, samples=238
  lat (msec)   : 50=0.03%, 100=0.02%, 250=99.90%, 500=0.05%
  cpu          : usr=0.05%, sys=0.88%, ctx=38180, majf=0, minf=1142
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.3%, 16=52.7%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.6%, 8=0.4%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=10426,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=86.8MiB/s (91.0MB/s), 86.8MiB/s-86.8MiB/s (91.0MB/s-91.0MB/s), io=10.2GiB (10.9GB), run=120139-120139msec
```

## 顺序写（fio-seq-write.log）

```text
throughput-write: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-write: (groupid=0, jobs=1): err= 0: pid=80651: Sat Dec 13 09:34:19 2025
  write: IOPS=69, BW=69.2MiB/s (72.6MB/s)(8322MiB/120195msec); 0 zone resets
    slat (nsec): min=0, max=202000, avg=20158.26, stdev=27338.69
    clat (msec): min=108, max=389, avg=230.97, stdev=18.78
     lat (msec): min=108, max=389, avg=230.99, stdev=18.79
    clat percentiles (msec):
     |  1.00th=[  180],  5.00th=[  199], 10.00th=[  205], 20.00th=[  215],
     | 30.00th=[  226], 40.00th=[  228], 50.00th=[  234], 60.00th=[  241],
     | 70.00th=[  243], 80.00th=[  245], 90.00th=[  251], 95.00th=[  255],
     | 99.00th=[  266], 99.50th=[  275], 99.90th=[  309], 99.95th=[  330],
     | 99.99th=[  388]
   bw (  KiB/s): min=63109, max=83136, per=100.00%, avg=70946.35, stdev=2722.58, samples=238
   iops        : min=   61, max=   81, avg=68.86, stdev= 2.69, samples=238
  lat (msec)   : 250=88.45%, 500=11.55%
  cpu          : usr=0.16%, sys=0.85%, ctx=30975, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.4%, 16=52.5%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.3%, 8=0.7%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,8322,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=69.2MiB/s (72.6MB/s), 69.2MiB/s-69.2MiB/s (72.6MB/s-72.6MB/s), io=8322MiB (8726MB), run=120195-120195msec
```

