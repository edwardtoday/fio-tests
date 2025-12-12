# 性能测试

`libaio`为 Linux 异步 IO 引擎；本次测试在 Linode 32GB 实例上进行。

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
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-read --eta-newline=1 | tee seq-read.log
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-write --eta-newline=1 | tee seq-write.log

iops-test-job: (groupid=0, jobs=4): err= 0: pid=429136: Fri Dec 12 07:24:50 2025
  read: IOPS=58.3k, BW=228MiB/s (239MB/s)(26.7GiB/120003msec)
    slat (usec): min=3, max=70670, avg=26.05, stdev=84.52
    clat (usec): min=142, max=95653, avg=8351.90, stdev=2430.40
     lat (usec): min=172, max=95677, avg=8378.25, stdev=2432.36
    clat percentiles (usec):
     |  1.00th=[ 3556],  5.00th=[ 5473], 10.00th=[ 6128], 20.00th=[ 6783],
     | 30.00th=[ 7242], 40.00th=[ 7701], 50.00th=[ 8094], 60.00th=[ 8455],
     | 70.00th=[ 8979], 80.00th=[ 9634], 90.00th=[10683], 95.00th=[11994],
     | 99.00th=[17171], 99.50th=[19792], 99.90th=[27132], 99.95th=[30802],
     | 99.99th=[41681]
   bw (  KiB/s): min=166960, max=260368, per=100.00%, avg=233552.76, stdev=2853.45, samples=956
   iops        : min=41740, max=65092, avg=58387.92, stdev=713.36, samples=956
  write: IOPS=58.3k, BW=228MiB/s (239MB/s)(26.7GiB/120003msec); 0 zone resets
    slat (usec): min=3, max=29159, avg=27.67, stdev=81.09
    clat (usec): min=132, max=96332, avg=9149.70, stdev=2500.79
     lat (usec): min=164, max=96342, avg=9177.68, stdev=2502.44
    clat percentiles (usec):
     |  1.00th=[ 4178],  5.00th=[ 6128], 10.00th=[ 6783], 20.00th=[ 7504],
     | 30.00th=[ 8029], 40.00th=[ 8455], 50.00th=[ 8848], 60.00th=[ 9372],
     | 70.00th=[ 9765], 80.00th=[10421], 90.00th=[11600], 95.00th=[12911],
     | 99.00th=[17957], 99.50th=[20579], 99.90th=[28705], 99.95th=[33162],
     | 99.99th=[46400]
   bw (  KiB/s): min=168672, max=259689, per=100.00%, avg=233386.28, stdev=2807.24, samples=956
   iops        : min=42168, max=64922, avg=58346.34, stdev=701.81, samples=956
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.13%, 4=0.99%, 10=78.12%, 20=20.22%, 50=0.53%
  lat (msec)   : 100=0.01%
  cpu          : usr=4.90%, sys=34.19%, ctx=9723659, majf=0, minf=68
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=6999944,6994900,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=228MiB/s (239MB/s), 228MiB/s-228MiB/s (239MB/s-239MB/s), io=26.7GiB (28.7GB), run=120003-120003msec
  WRITE: bw=228MiB/s (239MB/s), 228MiB/s-228MiB/s (239MB/s-239MB/s), io=26.7GiB (28.7GB), run=120003-120003msec

Disk stats (read/write):
  sda: ios=6986337/6982584, merge=8670/9891, ticks=27498044/26632699, in_queue=54131239, util=100.00%
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

throughput-read: (groupid=0, jobs=1): err= 0: pid=429427: Fri Dec 12 07:26:50 2025
  read: IOPS=7134, BW=7134MiB/s (7481MB/s)(836GiB/120007msec)
    slat (usec): min=41, max=4971, avg=75.55, stdev=40.39
    clat (usec): min=1074, max=299493, avg=8892.24, stdev=1698.75
     lat (usec): min=1133, max=299550, avg=8968.02, stdev=1698.32
    clat percentiles (usec):
     |  1.00th=[ 6390],  5.00th=[ 7767], 10.00th=[ 8029], 20.00th=[ 8291],
     | 30.00th=[ 8455], 40.00th=[ 8586], 50.00th=[ 8717], 60.00th=[ 8848],
     | 70.00th=[ 9110], 80.00th=[ 9372], 90.00th=[ 9896], 95.00th=[ 10552],
     | 99.00th=[ 14091], 99.50th=[ 15795], 99.90th=[ 19530], 99.95th=[ 22414],
     | 99.99th=[ 39060]
   bw (  MiB/s): min= 5315, max= 7516, per=100.00%, avg=7139.31, stdev=245.11, samples=236
   iops        : min= 5315, max= 7516, avg=7139.28, stdev=245.11, samples=236
  lat (msec)   : 2=0.01%, 4=0.09%, 10=90.93%, 20=8.95%, 50=0.02%
  cpu          : usr=3.12%, sys=53.91%, ctx=62219, majf=0, minf=16397
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=856136,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=7134MiB/s (7481MB/s), 7134MiB/s-7134MiB/s (7481MB/s-7481MB/s), io=836GiB (898GB), run=120007-120007msec

Disk stats (read/write):
  sda: ios=1709284/1556, merge=0/1008, ticks=14185473/25786, in_queue=14214819, util=99.52%
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

throughput-write: (groupid=0, jobs=1): err= 0: pid=429719: Fri Dec 12 07:28:51 2025
  write: IOPS=5268, BW=5269MiB/s (5525MB/s)(617GiB/120009msec); 0 zone resets
    slat (usec): min=38, max=26323, avg=85.84, stdev=122.56
    clat (usec): min=2, max=344269, avg=12058.71, stdev=7994.29
     lat (usec): min=324, max=344343, avg=12144.84, stdev=7994.66
    clat percentiles (usec):
     |  1.00th=[   297],  5.00th=[  5604], 10.00th=[  8717], 20.00th=[  9110],
     | 30.00th=[  9241], 40.00th=[  9372], 50.00th=[  9634], 60.00th=[ 10159],
     | 70.00th=[ 10683], 80.00th=[ 11994], 90.00th=[ 22414], 95.00th=[ 28443],
     | 99.00th=[ 38536], 99.50th=[ 43254], 99.90th=[ 62653], 99.95th=[ 72877],
     | 99.99th=[214959]
   bw (  MiB/s): min=  244, max= 6709, per=99.97%, avg=5267.24, stdev=1651.89, samples=239
   iops        : min=  244, max= 6709, avg=5267.18, stdev=1651.85, samples=239
  lat (usec)   : 4=0.01%, 100=0.01%, 250=0.01%, 500=2.83%, 750=0.28%
  lat (usec)   : 1000=0.10%
  lat (msec)   : 2=0.21%, 4=0.46%, 10=52.97%, 20=30.91%, 50=11.99%
  lat (msec)   : 100=0.22%, 250=0.03%, 500=0.01%
  cpu          : usr=11.03%, sys=29.88%, ctx=363200, majf=0, minf=12
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,632314,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=5269MiB/s (5525MB/s), 5269MiB/s-5269MiB/s (5525MB/s-5525MB/s), io=617GiB (663GB), run=120009-120009msec

Disk stats (read/write):
  sda: ios=334/1263600, merge=350/1654, ticks=2759/13385349, in_queue=13389805, util=99.89%
```
