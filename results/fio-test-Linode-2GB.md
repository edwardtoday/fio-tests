# 性能测试

`libaio`为 Linux 异步 IO 引擎；本次测试在 Linode 2GB 实例上进行。

## IOPS test: random read/write

```sh
fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randrw --bs=4k \
    --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
    --group_reporting --name=iops-test-job --eta-newline=1
```

```
iops-test-job: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=256
...
fio-3.16
Starting 4 processes
iops-test-job: Laying out IO file (1 file / 1024MiB)

iops-test-job: (groupid=0, jobs=4): err= 0: pid=3590924: Fri Dec 12 15:21:10 2025
  read: IOPS=37.9k, BW=148MiB/s (155MB/s)(17.3GiB/120008msec)
    slat (nsec): min=1450, max=64764k, avg=37337.12, stdev=300837.78
    clat (usec): min=974, max=135141, avg=11755.84, stdev=6467.74
     lat (usec): min=976, max=136463, avg=11793.36, stdev=6480.38
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2802], 10.00th=[ 3556], 20.00th=[ 6128],
     | 30.00th=[ 8029], 40.00th=[ 9634], 50.00th=[11207], 60.00th=[12649],
     | 70.00th=[14484], 80.00th=[16581], 90.00th=[20055], 95.00th=[22938],
     | 99.00th=[30016], 99.50th=[33424], 99.90th=[45876], 99.95th=[58459],
     | 99.99th=[77071]
   bw (  KiB/s): min=98293, max=182472, per=99.98%, avg=151408.51, stdev=4651.10, samples=960
   iops        : min=24573, max=45618, avg=37852.02, stdev=1162.78, samples=960
  write: IOPS=37.8k, BW=148MiB/s (155MB/s)(17.3GiB/120008msec); 0 zone resets
    slat (nsec): min=1780, max=64609k, avg=63626.81, stdev=457834.31
    clat (usec): min=1120, max=139666, avg=15194.38, stdev=7394.11
     lat (usec): min=1124, max=139669, avg=15258.23, stdev=7405.15
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    5], 10.00th=[    7], 20.00th=[   10],
     | 30.00th=[   12], 40.00th=[   13], 50.00th=[   15], 60.00th=[   17],
     | 70.00th=[   19], 80.00th=[   21], 90.00th=[   25], 95.00th=[   28],
     | 99.00th=[   36], 99.50th=[   41], 99.90th=[   55], 99.95th=[   69],
     | 99.99th=[  110]
   bw (  KiB/s): min=98133, max=184480, per=99.98%, avg=151302.91, stdev=4662.43, samples=960
   iops        : min=24533, max=46120, avg=37825.61, stdev=1165.61, samples=960
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.21%, 4=8.09%, 10=24.97%, 20=50.53%, 50=16.09%
  lat (msec)   : 100=0.10%, 250=0.01%
  cpu          : usr=2.73%, sys=7.90%, ctx=842105, majf=0, minf=53
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=4543564,4540486,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=148MiB/s (155MB/s), 148MiB/s-148MiB/s (155MB/s-155MB/s), io=17.3GiB (18.6GB), run=120008-120008msec
  WRITE: bw=148MiB/s (155MB/s), 148MiB/s-148MiB/s (155MB/s-155MB/s), io=17.3GiB (18.6GB), run=120008-120008msec

Disk stats (read/write):
  sda: ios=4528660/4516301, merge=10404/20389, ticks=9999846/18540917, in_queue=8985952, util=100.00%
```

## Throughput test: sequential read

```sh
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-read --eta-newline=1
```

```
throughput-read: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
fio-3.16
Starting 1 process

throughput-read: (groupid=0, jobs=1): err= 0: pid=3591019: Fri Dec 12 15:23:11 2025
  read: IOPS=7438, BW=7439MiB/s (7800MB/s)(872GiB/120006msec)
    slat (usec): min=28, max=18199, avg=46.71, stdev=70.64
    clat (usec): min=2070, max=92469, avg=8552.52, stdev=1803.94
     lat (usec): min=2104, max=94607, avg=8599.43, stdev=1801.58
    clat percentiles (usec):
     |  1.00th=[ 5211],  5.00th=[ 5932], 10.00th=[ 6456], 20.00th=[ 7177],
     | 30.00th=[ 7701], 40.00th=[ 8094], 50.00th=[ 8455], 60.00th=[ 8848],
     | 70.00th=[ 9241], 80.00th=[ 9765], 90.00th=[10421], 95.00th=[11207],
     | 99.00th=[14091], 99.50th=[15795], 99.90th=[19530], 99.95th=[22414],
     | 99.99th=[28967]
   bw (  MiB/s): min= 4346, max= 8326, per=99.99%, avg=7437.94, stdev=593.48, samples=240
   iops        : min= 4346, max= 8326, avg=7437.92, stdev=593.47, samples=240
  lat (msec)   : 4=0.14%, 10=84.29%, 20=15.49%, 50=0.08%, 100=0.01%
  cpu          : usr=0.94%, sys=34.45%, ctx=46925, majf=0, minf=16396
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=892685,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=7439MiB/s (7800MB/s), 7439MiB/s-7439MiB/s (7800MB/s-7800MB/s), io=872GiB (936GB), run=120006-120006msec

Disk stats (read/write):
  sda: ios=891870/837, merge=0/160, ticks=7052957/5609, in_queue=5237460, util=99.99%
```

## Throughput test: sequential write

```sh
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-write --eta-newline=1
```

```
throughput-write: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
fio-3.16
Starting 1 process

throughput-write: (groupid=0, jobs=1): err= 0: pid=3591092: Fri Dec 12 15:25:12 2025
  write: IOPS=5314, BW=5314MiB/s (5572MB/s)(623GiB/120008msec); 0 zone resets
    slat (usec): min=32, max=27307, avg=73.81, stdev=114.46
    clat (nsec): min=1490, max=82519k, avg=11967980.62, stdev=6124129.91
     lat (usec): min=298, max=82579, avg=12041.96, stdev=6123.57
    clat percentiles (usec):
     |  1.00th=[  347],  5.00th=[ 4113], 10.00th=[ 7439], 20.00th=[ 8586],
     | 30.00th=[ 9241], 40.00th=[10028], 50.00th=[10814], 60.00th=[11600],
     | 70.00th=[12649], 80.00th=[14615], 90.00th=[18744], 95.00th=[22938],
     | 99.00th=[34866], 99.50th=[39584], 99.90th=[56886], 99.95th=[62653],
     | 99.99th=[73925]
   bw (  MiB/s): min= 1794, max= 7422, per=99.98%, avg=5313.18, stdev=1232.69, samples=240
   iops        : min= 1794, max= 7422, avg=5313.17, stdev=1232.69, samples=240
  lat (usec)   : 2=0.01%, 250=0.01%, 500=2.27%, 750=0.74%, 1000=0.30%
  lat (msec)   : 2=0.69%, 4=0.93%, 10=34.78%, 20=52.06%, 50=8.03%
  lat (msec)   : 100=0.19%
  cpu          : usr=15.57%, sys=24.20%, ctx=119426, majf=0, minf=12
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,637736,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=5314MiB/s (5572MB/s), 5314MiB/s-5314MiB/s (5572MB/s-5572MB/s), io=623GiB (669GB), run=120008-120008msec

Disk stats (read/write):
  sda: ios=24/637546, merge=0/216, ticks=187/7034248, in_queue=5771960, util=99.89%
```
