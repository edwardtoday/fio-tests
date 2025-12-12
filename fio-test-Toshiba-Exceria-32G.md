# 性能测试

`posixaio` 是 macOS 的异步 IO 引擎，如果在 Linux 下运行测试，请改为 `libaio`。

本次测试设备：`/Volumes/DR-05X`（Toshiba Exceria 32G）。

## IOPS test: random read/write

```sh
cd /Volumes/DR-05X
fio --filename=./fio-test.bin --size=1G --direct=1 --rw=randrw --bs=4k --ioengine=posixaio --iodepth=256 --runtime=120 --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1
```

```
iops-test-job: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=256
...
fio-3.41
Starting 4 processes
iops-test-job: Laying out IO file (1 file / 1024MiB)

iops-test-job: (groupid=0, jobs=4): err= 0: pid=23296: Fri Dec 12 19:53:01 2025
  read: IOPS=1, BW=5728B/s (5728B/s)(800KiB/143012msec)
    slat (nsec): min=0, max=32000, avg=4456.31, stdev=4628.18
    clat (usec): min=19, max=48225k, avg=13898614.94, stdev=9591892.28
     lat (usec): min=22, max=48225k, avg=13898619.39, stdev=9591890.68
    clat percentiles (usec):
     |  1.00th=[     204],  5.00th=[   23462], 10.00th=[   30802],
     | 20.00th=[  834667], 30.00th=[ 9865004], 40.00th=[13623100],
     | 50.00th=[15636366], 60.00th=[16978543], 70.00th=[17112761],
     | 80.00th=[17112761], 90.00th=[17112761], 95.00th=[17112761],
     | 99.00th=[17112761], 99.50th=[17112761], 99.90th=[17112761],
     | 99.95th=[17112761], 99.99th=[17112761]
   bw (  KiB/s): min=   28, max=  316, per=100.00%, avg=62.61, stdev=16.22, samples=100
   iops        : min=    4, max=   76, avg=12.83, stdev= 4.05, samples=100
  write: IOPS=1, BW=6530B/s (6530B/s)(912KiB/143012msec); 0 zone resets
    slat (nsec): min=1000, max=28000, avg=4257.38, stdev=4230.29
    clat (usec): min=32, max=130860k, avg=23446828.69, stdev=22220934.24
     lat (usec): min=34, max=130860k, avg=23446832.95, stdev=22220932.84
    clat percentiles (usec):
     |  1.00th=[     145],  5.00th=[    8225], 10.00th=[   23462],
     | 20.00th=[ 3070231], 30.00th=[14025753], 40.00th=[17112761],
     | 50.00th=[17112761], 60.00th=[17112761], 70.00th=[17112761],
     | 80.00th=[17112761], 90.00th=[17112761], 95.00th=[17112761],
     | 99.00th=[17112761], 99.50th=[17112761], 99.90th=[17112761],
     | 99.95th=[17112761], 99.99th=[17112761]
   bw (  KiB/s): min=   28, max=  355, per=100.00%, avg=77.09, stdev=19.15, samples=94
   iops        : min=    4, max=   86, avg=16.47, stdev= 4.81, samples=94
  lat (usec)   : 20=0.23%, 50=0.23%, 250=1.35%, 500=0.45%
  lat (msec)   : 4=1.58%, 10=1.35%, 20=1.35%, 50=9.93%, 100=2.93%
  lat (msec)   : 750=0.23%, 1000=0.23%, 2000=0.45%, >=2000=79.68%
  cpu          : usr=0.00%, sys=0.01%, ctx=2738, majf=0, minf=53
  IO depths    : 1=0.9%, 2=1.8%, 4=3.6%, 8=47.2%, 16=46.5%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=97.4%, 8=2.0%, 16=0.6%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=206,237,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=5728B/s (5728B/s), 5728B/s-5728B/s (5728B/s-5728B/s), io=800KiB (819kB), run=143012-143012msec
  WRITE: bw=6530B/s (6530B/s), 6530B/s-6530B/s (6530B/s-6530B/s), io=912KiB (934kB), run=143012-143012msec
```

## Throughput test: sequential read

```sh
cd /Volumes/DR-05X
fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-test-job: (groupid=0, jobs=1): err= 0: pid=23525: Fri Dec 12 19:55:22 2025
  read: IOPS=79, BW=79.4MiB/s (83.2MB/s)(9539MiB/120177msec)
    slat (nsec): min=0, max=53000, avg=1690.70, stdev=1942.06
    clat (msec): min=25, max=347, avg=195.54, stdev=17.14
     lat (msec): min=25, max=347, avg=195.54, stdev=17.14
    clat percentiles (msec):
     |  1.00th=[  157],  5.00th=[  169], 10.00th=[  171], 20.00th=[  182],
     | 30.00th=[  192], 40.00th=[  194], 50.00th=[  194], 60.00th=[  205],
     | 70.00th=[  205], 80.00th=[  207], 90.00th=[  209], 95.00th=[  220],
     | 99.00th=[  243], 99.50th=[  247], 99.90th=[  275], 99.95th=[  288],
     | 99.99th=[  347]
   bw (  KiB/s): min=68942, max=94208, per=100.00%, avg=83807.07, stdev=3730.06, samples=238
   iops        : min=   67, max=   92, avg=81.55, stdev= 3.68, samples=238
  lat (msec)   : 50=0.03%, 100=0.03%, 250=99.72%, 500=0.22%
  cpu          : usr=0.05%, sys=0.77%, ctx=36662, majf=0, minf=1144
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.4%, 16=52.5%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.5%, 8=0.5%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=9832,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=79.4MiB/s (83.2MB/s), 79.4MiB/s-79.4MiB/s (83.2MB/s-83.2MB/s), io=9539MiB (10.0GB), run=120177-120177msec
```

## Throughput test: sequential write

```sh
cd /Volumes/DR-05X
fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-test-job: (groupid=0, jobs=1): err= 0: pid=23722: Fri Dec 12 19:57:33 2025
  write: IOPS=13, BW=13.1MiB/s (13.7MB/s)(1597MiB/121947msec); 0 zone resets
    slat (nsec): min=1000, max=226000, avg=22722.07, stdev=32557.78
    clat (msec): min=348, max=3372, avg=1351.61, stdev=658.51
     lat (msec): min=348, max=3373, avg=1351.64, stdev=658.51
    clat percentiles (msec):
     |  1.00th=[  468],  5.00th=[  558], 10.00th=[  584], 20.00th=[  625],
     | 30.00th=[  911], 40.00th=[ 1020], 50.00th=[ 1301], 60.00th=[ 1435],
     | 70.00th=[ 1720], 80.00th=[ 1955], 90.00th=[ 2232], 95.00th=[ 2601],
     | 99.00th=[ 3037], 99.50th=[ 3171], 99.90th=[ 3373], 99.95th=[ 3373],
     | 99.99th=[ 3373]
   bw (  KiB/s): min= 2027, max=34816, per=100.00%, avg=15421.72, stdev=8652.05, samples=189
   iops        : min=    1, max=   34, avg=14.34, stdev= 8.51, samples=189
  lat (msec)   : 500=1.96%, 750=22.70%, 1000=13.83%, 2000=43.37%, >=2000=18.16%
  cpu          : usr=0.02%, sys=0.14%, ctx=6347, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.3%, 8=47.4%, 16=52.1%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.9%, 8=1.1%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,1432,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=13.1MiB/s (13.7MB/s), 13.1MiB/s-13.1MiB/s (13.7MB/s-13.7MB/s), io=1597MiB (1675MB), run=121947-121947msec
```
