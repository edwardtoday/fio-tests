# 性能测试

`libaio`为 Linux 异步 IO 引擎；本次测试在 UCS-100 1TB 上进行。

## IOPS test: random read/write

```sh
fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randrw --bs=4k \
    --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
    --group_reporting --name=iops-test-job --eta-newline=1
```

```
iops-test-job: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=256
...
fio-3.28
Starting 4 processes
iops-test-job: Laying out IO file (1 file / 1024MiB)

iops-test-job: (groupid=0, jobs=4): err= 0: pid=1174372: Fri Dec 12 15:03:54 2025
  read: IOPS=61.9k, BW=242MiB/s (253MB/s)(28.3GiB/120007msec)
    slat (nsec): min=1291, max=39495k, avg=27786.75, stdev=291828.74
    clat (usec): min=712, max=163642, avg=8982.62, stdev=8694.06
     lat (usec): min=726, max=163649, avg=9010.61, stdev=8716.01
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    5], 10.00th=[    6], 20.00th=[    6],
     | 30.00th=[    7], 40.00th=[    7], 50.00th=[    8], 60.00th=[    8],
     | 70.00th=[    9], 80.00th=[    9], 90.00th=[   12], 95.00th=[   22],
     | 99.00th=[   51], 99.50th=[   71], 99.90th=[   95], 99.95th=[  104],
     | 99.99th=[  128]
   bw (  KiB/s): min=52976, max=383464, per=100.00%, avg=247543.33, stdev=19361.56, samples=956
   iops        : min=13244, max=95866, avg=61885.84, stdev=4840.40, samples=956
  write: IOPS=61.8k, BW=241MiB/s (253MB/s)(28.3GiB/120007msec); 0 zone resets
    slat (nsec): min=1353, max=57176k, avg=28585.39, stdev=298291.75
    clat (usec): min=168, max=161738, avg=7516.00, stdev=8100.22
     lat (usec): min=188, max=161747, avg=7544.79, stdev=8123.42
    clat percentiles (usec):
     |  1.00th=[  1696],  5.00th=[  3556], 10.00th=[  3982], 20.00th=[  4752],
     | 30.00th=[  5080], 40.00th=[  5538], 50.00th=[  5932], 60.00th=[  6194],
     | 70.00th=[  6718], 80.00th=[  7504], 90.00th=[  9634], 95.00th=[ 17957],
     | 99.00th=[ 47449], 99.50th=[ 68682], 99.90th=[ 92799], 99.95th=[ 98042],
     | 99.99th=[123208]
   bw (  KiB/s): min=53600, max=385608, per=100.00%, avg=247348.41, stdev=19368.98, samples=956
   iops        : min=13400, max=96402, avg=61837.10, stdev=4842.25, samples=956
  lat (usec)   : 250=0.01%, 500=0.02%, 750=0.05%, 1000=0.07%
  lat (msec)   : 2=0.71%, 4=5.47%, 10=82.26%, 20=6.49%, 50=3.97%
  lat (msec)   : 100=0.90%, 250=0.05%
  cpu          : usr=6.17%, sys=23.88%, ctx=840390, majf=0, minf=76
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=7424667,7418428,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=242MiB/s (253MB/s), 242MiB/s-242MiB/s (253MB/s-253MB/s), io=28.3GiB (30.4GB), run=120007-120007msec
  WRITE: bw=241MiB/s (253MB/s), 241MiB/s-241MiB/s (253MB/s-253MB/s), io=28.3GiB (30.4GB), run=120007-120007msec

Disk stats (read/write):
  nvme0n1: ios=7421559/7415804, merge=0/165, ticks=59920549/48812545, in_queue=108733223, util=63.10%
```

## Throughput test: sequential read

```sh
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-read --eta-newline=1
```

```
throughput-read: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
fio-3.28
Starting 1 process
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-write --eta-newline=1 | tee seq-write.log

throughput-read: (groupid=0, jobs=1): err= 0: pid=1180927: Fri Dec 12 15:14:29 2025
  read: IOPS=354, BW=354MiB/s (371MB/s)(41.5GiB/120076msec)
    slat (usec): min=36, max=114693, avg=2808.16, stdev=4182.09
    clat (msec): min=38, max=343, avg=177.93, stdev=31.25
     lat (msec): min=39, max=396, avg=180.74, stdev=31.51
    clat percentiles (msec):
     |  1.00th=[   94],  5.00th=[  123], 10.00th=[  150], 20.00th=[  159],
     | 30.00th=[  165], 40.00th=[  171], 50.00th=[  178], 60.00th=[  184],
     | 70.00th=[  190], 80.00th=[  199], 90.00th=[  213], 95.00th=[  230],
     | 99.00th=[  271], 99.50th=[  284], 99.90th=[  313], 99.95th=[  326],
     | 99.99th=[  330]
   bw (  KiB/s): min=266240, max=452608, per=100.00%, avg=362727.36, stdev=34259.81, samples=239
   iops        : min=  260, max=  442, avg=354.23, stdev=33.46, samples=239
  lat (msec)   : 50=0.05%, 100=1.66%, 250=95.71%, 500=2.59%
  cpu          : usr=0.15%, sys=8.20%, ctx=36158, majf=0, minf=16396
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=42507,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=354MiB/s (371MB/s), 354MiB/s-354MiB/s (371MB/s-371MB/s), io=41.5GiB (44.6GB), run=120076-120076msec

Disk stats (read/write):
  nvme0n1: ios=339534/195, merge=0/125, ticks=32291550/13570, in_queue=32306464, util=93.14%
```

## Throughput test: sequential write

```sh
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-write --eta-newline=1
```

```
throughput-write: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
fio-3.28
Starting 1 process

throughput-write: (groupid=0, jobs=1): err= 0: pid=1182194: Fri Dec 12 15:16:30 2025
  write: IOPS=2116, BW=2116MiB/s (2219MB/s)(248GiB/120045msec); 0 zone resets
    slat (usec): min=51, max=288514, avg=468.61, stdev=1739.38
    clat (msec): min=2, max=1262, avg=29.77, stdev=23.67
     lat (msec): min=2, max=1263, avg=30.24, stdev=23.87
    clat percentiles (msec):
     |  1.00th=[   12],  5.00th=[   20], 10.00th=[   25], 20.00th=[   25],
     | 30.00th=[   26], 40.00th=[   26], 50.00th=[   26], 60.00th=[   26],
     | 70.00th=[   26], 80.00th=[   28], 90.00th=[   39], 95.00th=[   64],
     | 99.00th=[   93], 99.50th=[  104], 99.90th=[  138], 99.95th=[  150],
     | 99.99th=[ 1267]
   bw (  MiB/s): min=    6, max= 2360, per=100.00%, avg=2117.02, stdev=261.57, samples=239
   iops        : min=    6, max= 2360, avg=2117.02, stdev=261.57, samples=239
  lat (msec)   : 4=0.02%, 10=0.66%, 20=4.43%, 50=86.28%, 100=8.00%
  lat (msec)   : 250=0.60%, 500=0.01%, 750=0.01%, 1000=0.01%, 2000=0.02%
  cpu          : usr=11.66%, sys=30.62%, ctx=134092, majf=0, minf=14
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,254028,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=2116MiB/s (2219MB/s), 2116MiB/s-2116MiB/s (2219MB/s-2219MB/s), io=248GiB (266GB), run=120045-120045msec

Disk stats (read/write):
  nvme0n1: ios=0/2029754, merge=0/160, ticks=0/32225051, in_queue=32225130, util=77.84%
```
