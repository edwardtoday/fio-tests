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

iops-test-job: (groupid=0, jobs=4): err= 0: pid=3590: Fri Dec 12 14:35:06 2025
  read: IOPS=380, BW=1520KiB/s (1557kB/s)(178MiB/120044msec)
    slat (nsec): min=0, max=375000, avg=2617.57, stdev=4918.58
    clat (usec): min=4, max=1146.5k, avg=63404.06, stdev=54718.51
     lat (usec): min=4, max=1146.5k, avg=63406.68, stdev=54718.58
    clat percentiles (usec):
     |  1.00th=[    13],  5.00th=[    48], 10.00th=[ 40109], 20.00th=[ 49546],
     | 30.00th=[ 52167], 40.00th=[ 54264], 50.00th=[ 56361], 60.00th=[ 57934],
     | 70.00th=[ 60556], 80.00th=[ 64226], 90.00th=[ 73925], 95.00th=[162530],
     | 99.00th=[316670], 99.50th=[404751], 99.90th=[549454], 99.95th=[583009],
     | 99.99th=[641729]
   bw (  KiB/s): min=   60, max= 3032, per=100.00%, avg=1521.57, stdev=166.25, samples=952
   iops        : min=   12, max=  758, avg=378.65, stdev=41.61, samples=952
  write: IOPS=382, BW=1532KiB/s (1568kB/s)(180MiB/120044msec); 0 zone resets
    slat (nsec): min=0, max=460000, avg=2765.34, stdev=4873.57
    clat (usec): min=5, max=5677.9k, avg=104183.48, stdev=142467.11
     lat (usec): min=6, max=5678.0k, avg=104186.24, stdev=142467.10
    clat percentiles (msec):
     |  1.00th=[    4],  5.00th=[   37], 10.00th=[   56], 20.00th=[   62],
     | 30.00th=[   65], 40.00th=[   69], 50.00th=[   73], 60.00th=[   79],
     | 70.00th=[   86], 80.00th=[  100], 90.00th=[  155], 95.00th=[  300],
     | 99.00th=[  609], 99.50th=[  793], 99.90th=[ 2072], 99.95th=[ 2232],
     | 99.99th=[ 3373]
   bw (  KiB/s): min=   85, max= 3130, per=100.00%, avg=1541.12, stdev=167.42, samples=947
   iops        : min=   19, max=  781, avg=383.47, stdev=41.91, samples=947
  lat (usec)   : 10=0.14%, 20=1.15%, 50=1.40%, 100=0.36%, 250=0.29%
  lat (usec)   : 500=0.13%, 750=0.12%, 1000=0.03%
  lat (msec)   : 2=0.28%, 4=0.44%, 10=1.15%, 20=1.18%, 50=6.82%
  lat (msec)   : 100=73.95%, 250=8.29%, 500=3.28%, 750=0.70%, 1000=0.11%
  lat (msec)   : 2000=0.13%, >=2000=0.05%
  cpu          : usr=0.10%, sys=1.23%, ctx=618803, majf=0, minf=40
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=48.6%, 16=51.4%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.9%, 8=1.1%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=45622,45964,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=1520KiB/s (1557kB/s), 1520KiB/s-1520KiB/s (1557kB/s-1557kB/s), io=178MiB (187MB), run=120044-120044msec
  WRITE: bw=1532KiB/s (1568kB/s), 1532KiB/s-1532KiB/s (1568kB/s-1568kB/s), io=180MiB (188MB), run=120044-120044msec
```

## Throughput test: sequential read

```sh
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-test-job: (groupid=0, jobs=1): err= 0: pid=3849: Fri Dec 12 14:37:15 2025
  read: IOPS=49, BW=49.3MiB/s (51.7MB/s)(5935MiB/120291msec)
    slat (nsec): min=0, max=166000, avg=1796.46, stdev=2721.80
    clat (msec): min=79, max=594, avg=324.18, stdev=33.99
     lat (msec): min=79, max=594, avg=324.18, stdev=33.99
    clat percentiles (msec):
     |  1.00th=[  218],  5.00th=[  266], 10.00th=[  284], 20.00th=[  305],
     | 30.00th=[  313], 40.00th=[  326], 50.00th=[  330], 60.00th=[  334],
     | 70.00th=[  347], 80.00th=[  351], 90.00th=[  355], 95.00th=[  359],
     | 99.00th=[  380], 99.50th=[  401], 99.90th=[  493], 99.95th=[  493],
     | 99.99th=[  592]
   bw (  KiB/s): min=40554, max=81269, per=100.00%, avg=50545.63, stdev=4627.58, samples=238
   iops        : min=   39, max=   79, avg=48.82, stdev= 4.54, samples=238
  lat (msec)   : 100=0.12%, 250=3.17%, 500=96.68%, 750=0.03%
  cpu          : usr=0.03%, sys=0.56%, ctx=22896, majf=0, minf=1249
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.6%, 16=52.3%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.0%, 8=1.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=5935,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=49.3MiB/s (51.7MB/s), 49.3MiB/s-49.3MiB/s (51.7MB/s-51.7MB/s), io=5935MiB (6223MB), run=120291-120291msec
```

## Throughput test: sequential write

```sh
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-test-job: (groupid=0, jobs=1): err= 0: pid=4083: Fri Dec 12 14:39:24 2025
  write: IOPS=68, BW=68.6MiB/s (71.9MB/s)(8247MiB/120230msec); 0 zone resets
    slat (nsec): min=0, max=264000, avg=21783.56, stdev=30885.13
    clat (msec): min=103, max=418, avg=233.15, stdev=20.77
     lat (msec): min=103, max=418, avg=233.17, stdev=20.78
    clat percentiles (msec):
     |  1.00th=[  182],  5.00th=[  199], 10.00th=[  207], 20.00th=[  218],
     | 30.00th=[  224], 40.00th=[  230], 50.00th=[  236], 60.00th=[  241],
     | 70.00th=[  245], 80.00th=[  249], 90.00th=[  257], 95.00th=[  264],
     | 99.00th=[  279], 99.50th=[  284], 99.90th=[  321], 99.95th=[  351],
     | 99.99th=[  418]
   bw (  KiB/s): min=58920, max=81756, per=100.00%, avg=70279.16, stdev=3178.94, samples=238
   iops        : min=   57, max=   79, avg=68.21, stdev= 3.13, samples=238
  lat (msec)   : 250=81.47%, 500=18.53%
  cpu          : usr=0.15%, sys=0.96%, ctx=31582, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.4%, 16=52.5%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.5%, 8=0.5%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,8247,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=68.6MiB/s (71.9MB/s), 68.6MiB/s-68.6MiB/s (71.9MB/s-71.9MB/s), io=8247MiB (8648MB), run=120230-120230msec
```