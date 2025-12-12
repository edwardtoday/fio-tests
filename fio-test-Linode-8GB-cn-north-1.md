# 性能测试

`libaio`为 Linux 异步 IO 引擎；本次测试在 Linode 8GB（cn-north-1）实例上进行。

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

iops-test-job: (groupid=0, jobs=4): err= 0: pid=2902: Fri Dec 12 07:42:43 2025
  read: IOPS=1512, BW=6048KiB/s (6194kB/s)(709MiB/120022msec)
    slat (usec): min=2, max=64828, avg=1323.16, stdev=4427.16
    clat (msec): min=11, max=828, avg=337.05, stdev=98.38
     lat (msec): min=14, max=828, avg=338.37, stdev=98.56
    clat percentiles (msec):
     |  1.00th=[  129],  5.00th=[  192], 10.00th=[  222], 20.00th=[  257],
     | 30.00th=[  284], 40.00th=[  309], 50.00th=[  330], 60.00th=[  355],
     | 70.00th=[  384], 80.00th=[  418], 90.00th=[  464], 95.00th=[  506],
     | 99.00th=[  592], 99.50th=[  625], 99.90th=[  743], 99.95th=[  768],
     | 99.99th=[  802]
   bw (  KiB/s): min= 2441, max=13701, per=99.79%, avg=6036.64, stdev=370.38, samples=956
   iops        : min=  610, max= 3424, avg=1508.79, stdev=92.59, samples=956
  write: IOPS=1511, BW=6048KiB/s (6193kB/s)(709MiB/120022msec); 0 zone resets
    slat (usec): min=2, max=63649, avg=1314.96, stdev=4429.89
    clat (msec): min=11, max=828, avg=337.47, stdev=98.68
     lat (msec): min=15, max=828, avg=338.78, stdev=98.89
    clat percentiles (msec):
     |  1.00th=[  131],  5.00th=[  192], 10.00th=[  222], 20.00th=[  257],
     | 30.00th=[  284], 40.00th=[  309], 50.00th=[  334], 60.00th=[  355],
     | 70.00th=[  384], 80.00th=[  418], 90.00th=[  468], 95.00th=[  506],
     | 99.00th=[  592], 99.50th=[  625], 99.90th=[  743], 99.95th=[  776],
     | 99.99th=[  802]
   bw (  KiB/s): min= 2464, max=14438, per=99.77%, avg=6034.77, stdev=381.92, samples=956
   iops        : min=  616, max= 3608, avg=1508.32, stdev=95.47, samples=956
  lat (msec)   : 20=0.09%, 50=0.57%, 100=0.10%, 250=17.33%, 500=76.36%
  lat (msec)   : 750=5.45%, 1000=0.09%
  cpu          : usr=0.34%, sys=0.75%, ctx=94724, majf=0, minf=50
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=181486,181471,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=6048KiB/s (6194kB/s), 6048KiB/s-6048KiB/s (6194kB/s-6194kB/s), io=709MiB (743MB), run=120022-120022msec
  WRITE: bw=6048KiB/s (6193kB/s), 6048KiB/s-6048KiB/s (6193kB/s-6193kB/s), io=709MiB (743MB), run=120022-120022msec

Disk stats (read/write):
  nvme0n1: ios=181146/181236, sectors=1449168/1450328, merge=0/34, ticks=2964986/3020659, in_queue=5985645, util=96.61%
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

throughput-read: (groupid=0, jobs=1): err= 0: pid=2917: Fri Dec 12 07:44:43 2025
  read: IOPS=126, BW=126MiB/s (132MB/s)(14.8GiB/120061msec)
    slat (usec): min=28, max=67609, avg=7900.77, stdev=4179.69
    clat (msec): min=38, max=612, avg=499.00, stdev=41.31
     lat (msec): min=38, max=618, avg=506.90, stdev=41.98
    clat percentiles (msec):
     |  1.00th=[  321],  5.00th=[  502], 10.00th=[  502], 20.00th=[  502],
     | 30.00th=[  502], 40.00th=[  502], 50.00th=[  502], 60.00th=[  502],
     | 70.00th=[  506], 80.00th=[  506], 90.00th=[  506], 95.00th=[  506],
     | 99.00th=[  535], 99.50th=[  550], 99.90th=[  558], 99.95th=[  558],
     | 99.99th=[  609]
   bw (  KiB/s): min=118784, max=268288, per=99.71%, avg=128886.90, stdev=9186.72, samples=239
   iops        : min=  116, max=  262, avg=125.87, stdev= 8.97, samples=239
  lat (msec)   : 50=0.54%, 100=0.08%, 250=0.26%, 500=6.68%, 750=92.44%
  cpu          : usr=0.29%, sys=1.57%, ctx=19768, majf=0, minf=16397
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.2%, >=64=99.6%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=15156,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=126MiB/s (132MB/s), 126MiB/s-126MiB/s (132MB/s-132MB/s), io=14.8GiB (15.9GB), run=120061-120061msec

Disk stats (read/write):
  nvme0n1: ios=60542/57, merge=0/18, ticks=3628662/3337, in_queue=3632000, util=98.34%
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

throughput-write: (groupid=0, jobs=1): err= 0: pid=2927: Fri Dec 12 07:46:43 2025
  write: IOPS=125, BW=125MiB/s (131MB/s)(14.7GiB/120060msec); 0 zone resets
    slat (usec): min=54, max=73147, avg=7964.31, stdev=12581.54
    clat (msec): min=59, max=617, avg=502.77, stdev=32.19
     lat (msec): min=61, max=632, avg=510.73, stdev=32.49
    clat percentiles (msec):
     |  1.00th=[  443],  5.00th=[  456], 10.00th=[  468], 20.00th=[  489],
     | 30.00th=[  502], 40.00th=[  502], 50.00th=[  502], 60.00th=[  502],
     | 70.00th=[  506], 80.00th=[  518], 90.00th=[  542], 95.00th=[  550],
     | 99.00th=[  558], 99.50th=[  567], 99.90th=[  584], 99.95th=[  600],
     | 99.99th=[  609]
   bw (  KiB/s): min=106496, max=143360, per=99.69%, avg=127900.46, stdev=5919.38, samples=239
   iops        : min=  104, max=  140, avg=124.90, stdev= 5.79, samples=239
  lat (msec)   : 100=0.05%, 250=0.22%, 500=25.23%, 750=74.50%
  cpu          : usr=1.10%, sys=1.20%, ctx=13415, majf=0, minf=11
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,15042,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=125MiB/s (131MB/s), 125MiB/s-125MiB/s (131MB/s-131MB/s), io=14.7GiB (15.8GB), run=120060-120060msec

Disk stats (read/write):
  nvme0n1: ios=247/60306, sectors=22088/30798576, merge=0/203, ticks=15357/4161585, in_queue=4176943, util=97.80%
```
