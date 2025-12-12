# 性能测试

`libaio`为 Linux 异步 IO 引擎；本次测试在 t2.micro（cn-north-1）实例上进行。

## IOPS test: random read/write

```sh
fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randrw --bs=4k \
    --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
    --group_reporting --name=iops-test-job --eta-newline=1
```

```
iops-test-job: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=256
...
fio-3.36
Starting 4 processes
iops-test-job: Laying out IO file (1 file / 1024MiB)

iops-test-job: (groupid=0, jobs=4): err= 0: pid=2204150: Fri Dec 12 15:45:09 2025
  read: IOPS=1543, BW=6048KiB/s (6194kB/s)(723MiB/120024msec)
    slat (usec): min=3, max=31796, avg=1290.92, stdev=417.94
    clat (msec): min=19, max=382, avg=325.56, stdev=28.21
     lat (msec): min=19, max=384, avg=326.85, stdev=28.32
    clat percentiles (msec):
     |  1.00th=[  234],  5.00th=[  317], 10.00th=[  321], 20.00th=[  321],
     | 30.00th=[  326], 40.00th=[  326], 50.00th=[  330], 60.00th=[  330],
     | 70.00th=[  330], 80.00th=[  334], 90.00th=[  338], 95.00th=[  342],
     | 99.00th=[  351], 99.50th=[  355], 99.90th=[  363], 99.95th=[  368],
     | 99.99th=[  372]
   bw (  KiB/s): min= 2441, max=13701, per=99.79%, avg=6036.64, stdev=370.38, samples=956
   iops        : min=  610, max= 3424, avg=1508.79, stdev=92.59, samples=956
  write: IOPS=1542, BW=6048KiB/s (6193kB/s)(723MiB/120024msec); 0 zone resets
    slat (usec): min=3, max=32675, avg=1287.17, stdev=431.26
    clat (msec): min=19, max=475, avg=335.55, stdev=31.42
     lat (msec): min=19, max=476, avg=336.84, stdev=31.52
    clat percentiles (msec):
     |  1.00th=[  222],  5.00th=[  321], 10.00th=[  326], 20.00th=[  330],
     | 30.00th=[  330], 40.00th=[  334], 50.00th=[  338], 60.00th=[  342],
     | 70.00th=[  342], 80.00th=[  347], 90.00th=[  355], 95.00th=[  359],
     | 99.00th=[  388], 99.50th=[  401], 99.90th=[  422], 99.95th=[  430],
     | 99.99th=[  451]
   bw (  KiB/s): min= 5128, max=14918, per=99.80%, avg=6157.61, stdev=163.82, samples=957
   iops        : min= 1282, max= 3729, avg=1539.20, stdev=40.95, samples=957
  lat (msec)   : 20=0.01%, 50=0.69%, 100=0.09%, 250=0.26%, 500=98.96%
  cpu          : usr=0.64%, sys=1.22%, ctx=368694, majf=0, minf=44
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=185208,185108,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=6048KiB/s (6194kB/s), 6048KiB/s-6048KiB/s (6194kB/s-6194kB/s), io=723MiB (759MB), run=120024-120024msec
  WRITE: bw=6048KiB/s (6193kB/s), 6048KiB/s-6048KiB/s (6193kB/s-6193kB/s), io=723MiB (758MB), run=120024-120024msec

Disk stats (read/write):
  xvda: ios=185167/185092, sectors=1481448/1481216, merge=13/56, ticks=2879057/4789722, in_queue=7668778, util=94.86%
```

## Throughput test: sequential read

```sh
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-read --eta-newline=1
```

```
throughput-read: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
fio-3.36
Starting 1 process

throughput-read: (groupid=0, jobs=1): err= 0: pid=2204161: Fri Dec 12 07:47:10 2025
  read: IOPS=61, BW=61.6MiB/s (64.6MB/s)(7396MiB/120134msec)
    slat (usec): min=455, max=43106, avg=16216.18, stdev=1693.97
    clat (msec): min=56, max=1141, avg=1023.11, stdev=76.65
     lat (msec): min=56, max=1158, avg=1039.32, stdev=77.73
    clat percentiles (msec):
     |  1.00th=[  600],  5.00th=[ 1028], 10.00th=[ 1028], 20.00th=[ 1028],
     | 30.00th=[ 1028], 40.00th=[ 1028], 50.00th=[ 1036], 60.00th=[ 1036],
     | 70.00th=[ 1036], 80.00th=[ 1036], 90.00th=[ 1036], 95.00th=[ 1036],
     | 99.00th=[ 1036], 99.50th=[ 1036], 99.90th=[ 1053], 99.95th=[ 1099],
     | 99.99th=[ 1150]
   bw (  KiB/s): min=53248, max=73728, per=99.26%, avg=62574.93, stdev=1384.95, samples=240
   iops        : min=   52, max=   72, avg=61.11, stdev= 1.35, samples=240
  lat (msec)   : 100=0.16%, 250=0.24%, 500=0.42%, 750=0.42%, 1000=0.43%
  lat (msec)   : 2000=98.32%
  cpu          : usr=0.06%, sys=0.74%, ctx=58796, majf=0, minf=16395
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.2%, 32=0.4%, >=64=99.1%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=7396,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=61.6MiB/s (64.6MB/s), 61.6MiB/s-61.6MiB/s (64.6MB/s-64.6MB/s), io=7396MiB (7755MB), run=120134-120134msec

Disk stats (read/write):
  xvda: ios=59058/104, sectors=15117360/992, merge=0/18, ticks=7658329/9019, in_queue=7667348, util=99.00%
```

## Throughput test: sequential write

```sh
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-write --eta-newline=1
```

```
throughput-write: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
fio-3.36
Starting 1 process

throughput-write: (groupid=0, jobs=1): err= 0: pid=2204170: Fri Dec 12 15:49:10 2025
  write: IOPS=61, BW=61.6MiB/s (64.6MB/s)(7396MiB/120136msec); 0 zone resets
    slat (usec): min=47, max=129704, avg=16215.59, stdev=3258.33
    clat (msec): min=91, max=1146, avg=1022.95, stdev=77.23
     lat (msec): min=92, max=1162, avg=1039.17, stdev=78.29
    clat percentiles (msec):
     |  1.00th=[  592],  5.00th=[ 1028], 10.00th=[ 1028], 20.00th=[ 1028],
     | 30.00th=[ 1028], 40.00th=[ 1028], 50.00th=[ 1036], 60.00th=[ 1036],
     | 70.00th=[ 1036], 80.00th=[ 1036], 90.00th=[ 1036], 95.00th=[ 1036],
     | 99.00th=[ 1053], 99.50th=[ 1053], 99.90th=[ 1133], 99.95th=[ 1150],
     | 99.99th=[ 1150]
   bw (  KiB/s): min=53248, max=73728, per=99.26%, avg=62574.93, stdev=1410.06, samples=240
   iops        : min=   52, max=   72, avg=61.11, stdev= 1.38, samples=240
  lat (msec)   : 100=0.14%, 250=0.28%, 500=0.42%, 750=0.43%, 1000=0.73%
  lat (msec)   : 2000=98.00%
  cpu          : usr=0.33%, sys=0.82%, ctx=58596, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.1%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,7396,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=61.6MiB/s (64.6MB/s), 61.6MiB/s-61.6MiB/s (64.6MB/s-64.6MB/s), io=7396MiB (7755MB), run=120136-120136msec

Disk stats (read/write):
  xvda: ios=2/59176, sectors=16/15142528, merge=0/21, ticks=38/7663759, in_queue=7663796, util=98.85%
```
