# 性能测试

`libaio` 为 Linux 异步 IO 引擎；本次测试在 g5.xlarge（cn-north-1）实例上进行。

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

iops-test-job: (groupid=0, jobs=4): err= 0: pid=748677: Fri Dec 12 07:55:04 2025
  read: IOPS=1511, BW=6046KiB/s (6191kB/s)(709MiB/120012msec)
    slat (usec): min=3, max=91039, avg=1286.95, stdev=4450.86
    clat (msec): min=11, max=1461, avg=337.91, stdev=153.29
     lat (msec): min=11, max=1476, avg=339.19, stdev=153.62
    clat percentiles (msec):
     |  1.00th=[  146],  5.00th=[  186], 10.00th=[  203], 20.00th=[  230],
     | 30.00th=[  253], 40.00th=[  275], 50.00th=[  300], 60.00th=[  330],
     | 70.00th=[  359], 80.00th=[  414], 90.00th=[  523], 95.00th=[  659],
     | 99.00th=[  944], 99.50th=[ 1011], 99.90th=[ 1083], 99.95th=[ 1217],
     | 99.99th=[ 1401]
   bw (  KiB/s): min= 1128, max=13760, per=99.77%, avg=6032.17, stdev=514.54, samples=956
   iops        : min=  282, max= 3440, avg=1508.04, stdev=128.64, samples=956
  write: IOPS=1511, BW=6045KiB/s (6190kB/s)(708MiB/120012msec); 0 zone resets
    slat (usec): min=3, max=98086, avg=1355.05, stdev=4606.34
    clat (msec): min=9, max=1504, avg=336.92, stdev=152.78
     lat (msec): min=11, max=1523, avg=338.27, stdev=153.14
    clat percentiles (msec):
     |  1.00th=[  142],  5.00th=[  184], 10.00th=[  203], 20.00th=[  228],
     | 30.00th=[  251], 40.00th=[  275], 50.00th=[  300], 60.00th=[  326],
     | 70.00th=[  359], 80.00th=[  414], 90.00th=[  518], 95.00th=[  659],
     | 99.00th=[  936], 99.50th=[ 1011], 99.90th=[ 1083], 99.95th=[ 1217],
     | 99.99th=[ 1435]
   bw (  KiB/s): min= 1088, max=14544, per=99.77%, avg=6031.56, stdev=520.44, samples=956
   iops        : min=  272, max= 3636, avg=1507.89, stdev=130.11, samples=956
  lat (msec)   : 10=0.01%, 20=0.01%, 50=0.68%, 100=0.09%, 250=28.33%
  lat (msec)   : 500=59.48%, 750=8.29%, 1000=2.57%, 2000=0.56%
  cpu          : usr=0.19%, sys=0.86%, ctx=152143, majf=0, minf=57
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=r=181389/w=181369/d=0 short=r=0/w=0/d=0 dropped=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=6046KiB/s (6191kB/s), 6046KiB/s-6046KiB/s (6191kB/s-6191kB/s), io=709MiB (743MB), run=120012-120012msec
  WRITE: bw=6045KiB/s (6190kB/s), 6045KiB/s-6045KiB/s (6190kB/s-6190kB/s), io=708MiB (743MB), run=120012-120012msec

Disk stats (read/write):
  nvme0n1: ios=181252/181328, sectors=1456104/1452096, merge=0/96, ticks=3544057/3531757, in_queue=7075814, util=96.64%
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

throughput-read: (groupid=0, jobs=1): err= 0: pid=749836: Fri Dec 12 07:57:04 2025
  read: IOPS=126, BW=126MiB/s (132MB/s)(14.8GiB/120073msec)
    slat (usec): min=73, max=67472, avg=7918.02, stdev=9381.39
    clat (msec): min=52, max=617, avg=499.20, stdev=44.58
     lat (msec): min=53, max=623, avg=507.12, stdev=45.12
    clat percentiles (msec):
     |  1.00th=[  309],  5.00th=[  460], 10.00th=[  477], 20.00th=[  502],
     | 30.00th=[  502], 40.00th=[  502], 50.00th=[  502], 60.00th=[  506],
     | 70.00th=[  506], 80.00th=[  506], 90.00th=[  527], 95.00th=[  542],
     | 99.00th=[  558], 99.50th=[  558], 99.90th=[  567], 99.95th=[  575],
     | 99.99th=[  617]
   bw (  KiB/s): min=114688, max=270336, per=99.64%, avg=128742.40, stdev=9547.76, samples=240
   iops        : min=  112, max=  264, avg=125.73, stdev= 9.32, samples=240
  lat (msec)   : 100=0.61%, 250=0.30%, 500=24.37%, 750=74.73%
  cpu          : usr=0.05%, sys=1.56%, ctx=17182, majf=0, minf=16395
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.2%, >=64=99.6%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=15150,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=126MiB/s (132MB/s), 126MiB/s-126MiB/s (132MB/s-132MB/s), io=14.8GiB (15.9GB), run=120073-120073msec

Disk stats (read/write):
  nvme0n1: ios=60752/32, sectors=30996896/768, merge=0/37, ticks=3914982/1301, in_queue=3916283, util=98.59%
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

throughput-write: (groupid=0, jobs=1): err= 0: pid=750993: Fri Dec 12 07:59:04 2025
  write: IOPS=125, BW=125MiB/s (132MB/s)(14.7GiB/120068msec); 0 zone resets
    slat (usec): min=70, max=70990, avg=7962.37, stdev=12500.46
    clat (msec): min=57, max=607, avg=502.01, stdev=31.62
     lat (msec): min=70, max=607, avg=509.97, stdev=31.89
    clat percentiles (msec):
     |  1.00th=[  447],  5.00th=[  460], 10.00th=[  468], 20.00th=[  489],
     | 30.00th=[  502], 40.00th=[  502], 50.00th=[  506], 60.00th=[  506],
     | 70.00th=[  506], 80.00th=[  518], 90.00th=[  542], 95.00th=[  550],
     | 99.00th=[  558], 99.50th=[  558], 99.90th=[  567], 99.95th=[  567],
     | 99.99th=[  600]
   bw (  KiB/s): min=108544, max=143360, per=99.64%, avg=128017.07, stdev=6694.84, samples=240
   iops        : min=  106, max=  140, avg=125.02, stdev= 6.54, samples=240
  lat (msec)   : 100=0.03%, 250=0.30%, 500=29.68%, 750=69.98%
  cpu          : usr=0.35%, sys=1.37%, ctx=13938, majf=0, minf=11
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.2%, >=64=99.6%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,15065,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=125MiB/s (132MB/s), 125MiB/s-125MiB/s (132MB/s-132MB/s), io=14.7GiB (15.8GB), run=120068-120068msec

Disk stats (read/write):
  nvme0n1: ios=336/60222, sectors=19376/30799680, merge=0/55, ticks=24006/4175218, in_queue=4199224, util=98.33%
---- done: ./fio-seq-write.log
```
