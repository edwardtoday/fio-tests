# 性能测试

`libaio` 为 Linux 异步 IO 引擎；本次测试在 t3.micro（cn-north-1）实例上进行。

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
iops-test-job: (g=0): rw=randrw, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=256
...
fio-2.1.5
Starting 4 processes
iops-test-job: Laying out IO file(s) (1 file(s) / 1024MB)

iops-test-job: (groupid=0, jobs=4): err= 0: pid=17455: Fri Dec 12 07:44:21 2025
  read : io=726840KB, bw=6056.5KB/s, iops=1514, runt=120019msec
    slat (usec): min=2, max=22092, avg=1340.23, stdev=2429.32
    clat (msec): min=16, max=444, avg=337.00, stdev=38.18
     lat (msec): min=16, max=445, avg=338.34, stdev=38.37
    clat percentiles (msec):
     |  1.00th=[  200],  5.00th=[  302], 10.00th=[  310], 20.00th=[  318],
     | 30.00th=[  326], 40.00th=[  334], 50.00th=[  338], 60.00th=[  347],
     | 70.00th=[  351], 80.00th=[  359], 90.00th=[  371], 95.00th=[  383],
     | 99.00th=[  404], 99.50th=[  412], 99.90th=[  429], 99.95th=[  429],
     | 99.99th=[  437]
    bw (KB  /s): min= 1123, max= 3936, per=24.95%, avg=1510.83, stdev=191.53
  write: io=725248KB, bw=6042.8KB/s, iops=1510, runt=120019msec
    slat (usec): min=3, max=22340, avg=1297.70, stdev=2386.71
    clat (msec): min=13, max=441, avg=337.38, stdev=36.60
     lat (msec): min=16, max=446, avg=338.67, stdev=36.71
    clat percentiles (msec):
     |  1.00th=[  269],  5.00th=[  302], 10.00th=[  310], 20.00th=[  318],
     | 30.00th=[  326], 40.00th=[  334], 50.00th=[  338], 60.00th=[  347],
     | 70.00th=[  351], 80.00th=[  359], 90.00th=[  371], 95.00th=[  383],
     | 99.00th=[  404], 99.50th=[  412], 99.90th=[  424], 99.95th=[  429],
     | 99.99th=[  433]
    bw (KB  /s): min= 1149, max= 3504, per=24.96%, avg=1508.27, stdev=165.51
    lat (msec) : 20=0.06%, 50=0.61%, 100=0.09%, 250=0.25%, 500=98.99%
  cpu          : usr=0.37%, sys=1.21%, ctx=359579, majf=0, minf=31
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued    : total=r=181710/w=181312/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: io=726840KB, aggrb=6056KB/s, minb=6056KB/s, maxb=6056KB/s, mint=120019msec, maxt=120019msec
  WRITE: io=725248KB, aggrb=6042KB/s, minb=6042KB/s, maxb=6042KB/s, mint=120019msec, maxt=120019msec

Disk stats (read/write):
  nvme0n1: ios=181453/181160, merge=0/129, ticks=2932516/2935528, in_queue=5751312, util=99.68%
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
throughput-read: (g=0): rw=read, bs=1M-1M/1M-1M/1M-1M, ioengine=libaio, iodepth=64
fio-2.1.5
Starting 1 process

throughput-read: (groupid=0, jobs=1): err= 0: pid=17791: Fri Dec 12 07:46:21 2025
  read : io=15158MB, bw=129278KB/s, iops=126, runt=120065msec
    slat (usec): min=45, max=68537, avg=7853.76, stdev=5670.81
    clat (msec): min=49, max=591, avg=487.39, stdev=70.14
     lat (msec): min=50, max=591, avg=495.24, stdev=70.50
    clat percentiles (msec):
     |  1.00th=[   90],  5.00th=[  392], 10.00th=[  486], 20.00th=[  502],
     | 30.00th=[  502], 40.00th=[  502], 50.00th=[  502], 60.00th=[  502],
     | 70.00th=[  502], 80.00th=[  506], 90.00th=[  506], 95.00th=[  510],
     | 99.00th=[  553], 99.50th=[  553], 99.90th=[  562], 99.95th=[  562],
     | 99.99th=[  594]
    bw (KB  /s): min=14307, max=268723, per=94.54%, avg=122225.41, stdev=28383.65
    lat (msec) : 50=0.01%, 100=1.15%, 250=1.97%, 500=13.89%, 750=82.99%
  cpu          : usr=0.13%, sys=1.00%, ctx=19213, majf=0, minf=16391
  IO depths    : 1=0.1%, 2=0.2%, 4=0.4%, 8=0.8%, 16=1.6%, 32=3.2%, >=64=93.8%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued    : total=r=15158/w=0/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: io=15158MB, aggrb=129278KB/s, minb=129278KB/s, maxb=129278KB/s, mint=120065msec, maxt=120065msec

Disk stats (read/write):
  nvme0n1: ios=60545/85, merge=0/107, ticks=3667348/4708, in_queue=3540132, util=99.49%
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
throughput-write: (g=0): rw=write, bs=1M-1M/1M-1M/1M-1M, ioengine=libaio, iodepth=64
fio-2.1.5
Starting 1 process

throughput-write: (groupid=0, jobs=1): err= 0: pid=18103: Fri Dec 12 07:48:22 2025
  write: io=15082MB, bw=128628KB/s, iops=125, runt=120067msec
    slat (usec): min=57, max=68125, avg=7892.06, stdev=5529.41
    clat (msec): min=56, max=605, avg=489.82, stdev=62.45
     lat (msec): min=58, max=605, avg=497.71, stdev=62.58
    clat percentiles (msec):
     |  1.00th=[  133],  5.00th=[  429], 10.00th=[  494], 20.00th=[  502],
     | 30.00th=[  502], 40.00th=[  502], 50.00th=[  502], 60.00th=[  502],
     | 70.00th=[  502], 80.00th=[  506], 90.00th=[  506], 95.00th=[  510],
     | 99.00th=[  545], 99.50th=[  553], 99.90th=[  562], 99.95th=[  562],
     | 99.99th=[  603]
    bw (KB  /s): min= 2031, max=142222, per=94.44%, avg=121477.24, stdev=27083.51
    lat (msec) : 100=0.60%, 250=1.98%, 500=13.98%, 750=83.44%
  cpu          : usr=0.93%, sys=0.97%, ctx=19145, majf=0, minf=8
  IO depths    : 1=0.1%, 2=0.2%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.7%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued    : total=r=0/w=15082/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: io=15082MB, aggrb=128627KB/s, minb=128627KB/s, maxb=128627KB/s, mint=120067msec, maxt=120067msec

Disk stats (read/write):
  nvme0n1: ios=0/60313, merge=0/139, ticks=0/3637288, in_queue=3501132, util=99.31%
---- done: ./fio-seq-write.log
```
