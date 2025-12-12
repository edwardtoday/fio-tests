# 性能测试

`libaio`为 Linux 异步 IO 引擎；本次测试在 Linode 16GB 实例上进行。

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

iops-test-job: (groupid=0, jobs=4): err= 0: pid=93365: Fri Dec 12 07:23:46 2025
  read: IOPS=43.7k, BW=171MiB/s (179MB/s)(20.0GiB/120012msec)
    slat (usec): min=3, max=38024, avg=26.84, stdev=210.41
    clat (usec): min=148, max=91857, avg=11513.32, stdev=7515.44
     lat (usec): min=154, max=91865, avg=11540.16, stdev=7522.27
    clat percentiles (usec):
     |  1.00th=[  930],  5.00th=[ 1549], 10.00th=[ 2180], 20.00th=[ 3851],
     | 30.00th=[ 6128], 40.00th=[ 8586], 50.00th=[ 10945], 60.00th=[ 13304],
     | 70.00th=[ 15664], 80.00th=[ 18220], 90.00th=[ 21365], 95.00th=[ 23987],
     | 99.00th=[ 30540], 99.50th=[ 34866], 99.90th=[ 46924], 99.95th=[ 51119],
     | 99.99th=[ 63177]
   bw (  KiB/s): min=138728, max=209986, per=100.00%, avg=175086.50, stdev=2557.61, samples=956
   iops        : min=34682, max=52496, avg=43771.48, stdev=639.40, samples=956
  write: IOPS=43.7k, BW=171MiB/s (179MB/s)(20.0GiB/120012msec); 0 zone resets
    slat (usec): min=4, max=35693, avg=27.64, stdev=213.29
    clat (usec): min=87, max=91996, avg=11853.29, stdev=7598.61
     lat (usec): min=99, max=92015, avg=11880.92, stdev=7605.45
    clat percentiles (usec):
     |  1.00th=[  947],  5.00th=[ 1680], 10.00th=[ 2376], 20.00th=[ 4146],
     | 30.00th=[ 6456], 40.00th=[ 8848], 50.00th=[ 11338], 60.00th=[ 13698],
     | 70.00th=[ 16057], 80.00th=[ 18482], 90.00th=[ 21890], 95.00th=[ 24249],
     | 99.00th=[ 31065], 99.50th=[ 35914], 99.90th=[ 47449], 99.95th=[ 51643],
     | 99.99th=[ 64226]
   bw (  KiB/s): min=139832, max=208129, per=100.00%, avg=175012.75, stdev=2569.20, samples=952
   iops        : min=  202, max=60950, avg=40660.80, stdev=2723.53, samples=952
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.09%, 750=0.36%, 1000=0.79%
  lat (msec)   : 2=6.72%, 4=12.05%, 10=25.25%, 20=40.24%, 50=14.44%
  lat (msec)   : 100=0.06%
  cpu          : usr=3.16%, sys=19.67%, ctx=2550103, majf=0, minf=61
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=5247748,5245357,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=171MiB/s (179MB/s), 171MiB/s-171MiB/s (179MB/s-179MB/s), io=20.0GiB (21.5GB), run=120012-120012msec
  WRITE: bw=171MiB/s (179MB/s), 171MiB/s-171MiB/s (179MB/s-179MB/s), io=20.0GiB (21.5GB), run=120012-120012msec

Disk stats (read/write):
  sda: ios=5243085/5241251, sectors=41944688/41942688, merge=0/322, ticks=53397865/52418173, in_queue=105816206, util=100.00%
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

throughput-read: (groupid=0, jobs=1): err= 0: pid=93464: Fri Dec 12 07:25:47 2025
  read: IOPS=8617, BW=8617MiB/s (9036MB/s)(1010GiB/120006msec)
    slat (usec): min=28, max=9275, avg=57.82, stdev=58.64
    clat (usec): min=1242, max=256749, avg=7367.38, stdev=1031.47
     lat (usec): min=1294, max=256805, avg=7425.20, stdev=1025.20
    clat percentiles (usec):
     |  1.00th=[ 5145],  5.00th=[ 5800], 10.00th=[ 6128], 20.00th=[ 6521],
     | 30.00th=[ 6849], 40.00th=[ 7111], 50.00th=[ 7308], 60.00th=[ 7570],
     | 70.00th=[ 7832], 80.00th=[ 8160], 90.00th=[ 8586], 95.00th=[ 8979],
     | 99.00th=[10028], 99.50th=[10814], 99.90th=[12649], 99.95th=[13304],
     | 99.99th=[15008]
   bw (  MiB/s): min= 7852, max= 9200, per=100.00%, avg=8623.32, stdev=271.73, samples=239
   iops        : min= 7852, max= 9200, avg=8623.33, stdev=271.72, samples=239
  lat (msec)   : 2=0.01%, 4=0.12%, 10=98.86%, 20=1.01%, 50=0.01%
  cpu          : usr=1.42%, sys=54.81%, ctx=43984, majf=0, minf=16395
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=1034122,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=8617MiB/s (9036MB/s), 8617MiB/s-8617MiB/s (9036MB/s-9036MB/s), io=1010GiB (1084GB), run=120006-120006msec

Disk stats (read/write):
  sda: ios=1437478/423, sectors=2115825696/36544, merge=0/590, ticks=9386430/4591, in_queue=9391741, util=99.97%
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

throughput-write: (groupid=0, jobs=1): err= 0: pid=93599: Fri Dec 12 07:27:47 2025
  write: IOPS=6067, BW=6068MiB/s (6363MB/s)(711GiB/120007msec); 0 zone resets
    slat (usec): min=33, max=10354, avg=89.05, stdev=120.48
    clat (usec): min=326, max=383134, avg=10458.76, stdev=6948.66
     lat (usec): min=397, max=383223, avg=10546.31, stdev=6949.16
    clat percentiles (usec):
     |  1.00th=[ 4817],  5.00th=[ 7504], 10.00th=[ 8848], 20.00th=[ 9503],
     | 30.00th=[ 9896], 40.00th=[10159], 50.00th=[10421], 60.00th=[10683],
     | 70.00th=[11076], 80.00th=[11600], 90.00th=[12518], 95.00th=[14353],
     | 99.00th=[19792], 99.50th=[30802], 99.90th=[66847], 99.95th=[74974],
     | 99.99th=[99091]
   bw (  MiB/s): min= 3686, max= 6927, per=100.00%, avg=5888.27, stdev=359.73, samples=238
   iops        : min= 3686, max= 6927, avg=5888.21, stdev=359.72, samples=238
  lat (usec)   : 500=0.06%, 750=0.05%, 1000=0.03%
  lat (msec)   : 2=0.09%, 4=0.24%, 10=53.99%, 20=66.37%, 50=0.70%
  lat (msec)   : 100=0.01%, 250=0.12%, 500=0.01%
  cpu          : usr=19.91%, sys=32.71%, ctx=111583, majf=0, minf=12
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,706313,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=6068MiB/s (6363MB/s), 6068MiB/s-6068MiB/s (6363MB/s-6363MB/s), io=711GiB (764GB), run=120007-120007msec

Disk stats (read/write):
  sda: ios=2/1334034, sectors=12048/1488398400, merge=0/377, ticks=2577/13571157, in_queue=13574329, util=99.89%
```
