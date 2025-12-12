# 性能测试

`libaio`为 Linux 异步 IO 引擎；本次测试在 Linode 8GB 实例上进行。

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
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-read --eta-newline=1 | tee seq-read.log
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-write --eta-newline=1 | tee seq-write.log

iops-test-job: (groupid=0, jobs=4): err= 0: pid=1559642: Fri Dec 12 07:25:21 2025
  read: IOPS=41.3k, BW=161MiB/s (169MB/s)(18.9GiB/120012msec)
    slat (usec): min=3, max=16484, avg=36.74, stdev=267.83
    clat (usec): min=75, max=460598, avg=12180.02, stdev=6266.07
     lat (usec): min=261, max=460603, avg=12216.76, stdev=6274.20
    clat percentiles (usec):
     |  1.00th=[ 1156],  5.00th=[ 1942], 10.00th=[ 3064], 20.00th=[ 6521],
     | 30.00th=[ 9634], 40.00th=[11469], 50.00th=[12911], 60.00th=[13960],
     | 70.00th=[15270], 80.00th=[16712], 90.00th=[19006], 95.00th=[21365],
     | 99.00th=[26084], 99.50th=[27919], 99.90th=[32637], 99.95th=[34341],
     | 99.99th=[39060]
   bw (  KiB/s): min=116200, max=196624, per=100.00%, avg=165451.00, stdev=3732.00, samples=956
   iops        : min=29050, max=49156, avg=41362.60, stdev=933.00, samples=956
  write: IOPS=41.3k, BW=161MiB/s (169MB/s)(18.9GiB/120012msec); 0 zone resets
    slat (usec): min=3, max=15159, avg=37.48, stdev=267.89
    clat (usec): min=127, max=460685, avg=12539.00, stdev=6266.66
     lat (usec): min=146, max=460690, avg=12576.48, stdev=6274.64
    clat percentiles (usec):
     |  1.00th=[ 1237],  5.00th=[ 2089], 10.00th=[ 3326], 20.00th=[ 6849],
     | 30.00th=[ 9896], 40.00th=[11863], 50.00th=[13173], 60.00th=[14353],
     | 70.00th=[15664], 80.00th=[17171], 90.00th=[19530], 95.00th=[21890],
     | 99.00th=[26608], 99.50th=[28705], 99.90th=[33162], 99.95th=[34866],
     | 99.99th=[39060]
   bw (  KiB/s): min=116440, max=197671, per=100.00%, avg=165356.24, stdev=3717.62, samples=956
   iops        : min=29110, max=49417, avg=41338.92, stdev=929.40, samples=956
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.11%, 1000=0.38%
  lat (msec)   : 2=4.42%, 4=7.57%, 10=18.37%, 20=60.97%, 50=8.15%
  lat (msec)   : 250=0.01%, 500=0.01%
  cpu          : usr=2.46%, sys=16.11%, ctx=1886176, majf=0, minf=86
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=4957650,4954950,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=161MiB/s (169MB/s), 161MiB/s-161MiB/s (169MB/s-169MB/s), io=18.9GiB (20.3GB), run=120012-120012msec
  WRITE: bw=161MiB/s (169MB/s), 161MiB/s-161MiB/s (169MB/s-169MB/s), io=18.9GiB (20.3GB), run=120012-120012msec

Disk stats (read/write):
  sda: ios=4952543/4950042, sectors=39620448/39601168, merge=0/86, ticks=48674768/47908037, in_queue=96582973, util=100.00%
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

throughput-read: (groupid=0, jobs=1): err= 0: pid=1559654: Fri Dec 12 07:27:22 2025
  read: IOPS=5836, BW=5836MiB/s (6120MB/s)(684GiB/120009msec)
    slat (usec): min=28, max=4890, avg=73.41, stdev=74.68
    clat (usec): min=2035, max=60911, avg=10888.64, stdev=1585.07
     lat (usec): min=2132, max=61577, avg=10962.05, stdev=1584.89
    clat percentiles (usec):
     |  1.00th=[ 8717],  5.00th=[ 9241], 10.00th=[ 9634], 20.00th=[10028],
     | 30.00th=[10159], 40.00th=[10421], 50.00th=[10552], 60.00th=[10814],
     | 70.00th=[11076], 80.00th=[11469], 90.00th=[12518], 95.00th=[13304],
     | 99.00th=[15664], 99.50th=[17695], 99.90th=[28705], 99.95th=[32375],
     | 99.99th=[37487]
   bw (  MiB/s): min= 4702, max= 6594, per=100.00%, avg=5842.20, stdev=288.13, samples=239
   iops        : min= 4702, max= 6594, avg=5842.20, stdev=288.13, samples=239
  lat (msec)   : 4=0.01%, 10=20.41%, 20=79.23%, 50=0.35%, 100=0.01%
  cpu          : usr=1.19%, sys=46.38%, ctx=34410, majf=0, minf=16407
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=700426,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=5836MiB/s (6120MB/s), 5836MiB/s-5836MiB/s (6120MB/s-6120MB/s), io=684GiB (734GB), run=120009-120009msec

Disk stats (read/write):
  sda: ios=1120509/178, sectors=1433014320/2744, merge=0/143, ticks=11339026/3198, in_queue=11342934, util=100.00%
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

throughput-write: (groupid=0, jobs=1): err= 0: pid=1559663: Fri Dec 12 07:29:22 2025
  write: IOPS=6395, BW=6396MiB/s (6706MB/s)(750GiB/120009msec); 0 zone resets
    slat (usec): min=27, max=8730, avg=80.15, stdev=76.70
    clat (usec): min=930, max=33677, avg=9925.69, stdev=1894.93
     lat (usec): min=1058, max=34130, avg=10005.85, stdev=1891.68
    clat percentiles (usec):
     |  1.00th=[ 5473],  5.00th=[ 7635], 10.00th=[ 8160], 20.00th=[ 8717],
     | 30.00th=[ 8979], 40.00th=[ 9372], 50.00th=[ 9634], 60.00th=[10028],
     | 70.00th=[ 10421], 80.00th=[ 11076], 90.00th=[ 11994], 95.00th=[ 13042],
     | 99.00th=[ 16319], 99.50th=[ 17957], 99.90th=[ 22152], 99.95th=[ 23462],
     | 99.99th=[ 29230]
   bw (  MiB/s): min= 4252, max= 7316, per=100.00%, avg=6402.04, stdev=459.64, samples=239
   iops        : min= 4252, max= 7316, avg=6402.01, stdev=459.63, samples=239
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.03%, 4=0.22%, 10=58.88%, 20=40.65%, 50=0.21%
  lat (msec)   : 100=0.22%, 250=0.03%, 500=0.01%
  cpu          : usr=20.68%, sys=31.43%, ctx=86260, majf=0, minf=29
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,767533,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=6396MiB/s (6706MB/s), 6396MiB/s-6396MiB/s (6706MB/s-6706MB/s), io=750GiB (805GB), run=120009-120009msec

Disk stats (read/write):
  sda: ios=0/1126156, sectors=0/1569820272, merge=0/334, ticks=0/10148445, in_queue=10148841, util=99.94%
```
