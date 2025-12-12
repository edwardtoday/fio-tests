# 性能测试

`libaio` 为 Linux 异步 IO 引擎；本次测试在 c6i.2xlarge（cn-north-1）实例上进行。

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

iops-test-job: (groupid=0, jobs=4): err= 0: pid=3397645: Fri Dec 12 07:54:31 2025
  read: IOPS=1508, BW=6035KiB/s (6180kB/s)(708MiB/120042msec)
    slat (nsec): min=1260, max=62257k, avg=1276975.57, stdev=3324269.28
    clat (msec): min=4, max=646, avg=338.08, stdev=98.04
     lat (msec): min=4, max=646, avg=339.35, stdev=98.32
    clat percentiles (msec):
     |  1.00th=[  142],  5.00th=[  180], 10.00th=[  199], 20.00th=[  245],
     | 30.00th=[  296], 40.00th=[  326], 50.00th=[  347], 60.00th=[  368],
     | 70.00th=[  388], 80.00th=[  414], 90.00th=[  460], 95.00th=[  498],
     | 99.00th=[  550], 99.50th=[  575], 99.90th=[  600], 99.95th=[  617],
     | 99.99th=[  634]
   bw (  KiB/s): min= 3088, max=14728, per=99.78%, avg=6022.23, stdev=425.16, samples=956
   iops        : min=  772, max= 3682, avg=1505.56, stdev=106.29, samples=956
  write: IOPS=1507, BW=6032KiB/s (6176kB/s)(707MiB/120042msec); 0 zone resets
    slat (nsec): min=1456, max=46106k, avg=1370137.90, stdev=3339810.89
    clat (msec): min=5, max=646, avg=338.10, stdev=98.29
     lat (msec): min=5, max=646, avg=339.47, stdev=98.62
    clat percentiles (msec):
     |  1.00th=[  142],  5.00th=[  180], 10.00th=[  199], 20.00th=[  245],
     | 30.00th=[  296], 40.00th=[  326], 50.00th=[  347], 60.00th=[  368],
     | 70.00th=[  388], 80.00th=[  414], 90.00th=[  460], 95.00th=[  498],
     | 99.00th=[  558], 99.50th=[  575], 99.90th=[  600], 99.95th=[  617],
     | 99.99th=[  625]
   bw (  KiB/s): min= 3160, max=14992, per=99.81%, avg=6020.02, stdev=431.93, samples=956
   iops        : min=  790, max= 3748, avg=1505.00, stdev=107.98, samples=956
  lat (msec)   : 10=0.28%, 20=0.33%, 50=0.05%, 100=0.08%, 250=20.41%
  lat (msec)   : 500=74.08%, 750=4.78%
  cpu          : usr=0.18%, sys=0.51%, ctx=99901, majf=0, minf=55
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=181127,181015,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=6035KiB/s (6180kB/s), 6035KiB/s-6035KiB/s (6180kB/s-6180kB/s), io=708MiB (742MB), run=120042-120042msec
  WRITE: bw=6032KiB/s (6176kB/s), 6032KiB/s-6032KiB/s (6176kB/s-6176kB/s), io=707MiB (741MB), run=120042-120042msec

Disk stats (read/write):
  nvme0n1: ios=181089/181508, merge=0/1270, ticks=7090724/7153889, in_queue=14244613, util=98.04%
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

throughput-read: (groupid=0, jobs=1): err= 0: pid=3399145: Fri Dec 12 07:56:32 2025
  read: IOPS=125, BW=126MiB/s (132MB/s)(14.8GiB/120123msec)
    slat (usec): min=41, max=126226, avg=7928.32, stdev=13511.26
    clat (msec): min=29, max=663, avg=500.09, stdev=56.78
     lat (msec): min=30, max=720, avg=508.02, stdev=57.47
    clat percentiles (msec):
     |  1.00th=[  347],  5.00th=[  418], 10.00th=[  447], 20.00th=[  498],
     | 30.00th=[  502], 40.00th=[  502], 50.00th=[  506], 60.00th=[  506],
     | 70.00th=[  510], 80.00th=[  514], 90.00th=[  558], 95.00th=[  584],
     | 99.00th=[  617], 99.50th=[  617], 99.90th=[  625], 99.95th=[  634],
     | 99.99th=[  667]
   bw (  KiB/s): min=100352, max=284672, per=99.69%, avg=128580.27, stdev=12043.30, samples=240
   iops        : min=   98, max=  278, avg=125.57, stdev=11.76, samples=240
  lat (msec)   : 50=0.58%, 100=0.05%, 250=0.22%, 500=28.44%, 750=70.72%
  cpu          : usr=0.05%, sys=0.78%, ctx=7424, majf=0, minf=16396
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.2%, >=64=99.6%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=15131,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=126MiB/s (132MB/s), 126MiB/s-126MiB/s (132MB/s-132MB/s), io=14.8GiB (15.9GB), run=120123-120123msec

Disk stats (read/write):
  nvme0n1: ios=60836/706, sectors=30951528/16120, merge=0/1117, ticks=7811575/58025, in_queue=7869600, util=98.83%
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

throughput-write: (groupid=0, jobs=1): err= 0: pid=3400630: Fri Dec 12 07:58:32 2025
  write: IOPS=125, BW=125MiB/s (131MB/s)(14.7GiB/120115msec); 0 zone resets
    slat (usec): min=57, max=174594, avg=7980.27, stdev=16127.54
    clat (msec): min=12, max=730, avg=503.01, stdev=53.38
     lat (msec): min=79, max=765, avg=510.99, stdev=54.15
    clat percentiles (msec):
     |  1.00th=[  376],  5.00th=[  409], 10.00th=[  435], 20.00th=[  477],
     | 30.00th=[  498], 40.00th=[  502], 50.00th=[  506], 60.00th=[  506],
     | 70.00th=[  510], 80.00th=[  531], 90.00th=[  575], 95.00th=[  600],
     | 99.00th=[  625], 99.50th=[  642], 99.90th=[  684], 99.95th=[  709],
     | 99.99th=[  735]
   bw (  KiB/s): min=96256, max=161792, per=99.67%, avg=127812.27, stdev=10981.76, samples=240
   iops        : min=  94, max=  158, avg=124.82, stdev=10.72, samples=240
  lat (msec)   : 20=0.01%, 100=0.02%, 250=0.24%, 500=33.31%, 750=66.43%
  cpu          : usr=0.79%, sys=0.73%, ctx=6515, majf=0, minf=12
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.2%, >=64=99.6%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,15042,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=125MiB/s (131MB/s), 125MiB/s-125MiB/s (131MB/s-131MB/s), io=14.7GiB (15.8GB), run=120115-120115msec

Disk stats (read/write):
  nvme0n1: ios=679/60705, sectors=24376/30758944, merge=0/1133, ticks=74018/7967289, in_queue=8041308, util=98.21%
---- done: ./fio-seq-write.log
```
