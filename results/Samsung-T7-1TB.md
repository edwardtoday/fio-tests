# 性能测试

`posixaio`是macOS的异步读写库，如果在Linux下运行测试，请改为`libaio`。

## IOPS test: random read/write

```sh
fio --filename=./fio-test.bin --size=1GB --direct=1 --rw=randrw --bs=4k --ioengine=posixaio --iodepth=256 --runtime=120 --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1
```

```
iops-test-job: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=256
...
fio-3.41
Starting 4 processes
iops-test-job: Laying out IO file (1 file / 1024MiB)

iops-test-job: (groupid=0, jobs=4): err= 0: pid=1440: Fri Dec 12 14:22:39 2025
  read: IOPS=5363, BW=20.9MiB/s (22.0MB/s)(2515MiB/120027msec)
    slat (nsec): min=0, max=3826.0k, avg=2838.19, stdev=8429.02
    clat (usec): min=4, max=364388, avg=3577.28, stdev=6050.90
     lat (usec): min=4, max=364389, avg=3580.12, stdev=6050.94
    clat percentiles (usec):
     |  1.00th=[   13],  5.00th=[  231], 10.00th=[  668], 20.00th=[ 1156],
     | 30.00th=[ 1549], 40.00th=[ 1860], 50.00th=[ 2147], 60.00th=[ 2442],
     | 70.00th=[ 2835], 80.00th=[ 3490], 90.00th=[ 5211], 95.00th=[11338],
     | 99.00th=[34341], 99.50th=[36439], 99.90th=[42206], 99.95th=[45876],
     | 99.99th=[55837]
   bw (  KiB/s): min= 5589, max=46517, per=100.00%, avg=21472.93, stdev=2894.58, samples=952
   iops        : min= 1396, max=11628, avg=5366.87, stdev=723.62, samples=952
  write: IOPS=5374, BW=21.0MiB/s (22.0MB/s)(2520MiB/120027msec); 0 zone resets
    slat (nsec): min=0, max=6552.0k, avg=2914.77, stdev=11659.13
    clat (usec): min=5, max=2428.0k, avg=8324.55, stdev=14245.99
     lat (usec): min=13, max=2428.0k, avg=8327.47, stdev=14245.97
    clat percentiles (usec):
     |  1.00th=[   314],  5.00th=[  1172], 10.00th=[  1680], 20.00th=[  2343],
     | 30.00th=[  2900], 40.00th=[  3490], 50.00th=[  4178], 60.00th=[  5145],
     | 70.00th=[  6521], 80.00th=[  9241], 90.00th=[ 19006], 95.00th=[ 35390],
     | 99.00th=[ 54264], 99.50th=[ 70779], 99.90th=[141558], 99.95th=[187696],
     | 99.99th=[362808]
   bw (  KiB/s): min= 5994, max=46572, per=100.00%, avg=21517.57, stdev=2890.89, samples=952
   iops        : min= 1498, max=11641, avg=5378.03, stdev=722.70, samples=952
  lat (usec)   : 10=0.20%, 20=0.85%, 50=1.09%, 100=0.31%, 250=0.48%
  lat (usec)   : 500=1.43%, 750=2.59%, 1000=3.20%
  lat (msec)   : 2=19.43%, 4=36.56%, 10=22.02%, 20=5.22%, 50=5.96%
  lat (msec)   : 100=0.55%, 250=0.09%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2000=0.01%, >=2000=0.01%
  cpu          : usr=1.13%, sys=21.33%, ctx=8264456, majf=0, minf=39
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=48.5%, 16=51.5%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.9%, 8=1.1%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=643728,645106,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=20.9MiB/s (22.0MB/s), 20.9MiB/s-20.9MiB/s (22.0MB/s-22.0MB/s), io=2515MiB (2637MB), run=120027-120027msec
  WRITE: bw=21.0MiB/s (22.0MB/s), 21.0MiB/s-21.0MiB/s (22.0MB/s-22.0MB/s), io=2520MiB (2642MB), run=120027-120027msec
```

## Throughput test: sequential read

```sh
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-test-job: (groupid=0, jobs=1): err= 0: pid=1785: Fri Dec 12 14:24:46 2025
  read: IOPS=285, BW=285MiB/s (299MB/s)(33.4GiB/120058msec)
    slat (nsec): min=0, max=129000, avg=1383.75, stdev=1585.92
    clat (usec): min=146, max=106215, avg=56101.77, stdev=9768.47
     lat (usec): min=146, max=106216, avg=56103.15, stdev=9768.36
    clat percentiles (usec):
     |  1.00th=[28967],  5.00th=[32900], 10.00th=[35390], 20.00th=[52167],
     | 30.00th=[55837], 40.00th=[56886], 50.00th=[59507], 60.00th=[60031],
     | 70.00th=[62653], 80.00th=[63177], 90.00th=[63701], 95.00th=[63701],
     | 99.00th=[66847], 99.50th=[67634], 99.90th=[73925], 99.95th=[77071],
     | 99.99th=[91751]
   bw (  KiB/s): min=267219, max=502875, per=100.00%, avg=292188.50, stdev=57160.88, samples=238
   iops        : min=  260, max=  491, avg=284.93, stdev=55.90, samples=238
  lat (usec)   : 250=0.02%, 500=0.03%
  lat (msec)   : 4=0.01%, 10=0.01%, 20=0.02%, 50=14.63%, 100=85.26%
  lat (msec)   : 250=0.01%
  cpu          : usr=0.11%, sys=3.02%, ctx=133660, majf=0, minf=1930
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.3%, 16=52.7%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.5%, 8=0.5%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=34236,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=285MiB/s (299MB/s), 285MiB/s-285MiB/s (299MB/s-299MB/s), io=33.4GiB (35.9GB), run=120058-120058msec
```

## Throughput test: sequential write

```sh
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-test-job: (groupid=0, jobs=1): err= 0: pid=2027: Fri Dec 12 14:26:55 2025
  write: IOPS=477, BW=478MiB/s (501MB/s)(56.0GiB/120018msec); 0 zone resets
    slat (nsec): min=0, max=2364.0k, avg=20320.57, stdev=32347.46
    clat (msec): min=2, max=1175, avg=33.44, stdev=63.71
     lat (msec): min=2, max=1175, avg=33.46, stdev=63.71
    clat percentiles (msec):
     |  1.00th=[    7],  5.00th=[   10], 10.00th=[   11], 20.00th=[   13],
     | 30.00th=[   15], 40.00th=[   17], 50.00th=[   19], 60.00th=[   22],
     | 70.00th=[   25], 80.00th=[   30], 90.00th=[   40], 95.00th=[  102],
     | 99.00th=[  368], 99.50th=[  443], 99.90th=[  625], 99.95th=[  701],
     | 99.99th=[  869]
   bw (  KiB/s): min=26360, max=854693, per=100.00%, avg=489611.70, stdev=360548.09, samples=238
   iops        : min=   25, max=  834, avg=477.67, stdev=352.12, samples=238
  lat (msec)   : 4=0.01%, 10=7.73%, 20=47.80%, 50=37.77%, 100=1.64%
  lat (msec)   : 250=2.67%, 500=2.04%, 750=0.31%, 1000=0.04%, 2000=0.01%
  cpu          : usr=0.95%, sys=13.22%, ctx=1030737, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.3%, 16=52.7%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.0%, 8=1.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,57363,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=478MiB/s (501MB/s), 478MiB/s-478MiB/s (501MB/s-501MB/s), io=56.0GiB (60.1GB), run=120018-120018msec
```