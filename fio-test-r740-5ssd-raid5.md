# 性能测试

`libaio`为 Linux 环境下的异步 IO 引擎；本次测试在 r740 5SSD RAID5 上进行。

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

iops-test-job: (groupid=0, jobs=4): err= 0: pid=748099: Fri Dec 12 06:50:05 2025
  read: IOPS=21.9k, BW=85.5MiB/s (89.6MB/s)(10.0GiB/120008msec)
    slat (usec): min=3, max=5885, avg=74.95, stdev=139.96
    clat (usec): min=5938, max=57290, avg=23461.33, stdev=2866.37
     lat (usec): min=5947, max=57307, avg=23536.50, stdev=2871.09
    clat percentiles (usec):
     |  1.00th=[16909],  5.00th=[18744], 10.00th=[19792], 20.00th=[21103],
     | 30.00th=[21890], 40.00th=[22676], 50.00th=[23462], 60.00th=[23987],
     | 70.00th=[24773], 80.00th=[25822], 90.00th=[27132], 95.00th=[28181],
     | 99.00th=[30278], 99.50th=[31327], 99.90th=[33817], 99.95th=[36439],
     | 99.99th=[48497]
   bw (  KiB/s): min=76992, max=105160, per=99.97%, avg=87485.20, stdev=1227.51, samples=960
   iops        : min=19248, max=26290, avg=21871.16, stdev=306.87, samples=960
  write: IOPS=21.9k, BW=85.5MiB/s (89.6MB/s)(10.0GiB/120008msec); 0 zone resets
    slat (usec): min=4, max=5618, avg=99.93, stdev=192.65
    clat (usec): min=5878, max=57649, avg=23155.97, stdev=2826.71
     lat (usec): min=5962, max=57671, avg=23256.11, stdev=2837.01
    clat percentiles (usec):
     |  1.00th=[16712],  5.00th=[18482], 10.00th=[19530], 20.00th=[20841],
     | 30.00th=[21627], 40.00th=[22414], 50.00th=[23200], 60.00th=[23725],
     | 70.00th=[24511], 80.00th=[25560], 90.00th=[26608], 95.00th=[27919],
     | 99.00th=[30016], 99.50th=[30802], 99.90th=[33162], 99.95th=[34866],
     | 99.99th=[44827]
   bw (  KiB/s): min=77224, max=106336, per=99.97%, avg=87505.72, stdev=1247.42, samples=960
   iops        : min=19306, max=26584, avg=21876.29, stdev=311.85, samples=960
  lat (msec)   : 10=0.01%, 20=11.71%, 50=88.28%, 100=0.01%
  cpu          : usr=5.85%, sys=28.56%, ctx=3773844, majf=0, minf=7195
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=2625575,2626153,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=85.5MiB/s (89.6MB/s), 85.5MiB/s-85.5MiB/s (89.6MB/s-89.6MB/s), io=10.0GiB (10.8GB), run=120008-120008msec
  WRITE: bw=85.5MiB/s (89.6MB/s), 85.5MiB/s-85.5MiB/s (89.6MB/s-89.6MB/s), io=10.0GiB (10.8GB), run=120008-120008msec
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

throughput-read: (groupid=0, jobs=1): err= 0: pid=748249: Fri Dec 12 07:02:13 2025
  read: IOPS=5688, BW=5689MiB/s (5965MB/s)(667GiB/120009msec)
    slat (usec): min=40, max=1522, avg=104.78, stdev=60.94
    clat (usec): min=359, max=35127, avg=11142.44, stdev=1525.14
     lat (usec): min=531, max=35868, avg=11247.36, stdev=1524.06
    clat percentiles (usec):
     |  1.00th=[ 4883],  5.00th=[ 8291], 10.00th=[10159], 20.00th=[10814],
     | 30.00th=[11076], 40.00th=[11207], 50.00th=[11338], 60.00th=[11469],
     | 70.00th=[11600], 80.00th=[11731], 90.00th=[12256], 95.00th=[12518],
     | 99.00th=[15926], 99.50th=[16909], 99.90th=[17695], 99.95th=[17957],
     | 99.99th=[21890]
   bw (  MiB/s): min= 4812, max= 5728, per=99.99%, avg=5688.03, stdev=61.16, samples=240
   iops        : min= 4812, max= 5728, avg=5687.99, stdev=61.16, samples=240
  lat (usec)   : 500=0.01%, 750=0.03%, 1000=0.11%
  lat (msec)   : 2=0.18%, 4=0.28%, 10=8.50%, 20=90.89%, 50=0.02%
  cpu          : usr=1.95%, sys=60.47%, ctx=423119, majf=0, minf=16406
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=682700,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=5689MiB/s (5965MB/s), 5689MiB/s-5689MiB/s (5965MB/s-5965MB/s), io=667GiB (716GB), run=120009-120009msec

Disk stats (read/write):
  sda: ios=2728028/6310, merge=0/95, ticks=26160009/67291, in_queue=19357656, util=100.00%
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

throughput-write: (groupid=0, jobs=1): err= 0: pid=748370: Fri Dec 12 07:04:30 2025
  write: IOPS=1825, BW=1825MiB/s (1914MB/s)(214GiB/120035msec); 0 zone resets
    slat (usec): min=56, max=35488, avg=357.92, stdev=512.51
    clat (usec): min=6222, max=73496, avg=34699.68, stdev=3299.46
     lat (usec): min=6343, max=73724, avg=35057.92, stdev=3303.57
    clat percentiles (usec):
     |  1.00th=[24511],  5.00th=[33162], 10.00th=[33424], 20.00th=[33817],
     | 30.00th=[34341], 40.00th=[34341], 50.00th=[34341], 60.00th=[34866],
     | 70.00th=[34866], 80.00th=[34866], 90.00th=[35390], 95.00th=[39060],
     | 99.00th=[45876], 99.50th=[52691], 99.90th=[62653], 99.95th=[64226],
     | 99.99th=[68682]
   bw (  MiB/s): min= 1734, max= 2710, per=99.99%, avg=1825.17, stdev=64.33, samples=240
   iops        : min= 1734, max= 2710, avg=1825.15, stdev=64.34, samples=240
  lat (msec)   : 10=0.11%, 20=0.63%, 50=98.63%, 100=0.63%
  cpu          : usr=15.14%, sys=23.14%, ctx=165963, majf=0, minf=19
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,219110,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=1825MiB/s (1914MB/s), 1825MiB/s-1825MiB/s (1914MB/s-1914MB/s), io=214GiB (230GB), run=120035-120035msec

Disk stats (read/write):
  sda: ios=619/879607, merge=682/187, ticks=25412/30118362, in_queue=28311296, util=99.95%
```
