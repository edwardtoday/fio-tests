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

iops-test-job: (groupid=0, jobs=4): err= 0: pid=89253: Fri Dec 12 13:02:42 2025
  read: IOPS=961, BW=3848KiB/s (3940kB/s)(452MiB/120417msec)
    slat (nsec): min=0, max=9599.0k, avg=2507.33, stdev=29228.25
    clat (usec): min=4, max=421190, avg=23022.56, stdev=14650.43
     lat (usec): min=4, max=421191, avg=23025.07, stdev=14650.63
    clat percentiles (usec):
     |  1.00th=[    11],  5.00th=[    15], 10.00th=[    22], 20.00th=[  1004],
     | 30.00th=[ 26346], 40.00th=[ 28181], 50.00th=[ 28967], 60.00th=[ 29754],
     | 70.00th=[ 30802], 80.00th=[ 32113], 90.00th=[ 34341], 95.00th=[ 36963],
     | 99.00th=[ 53216], 99.50th=[ 57934], 99.90th=[ 77071], 99.95th=[113771],
     | 99.99th=[258999]
   bw (  KiB/s): min=   28, max= 6444, per=100.00%, avg=3852.86, stdev=245.20, samples=955
   iops        : min=    4, max= 1610, avg=961.92, stdev=61.32, samples=955
  write: IOPS=967, BW=3870KiB/s (3963kB/s)(455MiB/120417msec); 0 zone resets
    slat (nsec): min=0, max=36680k, avg=3175.28, stdev=121894.96
    clat (usec): min=6, max=3085.1k, avg=43215.40, stdev=59222.41
     lat (usec): min=8, max=3085.1k, avg=43218.57, stdev=59222.54
    clat percentiles (usec):
     |  1.00th=[   1012],  5.00th=[   3720], 10.00th=[   7570],
     | 20.00th=[  28181], 30.00th=[  31065], 40.00th=[  32900],
     | 50.00th=[  34866], 60.00th=[  36439], 70.00th=[  39584],
     | 80.00th=[  44303], 90.00th=[  58459], 95.00th=[  92799],
     | 99.00th=[ 312476], 99.50th=[ 446694], 99.90th=[ 717226],
     | 99.95th=[ 784335], 99.99th=[1199571]
   bw (  KiB/s): min=   52, max= 7120, per=99.97%, avg=3869.67, stdev=242.48, samples=956
   iops        : min=   10, max= 1779, avg=966.00, stdev=60.64, samples=956
  lat (usec)   : 10=0.49%, 20=3.86%, 50=3.19%, 100=0.64%, 250=0.76%
  lat (usec)   : 500=0.82%, 750=0.29%, 1000=0.42%
  lat (msec)   : 2=1.46%, 4=2.83%, 10=4.82%, 20=2.78%, 50=69.99%
  lat (msec)   : 100=5.35%, 250=1.53%, 500=0.60%, 750=0.15%, 1000=0.02%
  lat (msec)   : 2000=0.01%, >=2000=0.01%
  cpu          : usr=0.23%, sys=2.91%, ctx=1426634, majf=0, minf=40
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=48.0%, 16=52.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.9%, 8=1.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=115828,116510,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=3848KiB/s (3940kB/s), 3848KiB/s-3848KiB/s (3940kB/s-3940kB/s), io=452MiB (474MB), run=120417-120417msec
  WRITE: bw=3870KiB/s (3963kB/s), 3870KiB/s-3870KiB/s (3963kB/s-3963kB/s), io=455MiB (477MB), run=120417-120417msec
```

## Throughput test: sequential read

```sh
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-test-job: (groupid=0, jobs=1): err= 0: pid=89617: Fri Dec 12 13:05:02 2025
  read: IOPS=87, BW=87.5MiB/s (91.7MB/s)(10.3GiB/120171msec)
    slat (nsec): min=0, max=187000, avg=2298.13, stdev=3379.01
    clat (msec): min=59, max=320, avg=182.92, stdev=14.38
     lat (msec): min=59, max=320, avg=182.92, stdev=14.38
    clat percentiles (msec):
     |  1.00th=[  148],  5.00th=[  159], 10.00th=[  165], 20.00th=[  171],
     | 30.00th=[  182], 40.00th=[  182], 50.00th=[  184], 60.00th=[  186],
     | 70.00th=[  192], 80.00th=[  194], 90.00th=[  197], 95.00th=[  205],
     | 99.00th=[  215], 99.50th=[  220], 99.90th=[  251], 99.95th=[  264],
     | 99.99th=[  321]
   bw (  KiB/s): min=79712, max=101386, per=100.00%, avg=89606.75, stdev=3057.09, samples=238
   iops        : min=   77, max=   99, avg=87.20, stdev= 3.02, samples=238
  lat (msec)   : 100=0.08%, 250=99.82%, 500=0.10%
  cpu          : usr=0.06%, sys=0.97%, ctx=41927, majf=0, minf=1099
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.8%, 16=52.1%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.4%, 8=0.6%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=10509,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=87.5MiB/s (91.7MB/s), 87.5MiB/s-87.5MiB/s (91.7MB/s-91.7MB/s), io=10.3GiB (11.0GB), run=120171-120171msec
```

## Throughput test: sequential write

```sh
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-test-job: (groupid=0, jobs=1): err= 0: pid=90234: Fri Dec 12 13:07:13 2025
  write: IOPS=69, BW=69.5MiB/s (72.9MB/s)(8360MiB/120215msec); 0 zone resets
    slat (nsec): min=1000, max=4527.0k, avg=30191.03, stdev=69999.26
    clat (msec): min=108, max=388, avg=229.93, stdev=20.02
     lat (msec): min=108, max=388, avg=229.97, stdev=20.04
    clat percentiles (msec):
     |  1.00th=[  167],  5.00th=[  190], 10.00th=[  203], 20.00th=[  215],
     | 30.00th=[  226], 40.00th=[  228], 50.00th=[  234], 60.00th=[  241],
     | 70.00th=[  243], 80.00th=[  245], 90.00th=[  251], 95.00th=[  255],
     | 99.00th=[  262], 99.50th=[  271], 99.90th=[  300], 99.95th=[  317],
     | 99.99th=[  388]
   bw (  KiB/s): min=62859, max=83136, per=100.00%, avg=71260.65, stdev=2932.93, samples=238
   iops        : min=   61, max=   81, avg=69.16, stdev= 2.90, samples=238
  lat (msec)   : 250=90.29%, 500=9.71%
  cpu          : usr=0.16%, sys=1.07%, ctx=31950, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.3%, 16=52.6%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.9%, 8=1.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,8360,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=69.5MiB/s (72.9MB/s), 69.5MiB/s-69.5MiB/s (72.9MB/s-72.9MB/s), io=8360MiB (8766MB), run=120215-120215msec
```
