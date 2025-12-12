# 性能测试

`libaio`为 Linux 异步 IO 引擎；本次测试在 Linode 4GB 实例上进行。

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

iops-test-job: (groupid=0, jobs=4): err= 0: pid=3035726: Fri Dec 12 15:22:42 2025
  read: IOPS=40.5k, BW=158MiB/s (166MB/s)(18.5GiB/120001msec)
    slat (usec): min=5, max=914442, avg=43.39, stdev=760.38
    clat (usec): min=92, max=4999.7k, avg=12425.98, stdev=29100.27
     lat (usec): min=106, max=4999.7k, avg=12469.37, stdev=29181.64
    clat percentiles (usec):
     |  1.00th=[   1582],  5.00th=[   4113], 10.00th=[   5145],
     | 20.00th=[   6259], 30.00th=[   7635], 40.00th=[   9241],
     | 50.00th=[  10814], 60.00th=[  12387], 70.00th=[  14091],
     | 80.00th=[  16188], 90.00th=[  19268], 95.00th=[  22152],
     | 99.00th=[  30278], 99.50th=[  41681], 99.90th=[ 166724],
     | 99.95th=[ 517997], 99.99th=[1333789]
   bw (  KiB/s): min=  800, max=242856, per=100.00%, avg=162751.56, stdev=10895.94, samples=952
   iops        : min=  200, max=60714, avg=40687.45, stdev=2723.97, samples=952
  write: IOPS=40.4k, BW=158MiB/s (166MB/s)(18.5GiB/120001msec); 0 zone resets
    slat (usec): min=5, max=919216, avg=45.20, stdev=960.19
    clat (usec): min=6, max=5001.9k, avg=12799.51, stdev=28404.31
     lat (usec): min=65, max=5001.9k, avg=12844.71, stdev=28482.76
    clat percentiles (usec):
     |  1.00th=[   1713],  5.00th=[   4228], 10.00th=[   5211],
     | 20.00th=[   6390], 30.00th=[   8029], 40.00th=[   9634],
     | 50.00th=[  11207], 60.00th=[  12780], 70.00th=[  14615],
     | 80.00th=[  16712], 90.00th=[  19792], 95.00th=[  22676],
     | 99.00th=[  30802], 99.50th=[  41681], 99.90th=[ 166724],
     | 99.95th=[ 517997], 99.99th=[1333789]
   bw (  KiB/s): min=  808, max=243800, per=100.00%, avg=162644.83, stdev=10894.18, samples=952
   iops        : min=  202, max=60950, avg=40660.80, stdev=2723.53, samples=952
  lat (usec)   : 10=0.01%, 20=0.01%, 100=0.01%, 250=0.01%, 500=0.01%
  lat (usec)   : 750=0.01%, 1000=0.08%
  lat (msec)   : 2=1.30%, 4=3.11%, 10=39.00%, 20=47.46%, 50=8.61%
  lat (msec)   : 100=0.17%, 250=0.18%, 500=0.02%, 750=0.02%, 1000=0.01%
  lat (msec)   : 2000=0.02%, >=2000=0.01%
  cpu          : usr=3.62%, sys=17.74%, ctx=736095, majf=0, minf=86
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=4854845,4851746,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=158MiB/s (166MB/s), 158MiB/s-158MiB/s (166MB/s-166MB/s), io=18.5GiB (19.9GB), run=120001-120001msec
  WRITE: bw=158MiB/s (166MB/s), 158MiB/s-158MiB/s (166MB/s-166MB/s), io=18.5GiB (19.9GB), run=120001-120001msec

Disk stats (read/write):
  sda: ios=4853134/4850232, sectors=38848904/38806552, merge=0/385, ticks=27699045/27162131, in_queue=54861293, util=99.87%
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

throughput-read: (groupid=0, jobs=1): err= 0: pid=3035902: Fri Dec 12 15:24:42 2025
  read: IOPS=5877, BW=5878MiB/s (6163MB/s)(689GiB/120007msec)
    slat (usec): min=37, max=7047, avg=69.32, stdev=56.42
    clat (usec): min=990, max=256749, avg=10812.53, stdev=2041.97
     lat (usec): min=1204, max=256805, avg=10881.85, stdev=2045.67
    clat percentiles (usec):
     |  1.00th=[ 7963],  5.00th=[ 9372], 10.00th=[ 9634], 20.00th=[ 9896],
     | 30.00th=[10159], 40.00th=[10290], 50.00th=[10552], 60.00th=[10814],
     | 70.00th=[11076], 80.00th=[11469], 90.00th=[12256], 95.00th=[13042],
     | 99.00th=[16712], 99.50th=[19006], 99.90th=[22152], 99.95th=[23200],
     | 99.99th=[65274]
   bw (  MiB/s): min= 3364, max= 6568, per=100.00%, avg=5880.92, stdev=429.69, samples=239
   iops        : min= 3364, max= 6568, avg=5880.92, stdev=429.70, samples=239
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.02%, 4=0.07%, 10=24.13%, 20=75.42%, 50=0.34%
  lat (msec)   : 100=0.02%, 250=0.01%, 500=0.01%
  cpu          : usr=1.42%, sys=45.67%, ctx=45850, majf=0, minf=16395
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=705384,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=5878MiB/s (6163MB/s), 5878MiB/s-5878MiB/s (6163MB/s-6163MB/s), io=689GiB (740GB), run=120007-120007msec

Disk stats (read/write):
  sda: ios=1387615/572, sectors=1443108368/10344, merge=0/334, ticks=14202960/7999, in_queue=14212109, util=99.88%
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

throughput-write: (groupid=0, jobs=1): err= 0: pid=3036058: Fri Dec 12 15:26:42 2025
  write: IOPS=6067, BW=6068MiB/s (6363MB/s)(711GiB/120007msec); 0 zone resets
    slat (usec): min=41, max=14012, avg=87.55, stdev=81.01
    clat (usec): min=326, max=383134, avg=10458.76, stdev=6948.66
     lat (usec): min=397, max=383223, avg=10546.31, stdev=6949.16
    clat percentiles (msec):
     |  1.00th=[    4],  5.00th=[    7], 10.00th=[    8], 20.00th=[    9],
     | 30.00th=[    9], 40.00th=[   10], 50.00th=[   10], 60.00th=[   11],
     | 70.00th=[   11], 80.00th=[   12], 90.00th=[   14], 95.00th=[   16],
     | 99.00th=[   23], 99.50th=[   26], 99.90th=[  171], 99.95th=[  188],
     | 99.99th=[  201]
   bw (  MiB/s): min= 3686, max= 6927, per=100.00%, avg=6070.44, stdev=636.53, samples=239
   iops        : min= 3686, max= 6927, avg=6070.31, stdev=636.50, samples=239
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.21%, 4=1.32%, 10=53.99%, 20=42.59%, 50=1.75%
  lat (msec)   : 100=0.01%, 250=0.12%, 500=0.01%
  cpu          : usr=18.92%, sys=35.28%, ctx=95587, majf=0, minf=12
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,728178,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=6068MiB/s (6363MB/s), 6068MiB/s-6068MiB/s (6363MB/s-6363MB/s), io=711GiB (764GB), run=120007-120007msec

Disk stats (read/write):
  sda: ios=189/1431243, sectors=12048/1488398400, merge=0/377, ticks=2577/13571157, in_queue=13574329, util=99.89%
```
