# MBP14-M1Max-1TB 性能测试

使用脚本：`run-fio.sh`（macOS：`ioengine=posixaio`）

运行命令（当前目录）：

```sh
bash run-fio.sh .
```

测试项：

- 随机写：4K，QD=4（`--rw=randwrite --iodepth=4 --numjobs=1`）
- 随机读：4K，QD=4（`--rw=randread --iodepth=4 --numjobs=1`）
- 顺序读：1M，QD=64
- 顺序写：1M，QD=64

## 随机写（fio-randwrite.log）

```text
randwrite-qd4: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=4
fio-3.41
Starting 1 process
randwrite-qd4: Laying out IO file (1 file / 1024MiB)

randwrite-qd4: (groupid=0, jobs=1): err= 0: pid=50480: Fri Dec 12 23:23:34 2025
  write: IOPS=19.9k, BW=77.7MiB/s (81.4MB/s)(9320MiB/120001msec); 0 zone resets
    slat (nsec): min=0, max=4741.0k, avg=1458.67, stdev=6137.02
    clat (nsec): min=1000, max=12291k, avg=199095.81, stdev=344520.80
     lat (usec): min=6, max=12303, avg=200.55, stdev=344.71
    clat percentiles (usec):
     |  1.00th=[   58],  5.00th=[  104], 10.00th=[  108], 20.00th=[  112],
     | 30.00th=[  116], 40.00th=[  120], 50.00th=[  124], 60.00th=[  128],
     | 70.00th=[  135], 80.00th=[  145], 90.00th=[  174], 95.00th=[  251],
     | 99.00th=[ 1909], 99.50th=[ 1991], 99.90th=[ 2147], 99.95th=[ 2212],
     | 99.99th=[ 6259]
   bw (  KiB/s): min=59459, max=87888, per=100.00%, avg=79608.21, stdev=3654.49, samples=238
   iops        : min=14864, max=21972, avg=19901.72, stdev=913.62, samples=238
  lat (usec)   : 2=0.01%, 4=0.01%, 10=0.03%, 20=0.20%, 50=0.54%
  lat (usec)   : 100=1.60%, 250=92.62%, 500=0.66%, 750=0.14%, 1000=0.01%
  lat (msec)   : 2=3.70%, 4=0.48%, 10=0.02%, 20=0.01%
  cpu          : usr=4.22%, sys=60.76%, ctx=7479384, majf=0, minf=8
  IO depths    : 1=0.1%, 2=5.2%, 4=94.7%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,2385806,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=4

Run status group 0 (all jobs):
  WRITE: bw=77.7MiB/s (81.4MB/s), 77.7MiB/s-77.7MiB/s (81.4MB/s-81.4MB/s), io=9320MiB (9772MB), run=120001-120001msec
```

## 随机读（fio-randread.log）

```text
randread-qd4: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=4
fio-3.41
Starting 1 process

randread-qd4: (groupid=0, jobs=1): err= 0: pid=50617: Fri Dec 12 23:25:34 2025
  read: IOPS=39.4k, BW=154MiB/s (162MB/s)(18.0GiB/120001msec)
    slat (nsec): min=0, max=888000, avg=1159.62, stdev=1297.32
    clat (usec): min=3, max=17420, avg=99.49, stdev=46.82
     lat (usec): min=4, max=17422, avg=100.65, stdev=46.90
    clat percentiles (usec):
     |  1.00th=[   75],  5.00th=[   81], 10.00th=[   83], 20.00th=[   86],
     | 30.00th=[   89], 40.00th=[   92], 50.00th=[   96], 60.00th=[   99],
     | 70.00th=[  103], 80.00th=[  109], 90.00th=[  120], 95.00th=[  130],
     | 99.00th=[  165], 99.50th=[  200], 99.90th=[  355], 99.95th=[  469],
     | 99.99th=[ 1778]
   bw (  KiB/s): min=127696, max=169359, per=100.00%, avg=157892.00, stdev=10075.13, samples=238
   iops        : min=31924, max=42339, avg=39472.75, stdev=2518.77, samples=238
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.53%, 100=61.08%
  lat (usec)   : 250=38.10%, 500=0.23%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.03%, 4=0.01%, 10=0.01%, 20=0.01%
  cpu          : usr=6.19%, sys=55.87%, ctx=13571695, majf=0, minf=12
  IO depths    : 1=0.3%, 2=28.3%, 4=71.4%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=4731675,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=4

Run status group 0 (all jobs):
   READ: bw=154MiB/s (162MB/s), 154MiB/s-154MiB/s (162MB/s-162MB/s), io=18.0GiB (19.4GB), run=120001-120001msec
```

## 顺序读（fio-seq-read.log）

```text
throughput-read: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-read: (groupid=0, jobs=1): err= 0: pid=50814: Fri Dec 12 23:27:34 2025
  read: IOPS=4918, BW=4918MiB/s (5157MB/s)(576GiB/120003msec)
    slat (nsec): min=0, max=3721.0k, avg=1137.07, stdev=5276.00
    clat (usec): min=564, max=29007, avg=3250.40, stdev=882.46
     lat (usec): min=566, max=29007, avg=3251.54, stdev=882.42
    clat percentiles (usec):
     |  1.00th=[ 2057],  5.00th=[ 2376], 10.00th=[ 2507], 20.00th=[ 2704],
     | 30.00th=[ 2835], 40.00th=[ 2966], 50.00th=[ 3130], 60.00th=[ 3261],
     | 70.00th=[ 3458], 80.00th=[ 3654], 90.00th=[ 3916], 95.00th=[ 4178],
     | 99.00th=[ 7767], 99.50th=[ 8848], 99.90th=[10028], 99.95th=[10814],
     | 99.99th=[13698]
   bw (  MiB/s): min= 1813, max= 5743, per=100.00%, avg=4920.66, stdev=798.65, samples=236
   iops        : min= 1813, max= 5743, avg=4920.19, stdev=798.69, samples=236
  lat (usec)   : 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.72%, 4=91.65%, 10=7.52%, 20=0.11%, 50=0.01%
  cpu          : usr=1.66%, sys=25.16%, ctx=2050404, majf=0, minf=1098
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.8%, 16=52.2%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.2%, 8=0.8%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=590206,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=4918MiB/s (5157MB/s), 4918MiB/s-4918MiB/s (5157MB/s-5157MB/s), io=576GiB (619GB), run=120003-120003msec
```

## 顺序写（fio-seq-write.log）

```text
throughput-write: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.41
Starting 1 process

throughput-write: (groupid=0, jobs=1): err= 0: pid=50963: Fri Dec 12 23:29:35 2025
  write: IOPS=5002, BW=5002MiB/s (5245MB/s)(586GiB/120003msec); 0 zone resets
    slat (nsec): min=0, max=7242.0k, avg=12783.07, stdev=30696.82
    clat (usec): min=29, max=410570, avg=3175.64, stdev=4212.12
     lat (usec): min=356, max=410584, avg=3188.42, stdev=4212.76
    clat percentiles (usec):
     |  1.00th=[  1352],  5.00th=[  1532], 10.00th=[  1663], 20.00th=[  1844],
     | 30.00th=[  2008], 40.00th=[  2180], 50.00th=[  2376], 60.00th=[  2606],
     | 70.00th=[  2933], 80.00th=[  3490], 90.00th=[  5014], 95.00th=[  9241],
     | 99.00th=[ 12256], 99.50th=[ 14484], 99.90th=[ 22414], 99.95th=[ 32113],
     | 99.99th=[183501]
   bw (  MiB/s): min=  229, max= 5713, per=100.00%, avg=5005.98, stdev=1254.22, samples=236
   iops        : min=  229, max= 5713, avg=5005.56, stdev=1254.23, samples=236
  lat (usec)   : 50=0.01%, 500=0.01%, 750=0.01%, 1000=0.02%
  lat (msec)   : 2=29.12%, 4=55.96%, 10=11.79%, 20=2.96%, 50=0.11%
  lat (msec)   : 100=0.01%, 250=0.03%, 500=0.01%
  cpu          : usr=7.06%, sys=63.27%, ctx=6276799, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=43.6%, 16=56.4%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.1%, 8=0.9%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,600286,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=5002MiB/s (5245MB/s), 5002MiB/s-5002MiB/s (5245MB/s-5245MB/s), io=586GiB (629GB), run=120003-120003msec
```

