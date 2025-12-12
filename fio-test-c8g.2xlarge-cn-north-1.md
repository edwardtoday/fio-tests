# 性能测试

`libaio` 为 Linux 异步 IO 引擎；本次测试在 c8g.2xlarge（cn-north-1）实例上进行。

## IOPS test: random read/write

```sh
fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randrw --bs=4k \
    --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
    --group_reporting --name=iops-test-job --eta-newline=1
```

```
fio engine: libaio
target file: ./fio-test.bin
---- running: fio --filename='./fio-test.bin' --size=1G --direct=1 --rw=randrw --bs=4k --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1
iops-test-job: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=256
...
fio-3.36
Starting 4 processes
iops-test-job: Laying out IO file (1 file / 1024MiB)

iops-test-job: (groupid=0, jobs=4): err= 0: pid=1126358: Fri Dec 12 07:53:31 2025
  read: IOPS=1500, BW=6002KiB/s (6146kB/s)(704MiB/120043msec)
    slat (nsec): min=1017, max=63218k, avg=1296496.45, stdev=3148916.89
    clat (msec): min=8, max=690, avg=339.68, stdev=115.27
     lat (msec): min=8, max=701, avg=340.98, stdev=115.64
    clat percentiles (msec):
     |  1.00th=[  144],  5.00th=[  163], 10.00th=[  180], 20.00th=[  215],
     | 30.00th=[  288], 40.00th=[  321], 50.00th=[  347], 60.00th=[  368],
     | 70.00th=[  401], 80.00th=[  439], 90.00th=[  493], 95.00th=[  531],
     | 99.00th=[  592], 99.50th=[  617], 99.90th=[  642], 99.95th=[  659],
     | 99.99th=[  676]
   bw (  KiB/s): min= 2896, max=14064, per=99.74%, avg=5987.03, stdev=522.94, samples=960
   iops        : min=  724, max= 3516, avg=1496.76, stdev=130.74, samples=960
  write: IOPS=1500, BW=6001KiB/s (6145kB/s)(703MiB/120043msec); 0 zone resets
    slat (nsec): min=1130, max=45656k, avg=1366025.81, stdev=3199650.03
    clat (msec): min=9, max=691, avg=340.11, stdev=115.60
     lat (msec): min=9, max=691, avg=341.47, stdev=116.03
    clat percentiles (msec):
     |  1.00th=[  144],  5.00th=[  163], 10.00th=[  180], 20.00th=[  215],
     | 30.00th=[  288], 40.00th=[  321], 50.00th=[  347], 60.00th=[  372],
     | 70.00th=[  401], 80.00th=[  439], 90.00th=[  493], 95.00th=[  531],
     | 99.00th=[  592], 99.50th=[  617], 99.90th=[  651], 99.95th=[  659],
     | 99.99th=[  676]
   bw (  KiB/s): min= 3008, max=14760, per=99.76%, avg=5986.17, stdev=519.96, samples=960
   iops        : min=  752, max= 3690, avg=1496.54, stdev=129.99, samples=960
  lat (msec)   : 10=0.02%, 20=0.61%, 50=0.04%, 100=0.08%, 250=24.09%
  lat (msec)   : 500=66.18%, 750=8.99%
  cpu          : usr=0.10%, sys=0.35%, ctx=102379, majf=0, minf=46
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=180136,180080,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=6002KiB/s (6146kB/s), 6002KiB/s-6002KiB/s (6146kB/s-6146kB/s), io=704MiB (738MB), run=120043-120043msec
  WRITE: bw=6001KiB/s (6145kB/s), 6001KiB/s-6001KiB/s (6145kB/s-6145kB/s), io=703MiB (738MB), run=120043-120043msec

Disk stats (read/write):
  nvme0n1: ios=180409/182050, merge=67/194, ticks=7143950/7260987, in_queue=14404938, util=98.84%
---- done: ./fio-iops.log
```

## Throughput test: sequential read

```sh
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-read --eta-newline=1
```

```
---- running: fio --filename='./fio-test.bin' --direct=1 --rw=read --bs=1M --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-read --eta-newline=1
throughput-read: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
fio-3.36
Starting 1 process

throughput-read: (groupid=0, jobs=1): err= 0: pid=1127532: Fri Dec 12 07:55:32 2025
  read: IOPS=126, BW=126MiB/s (132MB/s)(14.8GiB/120127msec)
    slat (usec): min=41, max=137086, avg=7924.77, stdev=11423.10
    clat (msec): min=27, max=729, avg=499.82, stdev=51.61
     lat (msec): min=28, max=729, avg=507.74, stdev=52.49
    clat percentiles (msec):
     |  1.00th=[  326],  5.00th=[  435], 10.00th=[  477], 20.00th=[  498],
     | 30.00th=[  502], 40.00th=[  506], 50.00th=[  506], 60.00th=[  506],
     | 70.00th=[  506], 80.00th=[  510], 90.00th=[  523], 95.00th=[  567],
     | 99.00th=[  609], 99.50th=[  617], 99.90th=[  625], 99.95th=[  634],
     | 99.99th=[  659]
   bw (  KiB/s): min=96256, max=284672, per=99.69%, avg=128657.07, stdev=14089.23, samples=240
   iops        : min=   94, max=  278, avg=125.64, stdev=13.76, samples=240
  lat (msec)   : 50=0.58%, 100=0.03%, 250=0.25%, 500=21.05%, 750=78.08%
  cpu          : usr=0.02%, sys=0.84%, ctx=7873, majf=0, minf=16395
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.2%, >=64=99.6%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=15140,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=126MiB/s (132MB/s), 126MiB/s-126MiB/s (132MB/s-132MB/s), io=14.8GiB (15.9GB), run=120127-120127msec

Disk stats (read/write):
  nvme0n1: ios=60562/762, sectors=30952600/13872, merge=0/159, ticks=7567657/73044, in_queue=7640702, util=99.09%
---- done: ./fio-seq-read.log
```

## Throughput test: sequential write

```sh
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-write --eta-newline=1
```

```
---- running: fio --filename='./fio-test.bin' --direct=1 --rw=write --bs=1M --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-write --eta-newline=1
throughput-write: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
fio-3.36
Starting 1 process

throughput-write: (groupid=0, jobs=1): err= 0: pid=1128709: Fri Dec 12 07:57:32 2025
  write: IOPS=125, BW=125MiB/s (131MB/s)(14.7GiB/120128msec); 0 zone resets
    slat (usec): min=41, max=127850, avg=7968.82, stdev=14007.38
    clat (msec): min=73, max=742, avg=502.60, stdev=44.42
     lat (msec): min=73, max=748, avg=510.57, stdev=45.04
    clat percentiles (msec):
     |  1.00th=[  388],  5.00th=[  422], 10.00th=[  460], 20.00th=[  498],
     | 30.00th=[  502], 40.00th=[  502], 50.00th=[  502], 60.00th=[  502],
     | 70.00th=[  502], 80.00th=[  514], 90.00th=[  550], 95.00th=[  584],
     | 99.00th=[  617], 99.50th=[  625], 99.90th=[  676], 99.95th=[  718],
     | 99.99th=[  735]
   bw (  KiB/s): min=102400, max=157696, per=99.69%, avg=127940.27, stdev=6006.49, samples=240
   iops        : min=  100, max=  154, avg=124.94, stdev= 5.87, samples=240
  lat (msec)   : 100=0.02%, 250=0.25%, 500=24.34%, 750=75.40%
  cpu          : usr=0.20%, sys=0.77%, ctx=7215, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.2%, >=64=99.6%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,15056,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=125MiB/s (131MB/s), 125MiB/s-125MiB/s (131MB/s-131MB/s), io=14.7GiB (15.8GB), run=120128-120128msec

Disk stats (read/write):
  nvme0n1: ios=232/60547, sectors=12272/30837704, merge=0/134, ticks=26328/7950583, in_queue=7976912, util=98.92%
---- done: ./fio-seq-write.log
```
