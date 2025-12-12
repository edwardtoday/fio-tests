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

iops-test-job: (groupid=0, jobs=4): err= 0: pid=97580: Fri Dec 12 14:08:51 2025
  read: IOPS=23.4k, BW=91.4MiB/s (95.8MB/s)(10.7GiB/120002msec)
    slat (nsec): min=0, max=16791k, avg=6496.22, stdev=30070.44
    clat (usec): min=4, max=38412, avg=900.03, stdev=805.39
     lat (usec): min=4, max=38419, avg=906.53, stdev=805.22
    clat percentiles (usec):
     |  1.00th=[   59],  5.00th=[  165], 10.00th=[  196], 20.00th=[  249],
     | 30.00th=[  314], 40.00th=[  400], 50.00th=[  523], 60.00th=[  750],
     | 70.00th=[ 1450], 80.00th=[ 1745], 90.00th=[ 2008], 95.00th=[ 2180],
     | 99.00th=[ 2540], 99.50th=[ 2868], 99.90th=[ 6783], 99.95th=[ 7570],
     | 99.99th=[14091]
   bw (  KiB/s): min=57664, max=169211, per=100.00%, avg=93651.36, stdev=2115.35, samples=952
   iops        : min=14414, max=42301, avg=23411.69, stdev=528.84, samples=952
  write: IOPS=23.4k, BW=91.4MiB/s (95.8MB/s)(10.7GiB/120002msec); 0 zone resets
    slat (nsec): min=0, max=24264k, avg=6670.93, stdev=39562.39
    clat (usec): min=5, max=46022, avg=1796.04, stdev=1420.37
     lat (usec): min=8, max=46173, avg=1802.72, stdev=1420.77
    clat percentiles (usec):
     |  1.00th=[  165],  5.00th=[  249], 10.00th=[  318], 20.00th=[  486],
     | 30.00th=[  750], 40.00th=[ 1188], 50.00th=[ 1663], 60.00th=[ 1958],
     | 70.00th=[ 2245], 80.00th=[ 2638], 90.00th=[ 3720], 95.00th=[ 4621],
     | 99.00th=[ 6390], 99.50th=[ 7111], 99.90th=[ 8455], 99.95th=[ 9241],
     | 99.99th=[14877]
   bw (  KiB/s): min=56771, max=171758, per=100.00%, avg=93645.84, stdev=2102.35, samples=952
   iops        : min=14191, max=42938, avg=23410.42, stdev=525.60, samples=952
  lat (usec)   : 10=0.04%, 20=0.18%, 50=0.36%, 100=0.40%, 250=11.68%
  lat (usec)   : 500=21.94%, 750=10.38%, 1000=5.11%
  lat (msec)   : 2=25.73%, 4=19.95%, 10=4.18%, 20=0.02%, 50=0.01%
  cpu          : usr=4.22%, sys=111.49%, ctx=31510171, majf=0, minf=38
  IO depths    : 1=0.1%, 2=0.1%, 4=0.7%, 8=54.8%, 16=44.3%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=97.8%, 8=1.9%, 16=0.3%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=2806792,2806577,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=91.4MiB/s (95.8MB/s), 91.4MiB/s-91.4MiB/s (95.8MB/s-95.8MB/s), io=10.7GiB (11.5GB), run=120002-120002msec
  WRITE: bw=91.4MiB/s (95.8MB/s), 91.4MiB/s-91.4MiB/s (95.8MB/s-95.8MB/s), io=10.7GiB (11.5GB), run=120002-120002msec
```

## Throughput test: sequential read

```sh
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-test-job: (groupid=0, jobs=1): err= 0: pid=97824: Fri Dec 12 14:10:58 2025
  read: IOPS=4677, BW=4678MiB/s (4905MB/s)(548GiB/120003msec)
    slat (nsec): min=0, max=2834.0k, avg=1165.95, stdev=4705.53
    clat (usec): min=608, max=35864, avg=3417.72, stdev=898.49
     lat (usec): min=610, max=35865, avg=3418.89, stdev=898.48
    clat percentiles (usec):
     |  1.00th=[ 2278],  5.00th=[ 2573], 10.00th=[ 2737], 20.00th=[ 2933],
     | 30.00th=[ 3064], 40.00th=[ 3195], 50.00th=[ 3326], 60.00th=[ 3458],
     | 70.00th=[ 3589], 80.00th=[ 3752], 90.00th=[ 3949], 95.00th=[ 4178],
     | 99.00th=[ 7898], 99.50th=[ 9241], 99.90th=[11207], 99.95th=[12649],
     | 99.99th=[27132]
   bw (  MiB/s): min= 1752, max= 5388, per=100.00%, avg=4680.10, stdev=648.40, samples=238
   iops        : min= 1752, max= 5388, avg=4679.63, stdev=648.37, samples=238
  lat (usec)   : 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.16%, 4=91.08%, 10=8.51%, 20=0.22%, 50=0.02%
  cpu          : usr=1.59%, sys=27.50%, ctx=1927520, majf=0, minf=1098
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.7%, 16=52.3%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.3%, 8=0.7%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=561329,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=4678MiB/s (4905MB/s), 4678MiB/s-4678MiB/s (4905MB/s-4905MB/s), io=548GiB (589GB), run=120003-120003msec
```

## Throughput test: sequential write

```sh
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-test-job: (groupid=0, jobs=1): err= 0: pid=98068: Fri Dec 12 14:13:04 2025
  write: IOPS=3027, BW=3028MiB/s (3175MB/s)(355GiB/120003msec); 0 zone resets
    slat (nsec): min=0, max=13830k, avg=16845.90, stdev=42411.55
    clat (usec): min=217, max=343073, avg=5255.90, stdev=7690.99
     lat (usec): min=399, max=343074, avg=5272.75, stdev=7692.66
    clat percentiles (usec):
     |  1.00th=[  1385],  5.00th=[  1582], 10.00th=[  1713], 20.00th=[  1909],
     | 30.00th=[  2114], 40.00th=[  2311], 50.00th=[  2573], 60.00th=[  2966],
     | 70.00th=[  3818], 80.00th=[  7963], 90.00th=[ 13435], 95.00th=[ 16188],
     | 99.00th=[ 31851], 99.50th=[ 40109], 99.90th=[ 87557], 99.95th=[111674],
     | 99.99th=[206570]
   bw (  MiB/s): min=  163, max= 5800, per=100.00%, avg=3029.54, stdev=2227.29, samples=238
   iops        : min=  163, max= 5800, avg=3029.06, stdev=2227.32, samples=238
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.02%
  lat (msec)   : 2=24.44%, 4=46.87%, 10=15.75%, 20=9.46%, 50=3.16%
  lat (msec)   : 100=0.22%, 250=0.06%, 500=0.01%
  cpu          : usr=5.47%, sys=42.78%, ctx=3747522, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=42.8%, 16=57.2%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.2%, 8=0.8%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,363328,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=3028MiB/s (3175MB/s), 3028MiB/s-3028MiB/s (3175MB/s-3175MB/s), io=355GiB (381GB), run=120003-120003msec
```