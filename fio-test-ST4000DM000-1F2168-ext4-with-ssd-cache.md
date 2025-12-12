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
Jobs: 4 (f=4): [m(4)][2.5%][r=5494KiB/s,w=5811KiB/s][r=1373,w=1452 IOPS][eta 01m:57s]
Jobs: 4 (f=4): [m(4)][3.3%][eta 01m:56s]
Jobs: 4 (f=4): [m(4)][5.0%][r=5644KiB/s,w=6040KiB/s][r=1411,w=1510 IOPS][eta 01m:54s]
Jobs: 4 (f=4): [m(4)][6.7%][r=5761KiB/s,w=5929KiB/s][r=1440,w=1482 IOPS][eta 01m:52s]
Jobs: 4 (f=4): [m(4)][8.3%][r=2509KiB/s,w=2442KiB/s][r=627,w=610 IOPS][eta 01m:51s]
Jobs: 4 (f=4): [m(4)][9.2%][r=2825KiB/s,w=3034KiB/s][r=706,w=758 IOPS][eta 01m:49s]
Jobs: 4 (f=4): [m(4)][11.6%][eta 01m:47s]
Jobs: 4 (f=4): [m(4)][12.4%][r=723KiB/s,w=723KiB/s][r=180,w=180 IOPS][eta 01m:46s]
Jobs: 4 (f=4): [m(4)][14.0%][r=15KiB/s,w=19KiB/s][r=3,w=4 IOPS][eta 01m:44s]
Jobs: 4 (f=4): [m(4)][15.0%][eta 01m:42s]
Jobs: 4 (f=4): [m(4)][16.5%][r=3585KiB/s,w=3565KiB/s][r=896,w=891 IOPS][eta 01m:41s]
Jobs: 4 (f=4): [m(4)][18.2%][r=5768KiB/s,w=5968KiB/s][r=1442,w=1492 IOPS][eta 01m:39s]
Jobs: 4 (f=4): [m(4)][19.8%][r=6336KiB/s,w=5971KiB/s][r=1584,w=1492 IOPS][eta 01m:37s]
Jobs: 4 (f=4): [m(4)][20.8%][eta 01m:35s]
Jobs: 4 (f=4): [m(4)][22.5%][r=5850KiB/s,w=5758KiB/s][r=1462,w=1439 IOPS][eta 01m:33s]
Jobs: 4 (f=4): [m(4)][24.0%][r=5818KiB/s,w=6073KiB/s][r=1454,w=1518 IOPS][eta 01m:32s]
Jobs: 4 (f=4): [m(4)][25.0%][r=6106KiB/s,w=6010KiB/s][r=1526,w=1502 IOPS][eta 01m:30s]
Jobs: 4 (f=4): [m(4)][27.3%][eta 01m:28s]
Jobs: 4 (f=4): [m(4)][28.9%][r=2336KiB/s,w=2384KiB/s][r=584,w=596 IOPS][eta 01m:26s]
Jobs: 4 (f=4): [m(4)][30.0%][r=2296KiB/s,w=2208KiB/s][r=574,w=552 IOPS][eta 01m:24s]
Jobs: 4 (f=4): [m(4)][30.8%][r=3580KiB/s,w=3468KiB/s][r=895,w=867 IOPS][eta 01m:23s]
Jobs: 4 (f=4): [m(4)][33.1%][eta 01m:21s]
Jobs: 4 (f=4): [m(4)][34.7%][eta 01m:19s]
Jobs: 4 (f=4): [m(4)][36.4%][eta 01m:17s]
Jobs: 4 (f=4): [m(4)][37.5%][r=3511KiB/s,w=3370KiB/s][r=877,w=842 IOPS][eta 01m:15s]
Jobs: 4 (f=4): [m(4)][38.8%][r=2299KiB/s,w=2251KiB/s][r=574,w=562 IOPS][eta 01m:14s]
Jobs: 4 (f=4): [m(4)][40.0%][eta 01m:12s]
Jobs: 4 (f=4): [m(4)][41.7%][eta 01m:10s]
Jobs: 4 (f=4): [m(4)][43.3%][r=260KiB/s,w=218KiB/s][r=65,w=54 IOPS][eta 01m:08s]
Jobs: 4 (f=4): [m(4)][44.2%][eta 01m:07s]
Jobs: 4 (f=4): [m(4)][45.0%][eta 01m:06s]
Jobs: 4 (f=4): [m(4)][45.8%][eta 01m:05s]
Jobs: 4 (f=4): [m(4)][46.7%][eta 01m:04s]
Jobs: 4 (f=4): [m(4)][47.5%][eta 01m:03s]
Jobs: 4 (f=4): [m(4)][48.3%][eta 01m:02s]
Jobs: 4 (f=4): [m(4)][49.2%][r=159KiB/s,w=103KiB/s][r=39,w=25 IOPS][eta 01m:01s]
Jobs: 4 (f=4): [m(4)][50.4%][r=1724KiB/s,w=1572KiB/s][r=431,w=393 IOPS][eta 01m:00s]
Jobs: 4 (f=4): [m(4)][52.1%][r=4KiB/s][r=1 IOPS][eta 00m:58s]
Jobs: 4 (f=4): [m(4)][53.3%][r=730KiB/s,w=738KiB/s][r=182,w=184 IOPS][eta 00m:56s]
Jobs: 4 (f=4): [m(4)][54.2%][eta 00m:55s]
Jobs: 4 (f=4): [m(4)][55.8%][r=4072KiB/s,w=4301KiB/s][r=1018,w=1075 IOPS][eta 00m:53s]
Jobs: 4 (f=4): [m(4)][57.5%][r=1502KiB/s,w=1518KiB/s][r=375,w=379 IOPS][eta 00m:51s]
Jobs: 4 (f=4): [m(4)][58.3%][r=5888KiB/s,w=5788KiB/s][r=1472,w=1447 IOPS][eta 00m:50s]
Jobs: 4 (f=4): [m(4)][60.3%][eta 00m:48s]
Jobs: 4 (f=4): [m(4)][61.7%][r=3008KiB/s,w=2968KiB/s][r=752,w=742 IOPS][eta 00m:46s]
Jobs: 4 (f=4): [m(4)][62.8%][eta 00m:45s]
Jobs: 4 (f=4): [m(4)][64.5%][r=4372KiB/s,w=4356KiB/s][r=1093,w=1089 IOPS][eta 00m:43s]
Jobs: 4 (f=4): [m(4)][65.8%][r=3343KiB/s,w=3463KiB/s][r=835,w=865 IOPS][eta 00m:41s]
Jobs: 4 (f=4): [m(4)][66.9%][r=5732KiB/s,w=5932KiB/s][r=1433,w=1483 IOPS][eta 00m:40s]
Jobs: 4 (f=4): [m(4)][68.3%][eta 00m:38s]
Jobs: 4 (f=4): [m(4)][69.4%][r=2793KiB/s,w=2837KiB/s][r=698,w=709 IOPS][eta 00m:37s]
Jobs: 4 (f=4): [m(4)][71.1%][eta 00m:35s]
Jobs: 4 (f=4): [m(4)][72.7%][r=11KiB/s,w=23KiB/s][r=2,w=5 IOPS][eta 00m:33s]
Jobs: 4 (f=4): [m(4)][74.2%][eta 00m:31s]
Jobs: 4 (f=4): [m(4)][75.0%][r=2264KiB/s,w=2052KiB/s][r=566,w=513 IOPS][eta 00m:30s]
Jobs: 4 (f=4): [m(4)][76.7%][r=320KiB/s,w=300KiB/s][r=80,w=75 IOPS][eta 00m:28s]
Jobs: 4 (f=4): [m(4)][77.7%][eta 00m:27s]
Jobs: 4 (f=4): [m(4)][79.2%][r=1237KiB/s,w=1425KiB/s][r=309,w=356 IOPS][eta 00m:25s]
Jobs: 4 (f=4): [m(4)][80.8%][r=3492KiB/s,w=3428KiB/s][r=873,w=857 IOPS][eta 00m:23s]
Jobs: 4 (f=4): [m(4)][82.5%][r=6224KiB/s,w=6080KiB/s][r=1556,w=1520 IOPS][eta 00m:21s]
Jobs: 4 (f=4): [m(4)][84.2%][eta 00m:19s]
Jobs: 4 (f=4): [m(4)][85.8%][eta 00m:17s]
Jobs: 4 (f=4): [m(4)][86.8%][eta 00m:16s]
Jobs: 4 (f=4): [m(4)][88.4%][eta 00m:14s]
Jobs: 4 (f=4): [m(4)][89.3%][eta 00m:13s]
Jobs: 4 (f=4): [m(4)][90.9%][r=4388KiB/s,w=4288KiB/s][r=1097,w=1072 IOPS][eta 00m:11s]
Jobs: 4 (f=4): [m(4)][92.5%][eta 00m:09s]
Jobs: 4 (f=4): [m(4)][93.4%][eta 00m:08s]
Jobs: 4 (f=4): [m(4)][95.0%][eta 00m:06s]
Jobs: 4 (f=4): [m(4)][96.7%][r=864KiB/s,w=812KiB/s][r=216,w=203 IOPS][eta 00m:04s]
Jobs: 4 (f=4): [m(4)][98.3%][r=4480KiB/s,w=4264KiB/s][r=1120,w=1066 IOPS][eta 00m:02s]
Jobs: 4 (f=4): [m(4)][100.0%][eta 00m:00s]
Jobs: 4 (f=4): [m(4)][11.2%][eta 15m:58s]
iops-test-job: (groupid=0, jobs=4): err= 0: pid=51759: Fri May 31 10:46:43 2024
  read: IOPS=482, BW=1932KiB/s (1978kB/s)(229MiB/121494msec)
    slat (nsec): min=0, max=19858k, avg=4078.90, stdev=159713.13
    clat (usec): min=11, max=7581.3k, avg=67783.87, stdev=426692.50
     lat (usec): min=674, max=7581.3k, avg=67787.95, stdev=426692.24
    clat percentiles (msec):
     |  1.00th=[   15],  5.00th=[   18], 10.00th=[   18], 20.00th=[   20],
     | 30.00th=[   21], 40.00th=[   21], 50.00th=[   22], 60.00th=[   23],
     | 70.00th=[   24], 80.00th=[   25], 90.00th=[   28], 95.00th=[   32],
     | 99.00th=[ 1905], 99.50th=[ 2039], 99.90th=[ 7416], 99.95th=[ 7550],
     | 99.99th=[ 7550]
   bw (  KiB/s): min=   84, max= 6767, per=100.00%, avg=4070.87, stdev=511.01, samples=458
   iops        : min=   18, max= 1690, avg=1016.17, stdev=127.80, samples=458
  write: IOPS=485, BW=1941KiB/s (1987kB/s)(230MiB/121494msec); 0 zone resets
    slat (nsec): min=0, max=22575k, avg=3643.00, stdev=140039.08
    clat (usec): min=157, max=7581.7k, avg=64367.68, stdev=400922.26
     lat (usec): min=482, max=7581.7k, avg=64371.32, stdev=400922.18
    clat percentiles (msec):
     |  1.00th=[   15],  5.00th=[   17], 10.00th=[   18], 20.00th=[   20],
     | 30.00th=[   21], 40.00th=[   21], 50.00th=[   22], 60.00th=[   23],
     | 70.00th=[   23], 80.00th=[   24], 90.00th=[   27], 95.00th=[   30],
     | 99.00th=[ 1888], 99.50th=[ 2022], 99.90th=[ 6409], 99.95th=[ 7416],
     | 99.99th=[ 7550]
   bw (  KiB/s): min=   44, max= 6626, per=100.00%, avg=4090.15, stdev=516.60, samples=458
   iops        : min=    8, max= 1656, avg=1020.99, stdev=129.20, samples=458
  lat (usec)   : 20=0.01%, 50=0.01%, 250=0.01%, 500=0.01%, 750=0.01%
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.04%, 10=0.26%, 20=29.45%, 50=67.57%
  lat (msec)   : 100=0.24%, 250=0.57%, 500=0.32%, 1000=0.05%, 2000=0.87%
  lat (msec)   : >=2000=0.60%
  cpu          : usr=0.24%, sys=0.28%, ctx=110418, majf=0, minf=40
  IO depths    : 1=0.1%, 2=0.1%, 4=0.4%, 8=51.5%, 16=48.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.4%, 8=1.5%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=58670,58942,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=1932KiB/s (1978kB/s), 1932KiB/s-1932KiB/s (1978kB/s-1978kB/s), io=229MiB (240MB), run=121494-121494msec
  WRITE: bw=1941KiB/s (1987kB/s), 1941KiB/s-1941KiB/s (1987kB/s-1987kB/s), io=230MiB (241MB), run=121494-121494msec
```

## Throughput test: sequential read

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [R(1)][2.5%][r=116MiB/s][r=116 IOPS][eta 01m:58s]
Jobs: 1 (f=1): [R(1)][4.1%][r=114MiB/s][r=114 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [R(1)][5.8%][r=111MiB/s][r=110 IOPS][eta 01m:54s]
Jobs: 1 (f=1): [R(1)][7.4%][r=115MiB/s][r=115 IOPS][eta 01m:52s]
Jobs: 1 (f=1): [R(1)][9.1%][r=116MiB/s][r=116 IOPS][eta 01m:50s]
Jobs: 1 (f=1): [R(1)][10.7%][r=110MiB/s][r=110 IOPS][eta 01m:48s]
Jobs: 1 (f=1): [R(1)][12.4%][r=107MiB/s][r=107 IOPS][eta 01m:46s]
Jobs: 1 (f=1): [R(1)][13.2%][r=117MiB/s][r=116 IOPS][eta 01m:45s]
Jobs: 1 (f=1): [R(1)][14.9%][r=110MiB/s][r=110 IOPS][eta 01m:43s]
Jobs: 1 (f=1): [R(1)][15.7%][r=114MiB/s][r=113 IOPS][eta 01m:42s]
Jobs: 1 (f=1): [R(1)][17.4%][r=117MiB/s][r=117 IOPS][eta 01m:40s]
Jobs: 1 (f=1): [R(1)][19.0%][r=111MiB/s][r=110 IOPS][eta 01m:38s]
Jobs: 1 (f=1): [R(1)][20.7%][r=108MiB/s][r=108 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [R(1)][21.5%][r=115MiB/s][r=114 IOPS][eta 01m:35s]
Jobs: 1 (f=1): [R(1)][22.3%][r=106MiB/s][r=105 IOPS][eta 01m:34s]
Jobs: 1 (f=1): [R(1)][24.0%][r=104MiB/s][r=104 IOPS][eta 01m:32s]
Jobs: 1 (f=1): [R(1)][25.6%][r=113MiB/s][r=112 IOPS][eta 01m:30s]
Jobs: 1 (f=1): [R(1)][27.3%][r=115MiB/s][r=114 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [R(1)][28.9%][r=117MiB/s][r=117 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [R(1)][30.6%][r=111MiB/s][r=111 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [R(1)][31.4%][r=114MiB/s][r=113 IOPS][eta 01m:23s]
Jobs: 1 (f=1): [R(1)][33.1%][r=117MiB/s][r=117 IOPS][eta 01m:21s]
Jobs: 1 (f=1): [R(1)][34.2%][r=115MiB/s][r=115 IOPS][eta 01m:19s]
Jobs: 1 (f=1): [R(1)][35.0%][r=113MiB/s][r=112 IOPS][eta 01m:18s]
Jobs: 1 (f=1): [R(1)][35.8%][r=109MiB/s][r=109 IOPS][eta 01m:17s]
Jobs: 1 (f=1): [R(1)][36.7%][r=114MiB/s][r=114 IOPS][eta 01m:16s]
Jobs: 1 (f=1): [R(1)][38.0%][r=105MiB/s][r=105 IOPS][eta 01m:15s]
Jobs: 1 (f=1): [R(1)][39.2%][r=119MiB/s][r=118 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [R(1)][40.5%][r=109MiB/s][r=108 IOPS][eta 01m:12s]
Jobs: 1 (f=1): [R(1)][42.1%][r=106MiB/s][r=106 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [R(1)][43.8%][r=112MiB/s][r=112 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [R(1)][44.6%][r=109MiB/s][r=108 IOPS][eta 01m:07s]
Jobs: 1 (f=1): [R(1)][46.3%][r=107MiB/s][r=107 IOPS][eta 01m:05s]
Jobs: 1 (f=1): [R(1)][47.9%][r=111MiB/s][r=111 IOPS][eta 01m:03s]
Jobs: 1 (f=1): [R(1)][49.6%][r=112MiB/s][r=111 IOPS][eta 01m:01s]
Jobs: 1 (f=1): [R(1)][51.2%][r=114MiB/s][r=114 IOPS][eta 00m:59s]
Jobs: 1 (f=1): [R(1)][52.9%][r=118MiB/s][r=117 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [R(1)][53.7%][r=108MiB/s][r=107 IOPS][eta 00m:56s]
Jobs: 1 (f=1): [R(1)][55.8%][r=112MiB/s][r=111 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [R(1)][57.0%][r=115MiB/s][r=115 IOPS][eta 00m:52s]
Jobs: 1 (f=1): [R(1)][57.9%][r=112MiB/s][r=112 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [R(1)][59.5%][r=107MiB/s][r=107 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [R(1)][61.2%][r=110MiB/s][r=110 IOPS][eta 00m:47s]
Jobs: 1 (f=1): [R(1)][62.8%][r=113MiB/s][r=113 IOPS][eta 00m:45s]
Jobs: 1 (f=1): [R(1)][65.0%][r=116MiB/s][r=115 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [R(1)][66.1%][r=112MiB/s][r=111 IOPS][eta 00m:41s]
Jobs: 1 (f=1): [R(1)][68.3%][r=112MiB/s][r=112 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][68.6%][r=113MiB/s][r=112 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][70.2%][r=114MiB/s][r=113 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [R(1)][71.9%][r=112MiB/s][r=111 IOPS][eta 00m:34s]
Jobs: 1 (f=1): [R(1)][73.6%][r=110MiB/s][r=110 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [R(1)][75.2%][r=112MiB/s][r=112 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [R(1)][77.5%][r=114MiB/s][r=113 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [R(1)][78.5%][r=113MiB/s][r=112 IOPS][eta 00m:26s]
Jobs: 1 (f=1): [R(1)][80.2%][r=111MiB/s][r=110 IOPS][eta 00m:24s]
Jobs: 1 (f=1): [R(1)][81.8%][r=115MiB/s][r=114 IOPS][eta 00m:22s]
Jobs: 1 (f=1): [R(1)][82.6%][r=113MiB/s][r=112 IOPS][eta 00m:21s]
Jobs: 1 (f=1): [R(1)][84.3%][r=115MiB/s][r=114 IOPS][eta 00m:19s]
Jobs: 1 (f=1): [R(1)][86.0%][r=114MiB/s][r=114 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [R(1)][87.6%][r=111MiB/s][r=111 IOPS][eta 00m:15s]
Jobs: 1 (f=1): [R(1)][89.3%][r=111MiB/s][r=111 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [R(1)][90.1%][r=114MiB/s][r=113 IOPS][eta 00m:12s]
Jobs: 1 (f=1): [R(1)][91.7%][r=112MiB/s][r=112 IOPS][eta 00m:10s]
Jobs: 1 (f=1): [R(1)][92.6%][r=111MiB/s][r=111 IOPS][eta 00m:09s]
Jobs: 1 (f=1): [R(1)][93.4%][r=113MiB/s][r=113 IOPS][eta 00m:08s]
Jobs: 1 (f=1): [R(1)][94.2%][r=111MiB/s][r=110 IOPS][eta 00m:07s]
Jobs: 1 (f=1): [R(1)][95.0%][r=109MiB/s][r=109 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [R(1)][96.7%][r=110MiB/s][r=110 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [R(1)][98.3%][r=113MiB/s][r=112 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [R(1)][100.0%][r=115MiB/s][r=115 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=51939: Fri May 31 10:49:02 2024
  read: IOPS=111, BW=112MiB/s (117MB/s)(13.1GiB/120106msec)
    slat (nsec): min=0, max=4400.0k, avg=3902.62, stdev=47411.15
    clat (msec): min=28, max=240, avg=143.22, stdev=15.08
     lat (msec): min=28, max=240, avg=143.23, stdev=15.08
    clat percentiles (msec):
     |  1.00th=[   81],  5.00th=[  115], 10.00th=[  134], 20.00th=[  142],
     | 30.00th=[  144], 40.00th=[  144], 50.00th=[  144], 60.00th=[  153],
     | 70.00th=[  153], 80.00th=[  153], 90.00th=[  153], 95.00th=[  153],
     | 99.00th=[  163], 99.50th=[  169], 99.90th=[  215], 99.95th=[  241],
     | 99.99th=[  241]
   bw (  KiB/s): min=91610, max=130810, per=100.00%, avg=114435.57, stdev=5875.70, samples=238
   iops        : min=   89, max=  127, avg=111.23, stdev= 5.78, samples=238
  lat (msec)   : 50=0.01%, 100=3.41%, 250=96.57%
  cpu          : usr=0.13%, sys=0.15%, ctx=14677, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.1%, 16=52.8%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=97.6%, 8=2.3%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=13412,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=112MiB/s (117MB/s), 112MiB/s-112MiB/s (117MB/s-117MB/s), io=13.1GiB (14.1GB), run=120106-120106msec
```

## Throughput test: sequential write

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [W(1)][2.5%][w=108MiB/s][w=107 IOPS][eta 01m:58s]
Jobs: 1 (f=1): [W(1)][4.1%][w=104MiB/s][w=103 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [W(1)][5.0%][w=105MiB/s][w=104 IOPS][eta 01m:55s]
Jobs: 1 (f=1): [W(1)][6.6%][w=104MiB/s][w=104 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [W(1)][8.3%][w=100MiB/s][w=100 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [W(1)][9.9%][w=103MiB/s][w=102 IOPS][eta 01m:49s]
Jobs: 1 (f=1): [W(1)][11.6%][w=106MiB/s][w=105 IOPS][eta 01m:47s]
Jobs: 1 (f=1): [W(1)][12.4%][w=103MiB/s][w=103 IOPS][eta 01m:46s]
Jobs: 1 (f=1): [W(1)][14.0%][w=108MiB/s][w=107 IOPS][eta 01m:44s]
Jobs: 1 (f=1): [W(1)][15.7%][w=104MiB/s][w=104 IOPS][eta 01m:42s]
Jobs: 1 (f=1): [W(1)][16.5%][w=103MiB/s][w=102 IOPS][eta 01m:41s]
Jobs: 1 (f=1): [W(1)][18.2%][w=106MiB/s][w=105 IOPS][eta 01m:39s]
Jobs: 1 (f=1): [W(1)][20.0%][w=106MiB/s][w=105 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [W(1)][21.5%][w=105MiB/s][w=105 IOPS][eta 01m:35s]
Jobs: 1 (f=1): [W(1)][23.1%][w=103MiB/s][w=102 IOPS][eta 01m:33s]
Jobs: 1 (f=1): [W(1)][24.8%][w=104MiB/s][w=104 IOPS][eta 01m:31s]
Jobs: 1 (f=1): [W(1)][25.6%][w=106MiB/s][w=105 IOPS][eta 01m:30s]
Jobs: 1 (f=1): [W(1)][27.3%][w=105MiB/s][w=104 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [W(1)][28.3%][w=106MiB/s][w=105 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [W(1)][30.0%][w=106MiB/s][w=105 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [W(1)][31.4%][w=104MiB/s][w=104 IOPS][eta 01m:23s]
Jobs: 1 (f=1): [W(1)][33.1%][w=58.0MiB/s][w=58 IOPS][eta 01m:21s]
Jobs: 1 (f=1): [W(1)][34.7%][eta 01m:19s]
Jobs: 1 (f=1): [W(1)][36.4%][w=108MiB/s][w=108 IOPS][eta 01m:17s]
Jobs: 1 (f=1): [W(1)][37.2%][w=103MiB/s][w=102 IOPS][eta 01m:16s]
Jobs: 1 (f=1): [W(1)][39.2%][w=100MiB/s][w=100 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][39.7%][w=105MiB/s][w=104 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][41.3%][w=103MiB/s][w=103 IOPS][eta 01m:11s]
Jobs: 1 (f=1): [W(1)][42.1%][w=103MiB/s][w=102 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [W(1)][43.8%][w=106MiB/s][w=106 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [W(1)][44.6%][w=106MiB/s][w=105 IOPS][eta 01m:07s]
Jobs: 1 (f=1): [W(1)][46.3%][w=103MiB/s][w=103 IOPS][eta 01m:05s]
Jobs: 1 (f=1): [W(1)][47.1%][w=102MiB/s][w=101 IOPS][eta 01m:04s]
Jobs: 1 (f=1): [W(1)][48.8%][w=105MiB/s][w=105 IOPS][eta 01m:02s]
Jobs: 1 (f=1): [W(1)][50.4%][w=106MiB/s][w=105 IOPS][eta 01m:00s]
Jobs: 1 (f=1): [W(1)][52.5%][w=105MiB/s][w=104 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [W(1)][53.7%][w=101MiB/s][w=101 IOPS][eta 00m:56s]
Jobs: 1 (f=1): [W(1)][54.5%][w=106MiB/s][w=105 IOPS][eta 00m:55s]
Jobs: 1 (f=1): [W(1)][56.2%][w=105MiB/s][w=105 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [W(1)][57.9%][w=105MiB/s][w=104 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [W(1)][59.5%][w=108MiB/s][w=108 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [W(1)][60.3%][w=105MiB/s][w=104 IOPS][eta 00m:48s]
Jobs: 1 (f=1): [W(1)][62.0%][w=58.9MiB/s][w=58 IOPS][eta 00m:46s]
Jobs: 1 (f=1): [W(1)][63.6%][eta 00m:44s]
Jobs: 1 (f=1): [W(1)][65.3%][w=48.1MiB/s][w=48 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][66.1%][w=106MiB/s][w=105 IOPS][eta 00m:41s]
Jobs: 1 (f=1): [W(1)][66.9%][w=106MiB/s][w=105 IOPS][eta 00m:40s]
Jobs: 1 (f=1): [W(1)][68.6%][w=104MiB/s][w=104 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [W(1)][70.2%][w=60.0MiB/s][w=60 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [W(1)][71.1%][eta 00m:35s]
Jobs: 1 (f=1): [W(1)][71.9%][eta 00m:34s]
Jobs: 1 (f=1): [W(1)][73.6%][w=43.0MiB/s][w=43 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [W(1)][75.2%][w=106MiB/s][w=105 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [W(1)][77.5%][w=106MiB/s][w=106 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [W(1)][78.5%][w=103MiB/s][w=103 IOPS][eta 00m:26s]
Jobs: 1 (f=1): [W(1)][80.2%][w=107MiB/s][w=107 IOPS][eta 00m:24s]
Jobs: 1 (f=1): [W(1)][81.8%][w=104MiB/s][w=104 IOPS][eta 00m:22s]
Jobs: 1 (f=1): [W(1)][82.6%][w=103MiB/s][w=102 IOPS][eta 00m:21s]
Jobs: 1 (f=1): [W(1)][84.3%][w=110MiB/s][w=109 IOPS][eta 00m:19s]
Jobs: 1 (f=1): [W(1)][86.0%][w=105MiB/s][w=104 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [W(1)][87.6%][w=106MiB/s][w=106 IOPS][eta 00m:15s]
Jobs: 1 (f=1): [W(1)][89.3%][w=106MiB/s][w=105 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [W(1)][90.9%][w=99.9MiB/s][w=99 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [W(1)][92.6%][w=105MiB/s][w=105 IOPS][eta 00m:09s]
Jobs: 1 (f=1): [W(1)][94.2%][w=105MiB/s][w=105 IOPS][eta 00m:07s]
Jobs: 1 (f=1): [W(1)][95.9%][w=106MiB/s][w=105 IOPS][eta 00m:05s]
Jobs: 1 (f=1): [W(1)][96.7%][w=100MiB/s][w=100 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [W(1)][97.5%][w=108MiB/s][w=107 IOPS][eta 00m:03s]
Jobs: 1 (f=1): [W(1)][98.3%][w=103MiB/s][w=103 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [W(1)][99.2%][w=63.4MiB/s][w=63 IOPS][eta 00m:01s]
Jobs: 1 (f=1): [W(1)][100.0%][eta 00m:00s]
Jobs: 1 (f=1): [W(1)][100.0%][eta 00m:00s]
Jobs: 1 (f=1): [W(1)][100.0%][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=52100: Fri May 31 10:51:20 2024
  write: IOPS=91, BW=91.4MiB/s (95.8MB/s)(11.1GiB/123910msec); 0 zone resets
    slat (nsec): min=0, max=96749k, avg=29057.06, stdev=910653.29
    clat (msec): min=51, max=5771, avg=175.03, stdev=315.26
     lat (msec): min=51, max=5771, avg=175.06, stdev=315.26
    clat percentiles (msec):
     |  1.00th=[   94],  5.00th=[  107], 10.00th=[  115], 20.00th=[  125],
     | 30.00th=[  133], 40.00th=[  134], 50.00th=[  142], 60.00th=[  142],
     | 70.00th=[  150], 80.00th=[  161], 90.00th=[  180], 95.00th=[  239],
     | 99.00th=[  634], 99.50th=[ 2702], 99.90th=[ 5403], 99.95th=[ 5470],
     | 99.99th=[ 5604]
   bw (  KiB/s): min=18249, max=118075, per=100.00%, avg=105464.17, stdev=11585.28, samples=218
   iops        : min=   17, max=  115, avg=102.44, stdev=11.32, samples=218
  lat (msec)   : 100=2.27%, 250=93.20%, 500=3.04%, 750=0.66%, 1000=0.19%
  lat (msec)   : 2000=0.08%, >=2000=0.57%
  cpu          : usr=0.39%, sys=0.17%, ctx=12503, majf=0, minf=8
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.3%, 16=52.6%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.9%, 8=1.1%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,11322,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=91.4MiB/s (95.8MB/s), 91.4MiB/s-91.4MiB/s (95.8MB/s-95.8MB/s), io=11.1GiB (11.9GB), run=123910-123910msec
```
