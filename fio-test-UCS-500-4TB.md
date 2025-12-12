# 性能测试

`libaio`为 Linux 异步 IO 引擎；本次测试在 UCS-500 4TB 上进行。

## IOPS test: random read/write

```sh
fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randrw --bs=4k \
    --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
    --group_reporting --name=iops-test-job --eta-newline=1
```

```
iops-test-job: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=256
...
fio-3.28
Starting 4 processes
iops-test-job: Laying out IO file (1 file / 1024MiB)

iops-test-job: (groupid=0, jobs=4): err= 0: pid=1571083: Fri Dec 12 15:03:55 2025
  read: IOPS=223k, BW=871MiB/s (914MB/s)(102GiB/120003msec)
    slat (nsec): min=1001, max=5995.7k, avg=1859.30, stdev=2847.77
    clat (usec): min=19, max=55863, avg=1901.06, stdev=1511.81
     lat (usec): min=21, max=55868, avg=1902.95, stdev=1511.97
    clat percentiles (usec):
     |  1.00th=[  330],  5.00th=[  486], 10.00th=[  594], 20.00th=[  783],
     | 30.00th=[  971], 40.00th=[ 1205], 50.00th=[ 1483], 60.00th=[ 1811],
     | 70.00th=[ 2278], 80.00th=[ 2966], 90.00th=[ 3752], 95.00th=[ 4293],
     | 99.00th=[ 7504], 99.50th=[ 9110], 99.90th=[14091], 99.95th=[16712],
     | 99.99th=[24773]
   bw (  KiB/s): min=231632, max=969672, per=100.00%, avg=892435.85, stdev=27569.64, samples=956
   iops        : min=57908, max=242418, avg=223108.96, stdev=6892.41, samples=956
  write: IOPS=223k, BW=871MiB/s (914MB/s)(102GiB/120003msec); 0 zone resets
    slat (nsec): min=1060, max=6039.9k, avg=2037.52, stdev=3055.86
    clat (nsec): min=502, max=59946k, avg=2685023.90, stdev=1487291.22
     lat (usec): min=8, max=59954, avg=2687.09, stdev=1487.43
    clat percentiles (usec):
     |  1.00th=[  334],  5.00th=[ 1221], 10.00th=[ 1467], 20.00th=[ 1663],
     | 30.00th=[ 1811], 40.00th=[ 1975], 50.00th=[ 2245], 60.00th=[ 2606],
     | 70.00th=[ 3064], 80.00th=[ 3785], 90.00th=[ 4621], 95.00th=[ 5080],
     | 99.00th=[ 7242], 99.50th=[ 8717], 99.90th=[15139], 99.95th=[19530],
     | 99.99th=[26608]
   bw (  KiB/s): min=230400, max=968320, per=100.00%, avg=892415.63, stdev=27476.19, samples=956
   iops        : min=57600, max=242080, avg=223103.91, stdev=6869.05, samples=956
  lat (nsec)   : 750=0.01%
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.03%, 100=0.06%
  lat (usec)   : 250=0.40%, 500=3.01%, 750=6.72%, 1000=7.07%
  lat (msec)   : 2=35.49%, 4=35.00%, 10=11.91%, 20=0.27%, 50=0.03%
  lat (msec)   : 100=0.01%
  cpu          : usr=6.43%, sys=25.50%, ctx=23626628, majf=0, minf=88
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=26767855,26767787,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=871MiB/s (914MB/s), 871MiB/s-871MiB/s (914MB/s-914MB/s), io=102GiB (110GB), run=120003-120003msec
  WRITE: bw=871MiB/s (914MB/s), 871MiB/s-871MiB/s (914MB/s-914MB/s), io=102GiB (110GB), run=120003-120003msec

Disk stats (read/write):
  nvme0n1: ios=26737668/26736482, merge=0/239, ticks=50572401/70785726, in_queue=121358200, util=74.62%
```

## Throughput test: sequential read

```sh
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-read --eta-newline=1
```

```
throughput-read: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
fio-3.28
Starting 1 process
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-write --eta-newline=1 | tee seq-write.log

throughput-read: (groupid=0, jobs=1): err= 0: pid=1578266: Fri Dec 12 15:14:32 2025
  read: IOPS=1991, BW=1991MiB/s (2088MB/s)(233GiB/120031msec)
    slat (usec): min=34, max=1071, avg=189.85, stdev=42.74
    clat (usec): min=4247, max=82335, avg=31946.38, stdev=5700.42
     lat (usec): min=4611, max=82569, avg=32136.34, stdev=5698.36
    clat percentiles (usec):
     |  1.00th=[ 9372],  5.00th=[27657], 10.00th=[29754], 20.00th=[30540],
     | 30.00th=[30802], 40.00th=[31327], 50.00th=[31589], 60.00th=[32113],
     | 70.00th=[32900], 80.00th=[33817], 90.00th=[34866], 95.00th=[37487],
     | 99.00th=[54264], 99.50th=[57934], 99.90th=[65274], 99.95th=[68682],
     | 99.99th=[74974]
   bw (  MiB/s): min= 1910, max= 2074, per=100.00%, avg=1993.15, stdev=33.09, samples=239
   iops        : min= 1910, max= 2074, avg=1993.15, stdev=33.09, samples=239
  lat (msec)   : 10=1.17%, 20=2.19%, 50=94.74%, 100=1.90%
  cpu          : usr=0.43%, sys=40.38%, ctx=226323, majf=0, minf=16397
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=239013,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=1991MiB/s (2088MB/s), 1991MiB/s-1991MiB/s (2088MB/s-2088MB/s), io=233GiB (251GB), run=120031-120031msec

Disk stats (read/write):
  nvme0n1: ios=1910247/614, merge=0/171, ticks=60250207/3564, in_queue=60253917, util=77.82%
```

## Throughput test: sequential write

```sh
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M \
    --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=1 --time_based \
    --group_reporting --name=throughput-write --eta-newline=1
```

```
throughput-write: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
fio-3.28
Starting 1 process

throughput-write: (groupid=0, jobs=1): err= 0: pid=1579655: Fri Dec 12 15:16:32 2025
  write: IOPS=2509, BW=2509MiB/s (2631MB/s)(294GiB/120025msec); 0 zone resets
    slat (usec): min=47, max=622275, avg=150.54, stdev=1240.97
    clat (usec): min=1110, max=1416.4k, avg=25354.11, stdev=33057.44
     lat (usec): min=1213, max=1416.6k, avg=25504.74, stdev=33105.08
    clat percentiles (msec):
     |  1.00th=[   17],  5.00th=[   20], 10.00th=[   20], 20.00th=[   20],
     | 30.00th=[   20], 40.00th=[   20], 50.00th=[   21], 60.00th=[   21],
     | 70.00th=[   25], 80.00th=[   25], 90.00th=[   27], 95.00th=[   48],
     | 99.00th=[   81], 99.50th=[  108], 99.90th=[  575], 99.95th=[  701],
     | 99.99th=[ 1099]
   bw (  MiB/s): min=   30, max= 3092, per=100.00%, avg=2509.26, stdev=957.66, samples=239
   iops        : min=   30, max= 3092, avg=2509.26, stdev=957.66, samples=239
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.34%, 20=50.48%, 50=44.37%
  lat (msec)   : 100=4.26%, 250=0.17%, 500=0.23%, 750=0.10%, 1000=0.02%
  lat (msec)   : 2000=0.01%
  cpu          : usr=10.18%, sys=27.31%, ctx=285485, majf=0, minf=13
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,301168,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=2509MiB/s (2631MB/s), 2509MiB/s-2509MiB/s (2631MB/s-2631MB/s), io=294GiB (316GB), run=120025-120025msec

Disk stats (read/write):
  nvme0n1: ios=189/2406249, merge=0/178, ticks=2206/60259828, in_queue=60262426, util=82.89%
```
