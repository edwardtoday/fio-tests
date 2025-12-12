# 性能测试

`posixaio`是macOS的异步读写库，如果在Linux下运行测试，请改为`libaio`。

## IOPS test: random read/write

```sh
sudo fio --filename=./fio-test.bin --size=1GB --direct=1 --rw=randrw --bs=4k --ioengine=posixaio --iodepth=256 --runtime=120 --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1
```

```sh
iops-test-job: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=256
...
fio-3.37
Starting 4 processes
iops-test-job: Laying out IO file (1 file / 1024MiB)
Jobs: 4 (f=4): [m(4)][2.5%][r=5280KiB/s,w=5478KiB/s][r=1320,w=1369 IOPS][eta 01m:57s]
Jobs: 4 (f=4): [m(4)][3.3%][r=5376KiB/s,w=5568KiB/s][r=1344,w=1392 IOPS][Jobs: 4 (f=4): [m(4)][4.2%][r=5212KiB/s,w=5436KiB/s][r=1303,w=1359 IOPS][eta 01m:55s]
Jobs: 4 (f=4): [m(4)][5.0%][r=5202KiB/s,w=5482KiB/s][r=1300,w=1370 IOPS][Jobs: 4 (f=4): [m(4)][5.8%][r=4075KiB/s,w=4218KiB/s][r=1018,w=1054 IOPS][eta 01m:53s]
Jobs: 4 (f=4): [m(4)][6.7%][eta 01m:52s]
Jobs: 4 (f=4): [m(4)][7.5%][r=1266KiB/s,w=1209KiB/s][r=316,w=302 IOPS][etJobs: 4 (f=4): [m(4)][8.3%][r=5517KiB/s,w=5793KiB/s][r=1379,w=1448 IOPS][eta 01m:50s]
Jobs: 4 (f=4): [m(4)][9.2%][r=824KiB/s,w=843KiB/s][r=206,w=210 IOPS][eta 01m:49s]
Jobs: 4 (f=4): [m(4)][10.0%][r=5743KiB/s,w=5835KiB/s][r=1435,w=1458 IOPS]Jobs: 4 (f=4): [m(4)][10.8%][r=771KiB/s,w=795KiB/s][r=192,w=198 IOPS][eta 01m:47s]
Jobs: 4 (f=4): [m(4)][12.5%][r=1222KiB/s,w=1338KiB/s][r=305,w=334 IOPS][eta 01m:45s]
Jobs: 4 (f=4): [m(4)][13.3%][eta 01m:44s]
Jobs: 4 (f=4): [m(4)][15.0%][eta 01m:42s]
Jobs: 4 (f=4): [m(4)][16.7%][r=3054KiB/s,w=3170KiB/s][r=763,w=792 IOPS][eta 01m:40s]
Jobs: 4 (f=4): [m(4)][18.3%][r=1093KiB/s,w=1193KiB/s][r=273,w=298 IOPS][eta 01m:38s]
Jobs: 4 (f=4): [m(4)][19.2%][eta 01m:37s]
Jobs: 4 (f=4): [m(4)][20.8%][r=5783KiB/s,w=5922KiB/s][r=1445,w=1480 IOPS][eta 01m:35s]
Jobs: 4 (f=4): [m(4)][22.5%][r=3537KiB/s,w=3649KiB/s][r=884,w=912 IOPS][eta 01m:33s]
Jobs: 4 (f=4): [m(4)][24.2%][r=375KiB/s,w=407KiB/s][r=93,w=101 IOPS][eta 01m:31s]
Jobs: 4 (f=4): [m(4)][25.8%][r=4686KiB/s,w=4534KiB/s][r=1171,w=1133 IOPS][eta 01m:29s]
Jobs: 4 (f=4): [m(4)][27.5%][r=1966KiB/s,w=1891KiB/s][r=491,w=472 IOPS][eta 01m:27s]
Jobs: 4 (f=4): [m(4)][28.3%][eta 01m:26s]
Jobs: 4 (f=4): [m(4)][29.2%][r=1248KiB/s,w=1371KiB/s][r=312,w=342 IOPS][eta 01m:25s]
Jobs: 4 (f=4): [m(4)][30.8%][r=1867KiB/s,w=1811KiB/s][r=466,w=452 IOPS][eta 01m:23s]
Jobs: 4 (f=4): [m(4)][31.7%][eta 01m:22s]
Jobs: 4 (f=4): [m(4)][33.3%][eta 01m:20s]
Jobs: 4 (f=4): [m(4)][34.2%][r=760KiB/s,w=704KiB/s][r=190,w=176 IOPS][eta 01m:19s]
Jobs: 4 (f=4): [m(4)][35.8%][r=5726KiB/s,w=5926KiB/s][r=1431,w=1481 IOPS][eta 01m:17s]
Jobs: 4 (f=4): [m(4)][37.5%][r=3824KiB/s,w=3892KiB/s][r=956,w=973 IOPS][eta 01m:15s]
Jobs: 4 (f=4): [m(4)][39.2%][r=2011KiB/s,w=1908KiB/s][r=502,w=477 IOPS][eta 01m:13s]
Jobs: 4 (f=4): [m(4)][40.8%][r=461KiB/s,w=433KiB/s][r=115,w=108 IOPS][eta 01m:11s]
Jobs: 4 (f=4): [m(4)][42.5%][r=5182KiB/s,w=5278KiB/s][r=1295,w=1319 IOPS][eta 01m:09s]
Jobs: 4 (f=4): [m(4)][44.2%][r=6000KiB/s,w=5988KiB/s][r=1500,w=1497 IOPS][eta 01m:07s]
Jobs: 4 (f=4): [m(4)][45.0%][r=6160KiB/s,w=5920KiB/s][r=1540,w=1480 IOPS][eta 01m:06s]
Jobs: 4 (f=4): [m(4)][46.7%][r=4231KiB/s,w=4582KiB/s][r=1057,w=1145 IOPS][eta 01m:04s]
Jobs: 4 (f=4): [m(4)][48.3%][r=1340KiB/s,w=1256KiB/s][r=335,w=314 IOPS][eta 01m:02s]
Jobs: 4 (f=4): [m(4)][50.0%][r=5869KiB/s,w=5901KiB/s][r=1467,w=1475 IOPS][eta 01m:00s]
Jobs: 4 (f=4): [m(4)][51.7%][r=5493KiB/s,w=5673KiB/s][r=1373,w=1418 IOPS][eta 00m:58s]
Jobs: 4 (f=4): [m(4)][52.5%][r=1958KiB/s,w=2013KiB/s][r=489,w=503 IOPS][eta 00m:57s]
Jobs: 4 (f=4): [m(4)][53.3%][eta 00m:56s]
Jobs: 4 (f=4): [m(4)][55.0%][r=6132KiB/s,w=6064KiB/s][r=1533,w=1516 IOPS][eta 00m:54s]
Jobs: 4 (f=4): [m(4)][56.7%][r=3690KiB/s,w=3845KiB/s][r=922,w=961 IOPS][eta 00m:52s]
Jobs: 4 (f=4): [m(4)][57.5%][eta 00m:51s]
Jobs: 4 (f=4): [m(4)][58.3%][r=2119KiB/s,w=1968KiB/s][r=529,w=492 IOPS][eta 00m:50s]
Jobs: 4 (f=4): [m(4)][59.2%][eta 00m:49s]
Jobs: 4 (f=4): [m(4)][60.0%][r=271KiB/s,w=231KiB/s][r=67,w=57 IOPS][eta 00m:48s]
Jobs: 4 (f=4): [m(4)][61.7%][eta 00m:46s]
Jobs: 4 (f=4): [m(4)][62.5%][r=5513KiB/s,w=5557KiB/s][r=1378,w=1389 IOPS][eta 00m:45s]
Jobs: 4 (f=4): [m(4)][64.2%][r=5986KiB/s,w=6053KiB/s][r=1496,w=1513 IOPS][eta 00m:43s]
Jobs: 4 (f=4): [m(4)][65.8%][eta 00m:41s]
Jobs: 4 (f=4): [m(4)][67.5%][r=2864KiB/s,w=2848KiB/s][r=716,w=712 IOPS][eta 00m:39s]
Jobs: 4 (f=4): [m(4)][69.2%][r=2929KiB/s,w=2949KiB/s][r=732,w=737 IOPS][eta 00m:37s]
Jobs: 4 (f=4): [m(4)][70.8%][r=2849KiB/s,w=2857KiB/s][r=712,w=714 IOPS][eta 00m:35s]
Jobs: 4 (f=4): [m(4)][71.7%][eta 00m:34s]
Jobs: 4 (f=4): [m(4)][73.3%][r=4240KiB/s,w=3935KiB/s][r=1060,w=983 IOPS][eta 00m:32s]
Jobs: 4 (f=4): [m(4)][74.2%][eta 00m:31s]
Jobs: 4 (f=4): [m(4)][75.8%][r=5886KiB/s,w=5922KiB/s][r=1471,w=1480 IOPS][eta 00m:29s]
Jobs: 4 (f=4): [m(4)][76.7%][r=5974KiB/s,w=5882KiB/s][r=1493,w=1470 IOPS][eta 00m:28s]
Jobs: 4 (f=4): [m(4)][78.3%][eta 00m:26s]
Jobs: 4 (f=4): [m(4)][79.2%][r=99KiB/s,w=131KiB/s][r=24,w=32 IOPS][eta 00m:25s]
Jobs: 4 (f=4): [m(4)][80.8%][r=5074KiB/s,w=4989KiB/s][r=1268,w=1247 IOPS][eta 00m:23s]
Jobs: 4 (f=4): [m(4)][81.7%][r=5577KiB/s,w=5916KiB/s][r=1394,w=1479 IOPS][eta 00m:22s]
Jobs: 4 (f=4): [m(4)][83.3%][r=624KiB/s,w=516KiB/s][r=156,w=129 IOPS][eta 00m:20s]
Jobs: 4 (f=4): [m(4)][85.0%][r=380KiB/s,w=484KiB/s][r=95,w=121 IOPS][eta 00m:18s]
Jobs: 4 (f=4): [m(4)][85.8%][eta 00m:17s]
Jobs: 4 (f=4): [m(4)][87.5%][eta 00m:15s]
Jobs: 4 (f=4): [m(4)][89.2%][eta 00m:13s]
Jobs: 4 (f=4): [m(4)][90.8%][r=6179KiB/s,w=6231KiB/s][r=1544,w=1557 IOPS][eta 00m:11s]
Jobs: 4 (f=4): [m(4)][92.5%][r=6628KiB/s,w=6368KiB/s][r=1657,w=1592 IOPS][eta 00m:09s]
Jobs: 4 (f=4): [m(4)][94.2%][r=1183KiB/s,w=1163KiB/s][r=295,w=290 IOPS][eta 00m:07s]
Jobs: 4 (f=4): [m(4)][95.8%][r=5198KiB/s,w=5034KiB/s][r=1299,w=1258 IOPS][eta 00m:05s]
Jobs: 4 (f=4): [m(4)][97.5%][r=5534KiB/s,w=5918KiB/s][r=1383,w=1479 IOPS][eta 00m:03s]
Jobs: 4 (f=4): [m(4)][99.2%][eta 00m:01s]
Jobs: 4 (f=4): [m(4)][100.0%][r=6501KiB/s,w=6045KiB/s][r=1625,w=1511 IOPS][eta 00m:00s]
iops-test-job: (groupid=0, jobs=4): err= 0: pid=58468: Fri May 31 13:10:56 2024
  read: IOPS=684, BW=2737KiB/s (2802kB/s)(321MiB/120023msec)
    slat (nsec): min=0, max=29846k, avg=3345.14, stdev=152390.43
    clat (usec): min=58, max=4036.8k, avg=48350.29, stdev=219971.36
     lat (usec): min=424, max=4036.8k, avg=48353.63, stdev=219971.24
    clat percentiles (msec):
     |  1.00th=[   16],  5.00th=[   18], 10.00th=[   18], 20.00th=[   20],
     | 30.00th=[   21], 40.00th=[   21], 50.00th=[   22], 60.00th=[   23],
     | 70.00th=[   24], 80.00th=[   25], 90.00th=[   27], 95.00th=[   30],
     | 99.00th=[ 2005], 99.50th=[ 2022], 99.90th=[ 2039], 99.95th=[ 2039],
     | 99.99th=[ 2039]
   bw (  KiB/s): min=  172, max= 7250, per=100.00%, avg=4317.25, stdev=538.33, samples=603
   iops        : min=   40, max= 1812, avg=1077.89, stdev=134.64, samples=603
  write: IOPS=686, BW=2746KiB/s (2812kB/s)(322MiB/120023msec); 0 zone resets
    slat (nsec): min=0, max=7102.0k, avg=3105.57, stdev=44743.72
    clat (usec): min=771, max=4029.3k, avg=44927.32, stdev=204564.10
     lat (usec): min=813, max=4029.3k, avg=44930.42, stdev=204564.20
    clat percentiles (msec):
     |  1.00th=[   16],  5.00th=[   17], 10.00th=[   18], 20.00th=[   20],
     | 30.00th=[   21], 40.00th=[   21], 50.00th=[   22], 60.00th=[   23],
     | 70.00th=[   23], 80.00th=[   24], 90.00th=[   27], 95.00th=[   29],
     | 99.00th=[ 1636], 99.50th=[ 2022], 99.90th=[ 2022], 99.95th=[ 2039],
     | 99.99th=[ 2039]
   bw (  KiB/s): min=  108, max= 6837, per=100.00%, avg=4325.88, stdev=537.95, samples=604
   iops        : min=   24, max= 1708, avg=1080.05, stdev=134.54, samples=604
  lat (usec)   : 100=0.01%, 500=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.09%, 20=29.89%, 50=68.31%
  lat (msec)   : 100=0.11%, 250=0.12%, 500=0.07%, 750=0.12%, 1000=0.04%
  lat (msec)   : 2000=0.31%, >=2000=0.93%
  cpu          : usr=0.33%, sys=0.38%, ctx=147280, majf=0, minf=41
  IO depths    : 1=0.1%, 2=0.1%, 4=0.3%, 8=52.3%, 16=47.3%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.2%, 8=1.7%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=82118,82400,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=2737KiB/s (2802kB/s), 2737KiB/s-2737KiB/s (2802kB/s-2802kB/s), io=321MiB (336MB), run=120023-120023msec
  WRITE: bw=2746KiB/s (2812kB/s), 2746KiB/s-2746KiB/s (2812kB/s-2812kB/s), io=322MiB (338MB), run=120023-120023msec
```

## Throughput test: sequential read

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [R(1)][2.5%][r=106MiB/s][r=105 IOPS][eta 01m:58s]
Jobs: 1 (f=1): [R(1)][4.1%][r=106MiB/s][r=106 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [R(1)][5.8%][r=113MiB/s][r=113 IOPS][eta 01m:54s]
Jobs: 1 (f=1): [R(1)][7.4%][r=115MiB/s][r=114 IOPS][eta 01m:52s]
Jobs: 1 (f=1): [R(1)][8.3%][r=110MiB/s][r=109 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [R(1)][9.2%][r=108MiB/s][r=108 IOPS][eta 01m:49s]
Jobs: 1 (f=1): [R(1)][10.7%][r=115MiB/s][r=114 IOPS][eta 01m:48s]
Jobs: 1 (f=1): [R(1)][11.7%][r=111MiB/s][r=111 IOPS][eta 01m:46s]
Jobs: 1 (f=1): [R(1)][13.2%][r=111MiB/s][r=110 IOPS][eta 01m:45s]
Jobs: 1 (f=1): [R(1)][14.9%][r=112MiB/s][r=112 IOPS][eta 01m:43s]
Jobs: 1 (f=1): [R(1)][16.5%][r=112MiB/s][r=111 IOPS][eta 01m:41s]
Jobs: 1 (f=1): [R(1)][17.5%][r=112MiB/s][r=112 IOPS][eta 01m:39s]
Jobs: 1 (f=1): [R(1)][20.0%][r=113MiB/s][r=112 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [R(1)][20.8%][r=113MiB/s][r=113 IOPS][eta 01m:35s]
Jobs: 1 (f=1): [R(1)][22.3%][r=108MiB/s][r=107 IOPS][eta 01m:34s]
Jobs: 1 (f=1): [R(1)][24.0%][r=112MiB/s][r=111 IOPS][eta 01m:32s]
Jobs: 1 (f=1): [R(1)][25.6%][r=110MiB/s][r=110 IOPS][eta 01m:30s]
Jobs: 1 (f=1): [R(1)][27.3%][r=113MiB/s][r=113 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [R(1)][28.9%][r=110MiB/s][r=110 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [R(1)][30.6%][r=112MiB/s][r=111 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [R(1)][32.2%][r=111MiB/s][r=110 IOPS][eta 01m:22s]
Jobs: 1 (f=1): [R(1)][33.9%][r=111MiB/s][r=110 IOPS][eta 01m:20s]
Jobs: 1 (f=1): [R(1)][35.5%][r=113MiB/s][r=113 IOPS][eta 01m:18s]
Jobs: 1 (f=1): [R(1)][37.2%][r=113MiB/s][r=112 IOPS][eta 01m:16s]
Jobs: 1 (f=1): [R(1)][39.2%][r=112MiB/s][r=111 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [R(1)][40.0%][r=110MiB/s][r=110 IOPS][eta 01m:12s]
Jobs: 1 (f=1): [R(1)][41.7%][r=110MiB/s][r=110 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [R(1)][42.5%][r=112MiB/s][r=112 IOPS][eta 01m:09s]
Jobs: 1 (f=1): [R(1)][43.3%][r=112MiB/s][r=111 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [R(1)][44.2%][r=108MiB/s][r=108 IOPS][eta 01m:07s]
Jobs: 1 (f=1): [R(1)][45.0%][r=107MiB/s][r=107 IOPS][eta 01m:06s]
Jobs: 1 (f=1): [R(1)][45.8%][r=112MiB/s][r=111 IOPS][eta 01m:05s]
Jobs: 1 (f=1): [R(1)][47.1%][r=112MiB/s][r=111 IOPS][eta 01m:04s]
Jobs: 1 (f=1): [R(1)][47.9%][r=107MiB/s][r=107 IOPS][eta 01m:03s]
Jobs: 1 (f=1): [R(1)][48.8%][r=114MiB/s][r=114 IOPS][eta 01m:02s]
Jobs: 1 (f=1): [R(1)][49.6%][r=111MiB/s][r=110 IOPS][eta 01m:01s]
Jobs: 1 (f=1): [R(1)][50.4%][r=113MiB/s][r=112 IOPS][eta 01m:00s]
Jobs: 1 (f=1): [R(1)][52.5%][r=112MiB/s][r=112 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [R(1)][53.7%][r=111MiB/s][r=111 IOPS][eta 00m:56s]
Jobs: 1 (f=1): [R(1)][54.5%][r=113MiB/s][r=112 IOPS][eta 00m:55s]
Jobs: 1 (f=1): [R(1)][56.2%][r=112MiB/s][r=111 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [R(1)][57.0%][r=113MiB/s][r=112 IOPS][eta 00m:52s]
Jobs: 1 (f=1): [R(1)][57.9%][r=112MiB/s][r=111 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [R(1)][59.2%][r=112MiB/s][r=111 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [R(1)][60.3%][r=114MiB/s][r=113 IOPS][eta 00m:48s]
Jobs: 1 (f=1): [R(1)][62.0%][r=114MiB/s][r=113 IOPS][eta 00m:46s]
Jobs: 1 (f=1): [R(1)][63.6%][r=111MiB/s][r=110 IOPS][eta 00m:44s]
Jobs: 1 (f=1): [R(1)][65.3%][r=113MiB/s][r=112 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [R(1)][66.9%][r=108MiB/s][r=107 IOPS][eta 00m:40s]
Jobs: 1 (f=1): [R(1)][68.6%][r=111MiB/s][r=110 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][70.2%][r=113MiB/s][r=113 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [R(1)][71.9%][r=116MiB/s][r=116 IOPS][eta 00m:34s]
Jobs: 1 (f=1): [R(1)][73.6%][r=113MiB/s][r=112 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [R(1)][75.2%][r=109MiB/s][r=109 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [R(1)][76.0%][r=115MiB/s][r=114 IOPS][eta 00m:29s]
Jobs: 1 (f=1): [R(1)][77.7%][r=113MiB/s][r=113 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [R(1)][79.3%][r=108MiB/s][r=108 IOPS][eta 00m:25s]
Jobs: 1 (f=1): [R(1)][81.0%][r=112MiB/s][r=111 IOPS][eta 00m:23s]
Jobs: 1 (f=1): [R(1)][82.6%][r=112MiB/s][r=111 IOPS][eta 00m:21s]
Jobs: 1 (f=1): [R(1)][84.3%][r=114MiB/s][r=114 IOPS][eta 00m:19s]
Jobs: 1 (f=1): [R(1)][86.0%][r=111MiB/s][r=111 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [R(1)][87.6%][r=106MiB/s][r=106 IOPS][eta 00m:15s]
Jobs: 1 (f=1): [R(1)][89.3%][r=114MiB/s][r=113 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [R(1)][90.9%][r=112MiB/s][r=111 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [R(1)][91.7%][r=112MiB/s][r=111 IOPS][eta 00m:10s]
Jobs: 1 (f=1): [R(1)][93.4%][r=112MiB/s][r=112 IOPS][eta 00m:08s]
Jobs: 1 (f=1): [R(1)][94.2%][r=109MiB/s][r=108 IOPS][eta 00m:07s]
Jobs: 1 (f=1): [R(1)][95.0%][r=115MiB/s][r=114 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [R(1)][96.7%][r=112MiB/s][r=112 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [R(1)][98.3%][r=112MiB/s][r=111 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [R(1)][100.0%][r=111MiB/s][r=111 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=58596: Fri May 31 13:12:56 2024
  read: IOPS=111, BW=111MiB/s (117MB/s)(13.1GiB/120120msec)
    slat (nsec): min=0, max=57475k, avg=8012.78, stdev=497073.67
    clat (msec): min=71, max=240, avg=143.53, stdev=12.96
     lat (msec): min=71, max=240, avg=143.53, stdev=12.95
    clat percentiles (msec):
     |  1.00th=[  100],  5.00th=[  116], 10.00th=[  125], 20.00th=[  138],
     | 30.00th=[  144], 40.00th=[  144], 50.00th=[  146], 60.00th=[  153],
     | 70.00th=[  153], 80.00th=[  153], 90.00th=[  153], 95.00th=[  155],
     | 99.00th=[  163], 99.50th=[  167], 99.90th=[  194], 99.95th=[  207],
     | 99.99th=[  241]
   bw (  KiB/s): min=103413, max=131801, per=100.00%, avg=114204.61, stdev=4083.65, samples=238
   iops        : min=  100, max=  128, avg=110.99, stdev= 4.01, samples=238
  lat (msec)   : 100=1.34%, 250=98.66%
  cpu          : usr=0.14%, sys=0.16%, ctx=14461, majf=0, minf=11
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.2%, 16=52.7%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.5%, 8=1.5%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=13384,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=111MiB/s (117MB/s), 111MiB/s-111MiB/s (117MB/s-117MB/s), io=13.1GiB (14.0GB), run=120120-120120msec
```

## Throughput test: sequential write

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [W(1)][3.3%][w=105MiB/s][w=104 IOPS][eta 01m:57s]
Jobs: 1 (f=1): [W(1)][4.1%][w=103MiB/s][w=103 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [W(1)][5.0%][w=105MiB/s][w=104 IOPS][eta 01m:55s]
Jobs: 1 (f=1): [W(1)][6.6%][w=105MiB/s][w=105 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [W(1)][7.4%][w=106MiB/s][w=105 IOPS][eta 01m:52s]
Jobs: 1 (f=1): [W(1)][8.3%][w=107MiB/s][w=106 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [W(1)][9.9%][w=106MiB/s][w=106 IOPS][eta 01m:49s]
Jobs: 1 (f=1): [W(1)][11.6%][w=104MiB/s][w=104 IOPS][eta 01m:47s]
Jobs: 1 (f=1): [W(1)][13.2%][w=105MiB/s][w=104 IOPS][eta 01m:45s]
Jobs: 1 (f=1): [W(1)][14.9%][w=107MiB/s][w=107 IOPS][eta 01m:43s]
Jobs: 1 (f=1): [W(1)][15.7%][w=108MiB/s][w=107 IOPS][eta 01m:42s]
Jobs: 1 (f=1): [W(1)][17.4%][w=107MiB/s][w=107 IOPS][eta 01m:40s]
Jobs: 1 (f=1): [W(1)][19.0%][w=105MiB/s][w=105 IOPS][eta 01m:38s]
Jobs: 1 (f=1): [W(1)][20.7%][w=105MiB/s][w=105 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [W(1)][22.3%][w=104MiB/s][w=104 IOPS][eta 01m:34s]
Jobs: 1 (f=1): [W(1)][24.0%][w=105MiB/s][w=105 IOPS][eta 01m:32s]
Jobs: 1 (f=1): [W(1)][25.6%][w=103MiB/s][w=103 IOPS][eta 01m:30s]
Jobs: 1 (f=1): [W(1)][26.7%][w=103MiB/s][w=102 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [W(1)][28.3%][eta 01m:26s]
Jobs: 1 (f=1): [W(1)][30.0%][w=47.0MiB/s][w=46 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [W(1)][31.4%][w=108MiB/s][w=108 IOPS][eta 01m:23s]
Jobs: 1 (f=1): [W(1)][32.2%][w=50.9MiB/s][w=50 IOPS][eta 01m:22s]
Jobs: 1 (f=1): [W(1)][33.1%][eta 01m:21s]
Jobs: 1 (f=1): [W(1)][34.7%][w=49.1MiB/s][w=49 IOPS][eta 01m:19s]
Jobs: 1 (f=1): [W(1)][36.4%][w=104MiB/s][w=104 IOPS][eta 01m:17s]
Jobs: 1 (f=1): [W(1)][37.5%][w=31.8MiB/s][w=31 IOPS][eta 01m:15s]
Jobs: 1 (f=1): [W(1)][38.7%][w=100MiB/s][w=100 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][39.7%][w=109MiB/s][w=109 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][40.5%][w=104MiB/s][w=104 IOPS][eta 01m:12s]
Jobs: 1 (f=1): [W(1)][41.3%][w=104MiB/s][w=104 IOPS][eta 01m:11s]
Jobs: 1 (f=1): [W(1)][42.1%][w=108MiB/s][w=107 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [W(1)][43.0%][w=105MiB/s][w=104 IOPS][eta 01m:09s]
Jobs: 1 (f=1): [W(1)][44.6%][w=103MiB/s][w=103 IOPS][eta 01m:07s]
Jobs: 1 (f=1): [W(1)][46.3%][w=53.1MiB/s][w=53 IOPS][eta 01m:05s]
Jobs: 1 (f=1): [W(1)][47.9%][w=106MiB/s][w=106 IOPS][eta 01m:03s]
Jobs: 1 (f=1): [W(1)][49.6%][w=107MiB/s][w=107 IOPS][eta 01m:01s]
Jobs: 1 (f=1): [W(1)][51.2%][w=106MiB/s][w=105 IOPS][eta 00m:59s]
Jobs: 1 (f=1): [W(1)][52.9%][w=104MiB/s][w=104 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [W(1)][53.7%][w=93.8MiB/s][w=93 IOPS][eta 00m:56s]
Jobs: 1 (f=1): [W(1)][55.8%][w=103MiB/s][w=103 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [W(1)][56.2%][w=108MiB/s][w=107 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [W(1)][57.9%][w=106MiB/s][w=106 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [W(1)][59.2%][w=104MiB/s][w=103 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [W(1)][60.3%][w=105MiB/s][w=104 IOPS][eta 00m:48s]
Jobs: 1 (f=1): [W(1)][62.0%][eta 00m:46s]
Jobs: 1 (f=1): [W(1)][62.8%][w=27.9MiB/s][w=27 IOPS][eta 00m:45s]
Jobs: 1 (f=1): [W(1)][65.0%][w=70.8MiB/s][w=70 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][66.1%][w=105MiB/s][w=104 IOPS][eta 00m:41s]
Jobs: 1 (f=1): [W(1)][66.9%][w=107MiB/s][w=106 IOPS][eta 00m:40s]
Jobs: 1 (f=1): [W(1)][68.6%][w=107MiB/s][w=107 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [W(1)][70.2%][w=107MiB/s][w=106 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [W(1)][71.9%][w=103MiB/s][w=103 IOPS][eta 00m:34s]
Jobs: 1 (f=1): [W(1)][73.6%][w=28.1MiB/s][w=28 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [W(1)][74.4%][w=79.9MiB/s][w=79 IOPS][eta 00m:31s]
Jobs: 1 (f=1): [W(1)][75.2%][w=107MiB/s][w=106 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [W(1)][77.5%][w=106MiB/s][w=106 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [W(1)][77.7%][w=105MiB/s][w=105 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [W(1)][79.3%][w=104MiB/s][w=103 IOPS][eta 00m:25s]
Jobs: 1 (f=1): [W(1)][81.0%][w=102MiB/s][w=102 IOPS][eta 00m:23s]
Jobs: 1 (f=1): [W(1)][82.6%][w=73.0MiB/s][w=73 IOPS][eta 00m:21s]
Jobs: 1 (f=1): [W(1)][84.3%][w=106MiB/s][w=106 IOPS][eta 00m:19s]
Jobs: 1 (f=1): [W(1)][86.0%][w=107MiB/s][w=106 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [W(1)][87.6%][w=104MiB/s][w=104 IOPS][eta 00m:15s]
Jobs: 1 (f=1): [W(1)][89.3%][w=103MiB/s][w=102 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [W(1)][90.9%][w=94.9MiB/s][w=94 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [W(1)][91.7%][w=107MiB/s][w=106 IOPS][eta 00m:10s]
Jobs: 1 (f=1): [W(1)][93.4%][w=103MiB/s][w=103 IOPS][eta 00m:08s]
Jobs: 1 (f=1): [W(1)][95.0%][w=104MiB/s][w=104 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [W(1)][95.9%][w=101MiB/s][w=100 IOPS][eta 00m:05s]
Jobs: 1 (f=1): [W(1)][96.7%][w=86.5MiB/s][w=86 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [W(1)][97.5%][eta 00m:03s]
Jobs: 1 (f=1): [W(1)][98.3%][w=53.9MiB/s][w=53 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [W(1)][100.0%][w=102MiB/s][w=102 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=58690: Fri May 31 13:14:57 2024
  write: IOPS=91, BW=91.9MiB/s (96.4MB/s)(10.8GiB/120152msec); 0 zone resets
    slat (nsec): min=0, max=57188k, avg=34999.46, stdev=651012.79
    clat (msec): min=54, max=3699, avg=173.99, stdev=210.48
     lat (msec): min=56, max=3699, avg=174.03, stdev=210.48
    clat percentiles (msec):
     |  1.00th=[   94],  5.00th=[  106], 10.00th=[  114], 20.00th=[  124],
     | 30.00th=[  132], 40.00th=[  133], 50.00th=[  142], 60.00th=[  142],
     | 70.00th=[  150], 80.00th=[  163], 90.00th=[  211], 95.00th=[  292],
     | 99.00th=[  978], 99.50th=[ 1821], 99.90th=[ 3473], 99.95th=[ 3507],
     | 99.99th=[ 3574]
   bw (  KiB/s): min= 6144, max=120350, per=100.00%, avg=101380.42, stdev=20165.66, samples=221
   iops        : min=    6, max=  117, avg=98.48, stdev=19.72, samples=221
  lat (msec)   : 100=2.13%, 250=91.06%, 500=4.85%, 750=0.56%, 1000=0.43%
  lat (msec)   : 2000=0.66%, >=2000=0.30%
  cpu          : usr=0.40%, sys=0.16%, ctx=12281, majf=0, minf=8
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.2%, 16=52.8%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.0%, 8=1.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,11041,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=91.9MiB/s (96.4MB/s), 91.9MiB/s-91.9MiB/s (96.4MB/s-96.4MB/s), io=10.8GiB (11.6GB), run=120152-120152msec
```
