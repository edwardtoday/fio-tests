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
Jobs: 4 (f=4): [m(4)][3.3%][r=1606KiB/s,w=1510KiB/s][r=401,w=377 IOPS][eta 01m:57s]
Jobs: 4 (f=4): [m(4)][4.2%][r=1298KiB/s,w=1478KiB/s][r=324,w=369 IOPS][eta 01m:55s]
Jobs: 4 (f=4): [m(4)][5.8%][r=1403KiB/s,w=1495KiB/s][r=350,w=373 IOPS][eta 01m:53s]
Jobs: 4 (f=4): [m(4)][6.7%][r=5800KiB/s,w=6039KiB/s][r=1450,w=1509 IOPS][eta 01m:52s]
Jobs: 4 (f=4): [m(4)][9.1%][eta 01m:50s]
Jobs: 4 (f=4): [m(4)][10.7%][r=5746KiB/s,w=5811KiB/s][r=1436,w=1452 IOPS][eta 01m:48s]
Jobs: 4 (f=4): [m(4)][12.4%][r=119KiB/s,w=147KiB/s][r=29,w=36 IOPS][eta 01m:46s]
Jobs: 4 (f=4): [m(4)][13.2%][r=3477KiB/s,w=3760KiB/s][r=869,w=940 IOPS][eta 01m:45s]
Jobs: 4 (f=4): [m(4)][14.9%][r=1344KiB/s,w=1280KiB/s][r=336,w=320 IOPS][eta 01m:43s]
Jobs: 4 (f=4): [m(4)][16.5%][r=260KiB/s,w=204KiB/s][r=65,w=51 IOPS][eta 01m:41s]
Jobs: 4 (f=4): [m(4)][17.4%][eta 01m:40s]
Jobs: 4 (f=4): [m(4)][19.0%][r=617KiB/s,w=489KiB/s][r=154,w=122 IOPS][eta 01m:38s]
Jobs: 4 (f=4): [m(4)][20.7%][r=1633KiB/s,w=1709KiB/s][r=408,w=427 IOPS][eta 01m:36s]
Jobs: 4 (f=4): [m(4)][21.5%][eta 01m:35s]
Jobs: 4 (f=4): [m(4)][22.3%][r=191KiB/s,w=231KiB/s][r=47,w=57 IOPS][eta 01m:34s]
Jobs: 4 (f=4): [m(4)][24.0%][r=3123KiB/s,w=3303KiB/s][r=780,w=825 IOPS][eta 01m:32s]
Jobs: 4 (f=4): [m(4)][25.6%][r=1500KiB/s,w=1669KiB/s][r=375,w=417 IOPS][eta 01m:30s]
Jobs: 4 (f=4): [m(4)][26.4%][eta 01m:29s]
Jobs: 4 (f=4): [m(4)][28.1%][r=2974KiB/s,w=3039KiB/s][r=743,w=759 IOPS][eta 01m:27s]
Jobs: 4 (f=4): [m(4)][29.8%][r=432KiB/s,w=396KiB/s][r=108,w=99 IOPS][eta 01m:25s]
Jobs: 4 (f=4): [m(4)][31.4%][r=2105KiB/s,w=2101KiB/s][r=526,w=525 IOPS][eta 01m:23s]
Jobs: 4 (f=4): [m(4)][33.1%][r=329KiB/s,w=345KiB/s][r=82,w=86 IOPS][eta 01m:21s]
Jobs: 4 (f=4): [m(4)][34.7%][eta 01m:19s]
Jobs: 4 (f=4): [m(4)][36.4%][r=2693KiB/s,w=2881KiB/s][r=673,w=720 IOPS][eta 01m:17s]
Jobs: 4 (f=4): [m(4)][38.0%][r=3114KiB/s,w=3206KiB/s][r=778,w=801 IOPS][eta 01m:15s]
Jobs: 4 (f=4): [m(4)][39.7%][eta 01m:13s]
Jobs: 4 (f=4): [m(4)][40.8%][eta 01m:11s]
Jobs: 4 (f=4): [m(4)][42.1%][r=2678KiB/s,w=2670KiB/s][r=669,w=667 IOPS][eta 01m:10s]
Jobs: 4 (f=4): [m(4)][43.0%][r=1623KiB/s,w=1532KiB/s][r=405,w=383 IOPS][eta 01m:09s]
Jobs: 4 (f=4): [m(4)][43.8%][eta 01m:08s]
Jobs: 4 (f=4): [m(4)][44.6%][r=426KiB/s,w=442KiB/s][r=106,w=110 IOPS][eta 01m:07s]
Jobs: 4 (f=4): [m(4)][45.5%][eta 01m:06s]
Jobs: 4 (f=4): [m(4)][46.3%][r=4318KiB/s,w=4043KiB/s][r=1079,w=1010 IOPS][eta 01m:05s]
Jobs: 4 (f=4): [m(4)][47.1%][r=6013KiB/s,w=5986KiB/s][r=1503,w=1496 IOPS][eta 01m:04s]
Jobs: 4 (f=4): [m(4)][48.8%][r=781KiB/s,w=809KiB/s][r=195,w=202 IOPS][eta 01m:02s]
Jobs: 4 (f=4): [m(4)][49.6%][eta 01m:01s]
Jobs: 4 (f=4): [m(4)][51.2%][eta 00m:59s]
Jobs: 4 (f=4): [m(4)][52.9%][r=6027KiB/s,w=6039KiB/s][r=1506,w=1509 IOPS][eta 00m:57s]
Jobs: 4 (f=4): [m(4)][54.5%][eta 00m:55s]
Jobs: 4 (f=4): [m(4)][55.4%][r=1844KiB/s,w=1824KiB/s][r=461,w=456 IOPS][eta 00m:54s]
Jobs: 4 (f=4): [m(4)][57.0%][r=1324KiB/s,w=1408KiB/s][r=331,w=352 IOPS][eta 00m:52s]
Jobs: 4 (f=4): [m(4)][57.9%][r=6173KiB/s,w=5950KiB/s][r=1543,w=1487 IOPS][eta 00m:51s]
Jobs: 4 (f=4): [m(4)][59.5%][eta 00m:49s]
Jobs: 4 (f=4): [m(4)][61.2%][eta 00m:47s]
Jobs: 4 (f=4): [m(4)][62.8%][r=6080KiB/s,w=5931KiB/s][r=1520,w=1482 IOPS][eta 00m:45s]
Jobs: 4 (f=4): [m(4)][63.6%][r=5946KiB/s,w=5870KiB/s][r=1486,w=1467 IOPS][eta 00m:44s]
Jobs: 4 (f=4): [m(4)][65.3%][eta 00m:42s]
Jobs: 4 (f=4): [m(4)][66.9%][r=5981KiB/s,w=6034KiB/s][r=1495,w=1508 IOPS][eta 00m:40s]
Jobs: 4 (f=4): [m(4)][68.6%][eta 00m:38s]
Jobs: 4 (f=4): [m(4)][70.2%][eta 00m:36s]
Jobs: 4 (f=4): [m(4)][71.1%][r=79KiB/s,w=51KiB/s][r=19,w=12 IOPS][eta 00m:35s]
Jobs: 4 (f=4): [m(4)][72.7%][eta 00m:33s]
Jobs: 4 (f=4): [m(4)][73.6%][r=5746KiB/s,w=5714KiB/s][r=1436,w=1428 IOPS][eta 00m:32s]
Jobs: 4 (f=4): [m(4)][74.4%][r=5574KiB/s,w=5550KiB/s][r=1393,w=1387 IOPS][eta 00m:31s]
Jobs: 4 (f=4): [m(4)][76.0%][r=435KiB/s,w=459KiB/s][r=108,w=114 IOPS][eta 00m:29s]
Jobs: 4 (f=4): [m(4)][77.7%][r=3190KiB/s,w=3245KiB/s][r=797,w=811 IOPS][eta 00m:27s]
Jobs: 4 (f=4): [m(4)][78.5%][eta 00m:26s]
Jobs: 4 (f=4): [m(4)][80.2%][eta 00m:24s]
Jobs: 4 (f=4): [m(4)][81.8%][r=5507KiB/s,w=5559KiB/s][r=1376,w=1389 IOPS][eta 00m:22s]
Jobs: 4 (f=4): [m(4)][83.5%][r=232KiB/s,w=328KiB/s][r=58,w=82 IOPS][eta 00m:20s]
Jobs: 4 (f=4): [m(4)][84.3%][r=6683KiB/s,w=6731KiB/s][r=1670,w=1682 IOPS][eta 00m:19s]
Jobs: 4 (f=4): [m(4)][86.0%][r=1631KiB/s,w=1591KiB/s][r=407,w=397 IOPS][eta 00m:17s]
Jobs: 4 (f=4): [m(4)][87.6%][r=3131KiB/s,w=3430KiB/s][r=782,w=857 IOPS][eta 00m:15s]
Jobs: 4 (f=4): [m(4)][89.3%][eta 00m:13s]
Jobs: 4 (f=4): [m(4)][90.9%][r=6024KiB/s,w=5944KiB/s][r=1506,w=1486 IOPS][eta 00m:11s]
Jobs: 4 (f=4): [m(4)][91.7%][r=5958KiB/s,w=6029KiB/s][r=1489,w=1507 IOPS][eta 00m:10s]
Jobs: 4 (f=4): [m(4)][92.6%][r=6031KiB/s,w=5996KiB/s][r=1507,w=1499 IOPS][eta 00m:09s]
Jobs: 4 (f=4): [m(4)][94.2%][eta 00m:07s]
Jobs: 4 (f=4): [m(4)][95.9%][eta 00m:05s]
Jobs: 4 (f=4): [m(4)][96.7%][r=734KiB/s,w=703KiB/s][r=183,w=175 IOPS][eta 00m:04s]
Jobs: 4 (f=4): [m(4)][97.5%][r=6158KiB/s,w=5992KiB/s][r=1539,w=1498 IOPS][eta 00m:03s]
Jobs: 4 (f=4): [m(4)][99.2%][r=5791KiB/s,w=5994KiB/s][r=1447,w=1498 IOPS][eta 00m:01s]
Jobs: 4 (f=4): [m(4)][12.1%][r=5896KiB/s,w=6000KiB/s][r=1474,w=1500 IOPS][eta 14m:40s]
iops-test-job: (groupid=0, jobs=4): err= 0: pid=60000: Fri May 31 13:29:42 2024
  read: IOPS=527, BW=2109KiB/s (2159kB/s)(247MiB/120022msec)
    slat (nsec): min=0, max=5706.0k, avg=2548.14, stdev=43929.68
    clat (usec): min=529, max=4037.8k, avg=60257.06, stdev=280632.67
     lat (usec): min=942, max=4037.8k, avg=60259.61, stdev=280632.91
    clat percentiles (msec):
     |  1.00th=[   15],  5.00th=[   17], 10.00th=[   18], 20.00th=[   19],
     | 30.00th=[   20], 40.00th=[   21], 50.00th=[   22], 60.00th=[   22],
     | 70.00th=[   23], 80.00th=[   25], 90.00th=[   27], 95.00th=[   30],
     | 99.00th=[ 2022], 99.50th=[ 2022], 99.90th=[ 2039], 99.95th=[ 2056],
     | 99.99th=[ 4044]
   bw (  KiB/s): min=   52, max= 7126, per=100.00%, avg=4090.86, stdev=543.97, samples=490
   iops        : min=   10, max= 1780, avg=1021.20, stdev=136.11, samples=490
  write: IOPS=530, BW=2121KiB/s (2172kB/s)(249MiB/120022msec); 0 zone resets
    slat (nsec): min=0, max=49139k, avg=3474.04, stdev=198219.49
    clat (usec): min=15, max=4035.7k, avg=60736.22, stdev=280680.85
     lat (usec): min=1009, max=4035.7k, avg=60739.69, stdev=280680.90
    clat percentiles (msec):
     |  1.00th=[   15],  5.00th=[   17], 10.00th=[   18], 20.00th=[   19],
     | 30.00th=[   20], 40.00th=[   21], 50.00th=[   22], 60.00th=[   22],
     | 70.00th=[   23], 80.00th=[   24], 90.00th=[   26], 95.00th=[   29],
     | 99.00th=[ 2022], 99.50th=[ 2022], 99.90th=[ 2039], 99.95th=[ 2039],
     | 99.99th=[ 4044]
   bw (  KiB/s): min=   37, max= 7062, per=100.00%, avg=4106.89, stdev=542.51, samples=491
   iops        : min=    7, max= 1764, avg=1025.15, stdev=135.73, samples=491
  lat (usec)   : 20=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.12%, 20=34.62%, 50=63.07%
  lat (msec)   : 100=0.19%, 250=0.05%, 2000=0.10%, >=2000=1.83%
  cpu          : usr=0.22%, sys=0.25%, ctx=111491, majf=0, minf=30
  IO depths    : 1=0.1%, 2=0.1%, 4=0.4%, 8=53.5%, 16=46.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.0%, 8=1.8%, 16=0.2%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=63268,63645,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=2109KiB/s (2159kB/s), 2109KiB/s-2109KiB/s (2159kB/s-2159kB/s), io=247MiB (259MB), run=120022-120022msec
  WRITE: bw=2121KiB/s (2172kB/s), 2121KiB/s-2121KiB/s (2172kB/s-2172kB/s), io=249MiB (261MB), run=120022-120022msec
```

## Throughput test: sequential read

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [R(1)][3.3%][r=114MiB/s][r=113 IOPS][eta 01m:57s]
Jobs: 1 (f=1): [R(1)][4.1%][r=107MiB/s][r=106 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [R(1)][5.8%][r=104MiB/s][r=104 IOPS][eta 01m:54s]
Jobs: 1 (f=1): [R(1)][6.6%][r=119MiB/s][r=118 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [R(1)][8.3%][r=108MiB/s][r=107 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [R(1)][9.9%][r=105MiB/s][r=104 IOPS][eta 01m:49s]
Jobs: 1 (f=1): [R(1)][10.8%][r=111MiB/s][r=111 IOPS][eta 01m:47s]
Jobs: 1 (f=1): [R(1)][11.7%][r=110MiB/s][r=109 IOPS][eta 01m:46s]
Jobs: 1 (f=1): [R(1)][13.2%][r=113MiB/s][r=112 IOPS][eta 01m:45s]
Jobs: 1 (f=1): [R(1)][14.0%][r=108MiB/s][r=107 IOPS][eta 01m:44s]
Jobs: 1 (f=1): [R(1)][15.0%][r=108MiB/s][r=107 IOPS][eta 01m:42s]
Jobs: 1 (f=1): [R(1)][17.4%][r=106MiB/s][r=105 IOPS][eta 01m:40s]
Jobs: 1 (f=1): [R(1)][19.0%][r=112MiB/s][r=111 IOPS][eta 01m:38s]
Jobs: 1 (f=1): [R(1)][20.7%][r=112MiB/s][r=111 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [R(1)][21.5%][r=109MiB/s][r=108 IOPS][eta 01m:35s]
Jobs: 1 (f=1): [R(1)][22.3%][r=115MiB/s][r=114 IOPS][eta 01m:34s]
Jobs: 1 (f=1): [R(1)][24.0%][r=117MiB/s][r=116 IOPS][eta 01m:32s]
Jobs: 1 (f=1): [R(1)][24.8%][r=113MiB/s][r=112 IOPS][eta 01m:31s]
Jobs: 1 (f=1): [R(1)][26.7%][r=113MiB/s][r=113 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [R(1)][27.3%][r=107MiB/s][r=107 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [R(1)][28.9%][r=106MiB/s][r=106 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [R(1)][30.6%][r=113MiB/s][r=113 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [R(1)][32.2%][r=114MiB/s][r=114 IOPS][eta 01m:22s]
Jobs: 1 (f=1): [R(1)][33.1%][r=107MiB/s][r=106 IOPS][eta 01m:21s]
Jobs: 1 (f=1): [R(1)][34.7%][r=107MiB/s][r=107 IOPS][eta 01m:19s]
Jobs: 1 (f=1): [R(1)][35.8%][r=110MiB/s][r=110 IOPS][eta 01m:17s]
Jobs: 1 (f=1): [R(1)][36.7%][r=114MiB/s][r=113 IOPS][eta 01m:16s]
Jobs: 1 (f=1): [R(1)][37.5%][r=113MiB/s][r=113 IOPS][eta 01m:15s]
Jobs: 1 (f=1): [R(1)][39.2%][r=110MiB/s][r=110 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [R(1)][39.7%][r=113MiB/s][r=113 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [R(1)][40.5%][r=106MiB/s][r=106 IOPS][eta 01m:12s]
Jobs: 1 (f=1): [R(1)][42.1%][r=113MiB/s][r=113 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [R(1)][43.8%][r=114MiB/s][r=114 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [R(1)][45.5%][r=117MiB/s][r=117 IOPS][eta 01m:06s]
Jobs: 1 (f=1): [R(1)][47.1%][r=111MiB/s][r=111 IOPS][eta 01m:04s]
Jobs: 1 (f=1): [R(1)][47.9%][r=113MiB/s][r=112 IOPS][eta 01m:03s]
Jobs: 1 (f=1): [R(1)][49.6%][r=115MiB/s][r=115 IOPS][eta 01m:01s]
Jobs: 1 (f=1): [R(1)][51.2%][r=112MiB/s][r=112 IOPS][eta 00m:59s]
Jobs: 1 (f=1): [R(1)][52.5%][r=112MiB/s][r=111 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [R(1)][53.7%][r=115MiB/s][r=115 IOPS][eta 00m:56s]
Jobs: 1 (f=1): [R(1)][55.8%][r=117MiB/s][r=117 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [R(1)][56.2%][r=112MiB/s][r=112 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [R(1)][57.9%][r=114MiB/s][r=113 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [R(1)][59.5%][r=118MiB/s][r=117 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [R(1)][60.3%][r=111MiB/s][r=111 IOPS][eta 00m:48s]
Jobs: 1 (f=1): [R(1)][62.0%][r=113MiB/s][r=112 IOPS][eta 00m:46s]
Jobs: 1 (f=1): [R(1)][63.6%][r=114MiB/s][r=114 IOPS][eta 00m:44s]
Jobs: 1 (f=1): [R(1)][65.0%][r=113MiB/s][r=112 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [R(1)][65.3%][r=113MiB/s][r=112 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [R(1)][66.9%][r=109MiB/s][r=108 IOPS][eta 00m:40s]
Jobs: 1 (f=1): [R(1)][68.6%][r=112MiB/s][r=111 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][70.2%][r=116MiB/s][r=115 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [R(1)][71.9%][r=118MiB/s][r=118 IOPS][eta 00m:34s]
Jobs: 1 (f=1): [R(1)][72.7%][r=112MiB/s][r=111 IOPS][eta 00m:33s]
Jobs: 1 (f=1): [R(1)][73.6%][r=110MiB/s][r=109 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [R(1)][75.2%][r=107MiB/s][r=106 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [R(1)][77.5%][r=113MiB/s][r=112 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [R(1)][78.5%][r=114MiB/s][r=114 IOPS][eta 00m:26s]
Jobs: 1 (f=1): [R(1)][80.2%][r=117MiB/s][r=117 IOPS][eta 00m:24s]
Jobs: 1 (f=1): [R(1)][81.8%][r=111MiB/s][r=110 IOPS][eta 00m:22s]
Jobs: 1 (f=1): [R(1)][83.5%][r=109MiB/s][r=108 IOPS][eta 00m:20s]
Jobs: 1 (f=1): [R(1)][85.1%][r=112MiB/s][r=112 IOPS][eta 00m:18s]
Jobs: 1 (f=1): [R(1)][86.8%][r=112MiB/s][r=112 IOPS][eta 00m:16s]
Jobs: 1 (f=1): [R(1)][88.4%][r=116MiB/s][r=116 IOPS][eta 00m:14s]
Jobs: 1 (f=1): [R(1)][89.3%][r=112MiB/s][r=111 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [R(1)][90.9%][r=106MiB/s][r=106 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [R(1)][91.7%][r=118MiB/s][r=117 IOPS][eta 00m:10s]
Jobs: 1 (f=1): [R(1)][92.6%][r=112MiB/s][r=111 IOPS][eta 00m:09s]
Jobs: 1 (f=1): [R(1)][93.4%][r=108MiB/s][r=107 IOPS][eta 00m:08s]
Jobs: 1 (f=1): [R(1)][94.2%][r=116MiB/s][r=116 IOPS][eta 00m:07s]
Jobs: 1 (f=1): [R(1)][95.0%][r=113MiB/s][r=113 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [R(1)][96.7%][r=115MiB/s][r=115 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [R(1)][98.3%][r=119MiB/s][r=118 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [R(1)][100.0%][r=109MiB/s][r=108 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=60104: Fri May 31 13:31:43 2024
  read: IOPS=111, BW=112MiB/s (117MB/s)(13.1GiB/120138msec)
    slat (nsec): min=0, max=3580.0k, avg=4477.12, stdev=42551.26
    clat (msec): min=63, max=254, avg=143.00, stdev=15.87
     lat (msec): min=63, max=254, avg=143.01, stdev=15.87
    clat percentiles (msec):
     |  1.00th=[   73],  5.00th=[   90], 10.00th=[  134], 20.00th=[  142],
     | 30.00th=[  142], 40.00th=[  144], 50.00th=[  146], 60.00th=[  153],
     | 70.00th=[  153], 80.00th=[  153], 90.00th=[  153], 95.00th=[  155],
     | 99.00th=[  159], 99.50th=[  161], 99.90th=[  180], 99.95th=[  199],
     | 99.99th=[  251]
   bw (  KiB/s): min=101386, max=131801, per=100.00%, avg=114584.98, stdev=6812.22, samples=238
   iops        : min=   99, max=  128, avg=111.37, stdev= 6.70, samples=238
  lat (msec)   : 100=5.59%, 250=94.40%, 500=0.01%
  cpu          : usr=0.14%, sys=0.16%, ctx=15212, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.2%, 16=52.7%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=97.1%, 8=2.3%, 16=0.6%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=13437,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=112MiB/s (117MB/s), 112MiB/s-112MiB/s (117MB/s-117MB/s), io=13.1GiB (14.1GB), run=120138-120138msec
```

## Throughput test: sequential write

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [W(1)][2.5%][w=101MiB/s][w=101 IOPS][eta 01m:58s]
Jobs: 1 (f=1): [W(1)][4.1%][w=97.0MiB/s][w=97 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [W(1)][5.8%][w=102MiB/s][w=101 IOPS][eta 01m:54s]
Jobs: 1 (f=1): [W(1)][7.4%][w=102MiB/s][w=102 IOPS][eta 01m:52s]
Jobs: 1 (f=1): [W(1)][9.1%][w=102MiB/s][w=101 IOPS][eta 01m:50s]
Jobs: 1 (f=1): [W(1)][9.9%][w=62.9MiB/s][w=62 IOPS][eta 01m:49s]
Jobs: 1 (f=1): [W(1)][11.6%][w=105MiB/s][w=105 IOPS][eta 01m:47s]
Jobs: 1 (f=1): [W(1)][13.2%][eta 01m:45s]
Jobs: 1 (f=1): [W(1)][14.2%][w=97.3MiB/s][w=97 IOPS][eta 01m:43s]
Jobs: 1 (f=1): [W(1)][15.0%][w=103MiB/s][w=103 IOPS][eta 01m:42s]
Jobs: 1 (f=1): [W(1)][17.4%][w=78.9MiB/s][w=78 IOPS][eta 01m:40s]
Jobs: 1 (f=1): [W(1)][18.3%][w=95.1MiB/s][w=95 IOPS][eta 01m:38s]
Jobs: 1 (f=1): [W(1)][20.0%][w=103MiB/s][w=103 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [W(1)][21.5%][w=104MiB/s][w=104 IOPS][eta 01m:35s]
Jobs: 1 (f=1): [W(1)][23.1%][w=102MiB/s][w=101 IOPS][eta 01m:33s]
Jobs: 1 (f=1): [W(1)][24.8%][w=103MiB/s][w=103 IOPS][eta 01m:31s]
Jobs: 1 (f=1): [W(1)][26.7%][w=106MiB/s][w=105 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [W(1)][28.3%][w=88.1MiB/s][w=88 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [W(1)][28.9%][w=98.8MiB/s][w=98 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [W(1)][30.6%][w=102MiB/s][w=101 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [W(1)][32.2%][w=103MiB/s][w=102 IOPS][eta 01m:22s]
Jobs: 1 (f=1): [W(1)][33.9%][w=103MiB/s][w=103 IOPS][eta 01m:20s]
Jobs: 1 (f=1): [W(1)][34.7%][w=106MiB/s][w=105 IOPS][eta 01m:19s]
Jobs: 1 (f=1): [W(1)][36.4%][w=99.9MiB/s][w=99 IOPS][eta 01m:17s]
Jobs: 1 (f=1): [W(1)][38.0%][w=103MiB/s][w=103 IOPS][eta 01m:15s]
Jobs: 1 (f=1): [W(1)][39.2%][w=101MiB/s][w=101 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][40.5%][w=103MiB/s][w=103 IOPS][eta 01m:12s]
Jobs: 1 (f=1): [W(1)][41.3%][w=99.4MiB/s][w=99 IOPS][eta 01m:11s]
Jobs: 1 (f=1): [W(1)][42.1%][w=106MiB/s][w=106 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [W(1)][43.0%][w=103MiB/s][w=103 IOPS][eta 01m:09s]
Jobs: 1 (f=1): [W(1)][43.8%][w=103MiB/s][w=103 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [W(1)][44.6%][w=104MiB/s][w=103 IOPS][eta 01m:07s]
Jobs: 1 (f=1): [W(1)][45.5%][w=103MiB/s][w=102 IOPS][eta 01m:06s]
Jobs: 1 (f=1): [W(1)][47.1%][w=105MiB/s][w=105 IOPS][eta 01m:04s]
Jobs: 1 (f=1): [W(1)][48.8%][w=102MiB/s][w=101 IOPS][eta 01m:02s]
Jobs: 1 (f=1): [W(1)][49.6%][w=105MiB/s][w=104 IOPS][eta 01m:01s]
Jobs: 1 (f=1): [W(1)][51.2%][w=104MiB/s][w=103 IOPS][eta 00m:59s]
Jobs: 1 (f=1): [W(1)][52.9%][w=51.0MiB/s][w=51 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [W(1)][54.5%][w=107MiB/s][w=106 IOPS][eta 00m:55s]
Jobs: 1 (f=1): [W(1)][56.2%][w=105MiB/s][w=105 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [W(1)][57.9%][w=105MiB/s][w=105 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [W(1)][59.2%][w=105MiB/s][w=104 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [W(1)][60.3%][w=104MiB/s][w=104 IOPS][eta 00m:48s]
Jobs: 1 (f=1): [W(1)][61.2%][w=108MiB/s][w=107 IOPS][eta 00m:47s]
Jobs: 1 (f=1): [W(1)][62.8%][w=105MiB/s][w=105 IOPS][eta 00m:45s]
Jobs: 1 (f=1): [W(1)][63.6%][w=19.0MiB/s][w=18 IOPS][eta 00m:44s]
Jobs: 1 (f=1): [W(1)][65.0%][w=99.9MiB/s][w=99 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][65.3%][w=103MiB/s][w=102 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][66.9%][w=105MiB/s][w=105 IOPS][eta 00m:40s]
Jobs: 1 (f=1): [W(1)][68.3%][w=105MiB/s][w=104 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [W(1)][69.4%][w=105MiB/s][w=105 IOPS][eta 00m:37s]
Jobs: 1 (f=1): [W(1)][70.2%][w=105MiB/s][w=104 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [W(1)][71.9%][w=67.8MiB/s][w=67 IOPS][eta 00m:34s]
Jobs: 1 (f=1): [W(1)][73.6%][w=103MiB/s][w=103 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [W(1)][75.2%][w=103MiB/s][w=103 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [W(1)][77.5%][w=103MiB/s][w=102 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [W(1)][78.5%][w=89.9MiB/s][w=89 IOPS][eta 00m:26s]
Jobs: 1 (f=1): [W(1)][80.2%][w=102MiB/s][w=101 IOPS][eta 00m:24s]
Jobs: 1 (f=1): [W(1)][81.8%][w=104MiB/s][w=104 IOPS][eta 00m:22s]
Jobs: 1 (f=1): [W(1)][82.6%][w=107MiB/s][w=106 IOPS][eta 00m:21s]
Jobs: 1 (f=1): [W(1)][84.3%][w=104MiB/s][w=103 IOPS][eta 00m:19s]
Jobs: 1 (f=1): [W(1)][86.0%][w=102MiB/s][w=101 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [W(1)][87.6%][w=104MiB/s][w=103 IOPS][eta 00m:15s]
Jobs: 1 (f=1): [W(1)][89.3%][w=47.1MiB/s][w=47 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [W(1)][90.1%][w=96.6MiB/s][w=96 IOPS][eta 00m:12s]
Jobs: 1 (f=1): [W(1)][91.7%][w=97.1MiB/s][w=97 IOPS][eta 00m:10s]
Jobs: 1 (f=1): [W(1)][93.4%][w=105MiB/s][w=105 IOPS][eta 00m:08s]
Jobs: 1 (f=1): [W(1)][95.0%][w=102MiB/s][w=102 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [W(1)][95.9%][w=107MiB/s][w=107 IOPS][eta 00m:05s]
Jobs: 1 (f=1): [W(1)][96.7%][w=102MiB/s][w=101 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [W(1)][97.5%][w=108MiB/s][w=107 IOPS][eta 00m:03s]
Jobs: 1 (f=1): [W(1)][98.3%][w=82.7MiB/s][w=82 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [W(1)][99.2%][w=102MiB/s][w=102 IOPS][eta 00m:01s]
Jobs: 1 (f=1): [W(1)][100.0%][w=42.0MiB/s][w=42 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=60196: Fri May 31 13:33:43 2024
  write: IOPS=92, BW=92.1MiB/s (96.5MB/s)(10.8GiB/120263msec); 0 zone resets
    slat (nsec): min=1000, max=46444k, avg=33955.47, stdev=476186.82
    clat (msec): min=61, max=3233, avg=173.67, stdev=160.05
     lat (msec): min=61, max=3233, avg=173.70, stdev=160.05
    clat percentiles (msec):
     |  1.00th=[   95],  5.00th=[  109], 10.00th=[  117], 20.00th=[  126],
     | 30.00th=[  134], 40.00th=[  138], 50.00th=[  144], 60.00th=[  153],
     | 70.00th=[  163], 80.00th=[  180], 90.00th=[  215], 95.00th=[  266],
     | 99.00th=[  969], 99.50th=[ 1267], 99.90th=[ 2869], 99.95th=[ 2903],
     | 99.99th=[ 3037]
   bw (  KiB/s): min= 6071, max=117607, per=100.00%, avg=99081.84, stdev=21335.15, samples=227
   iops        : min=    5, max=  114, avg=96.22, stdev=20.87, samples=227
  lat (msec)   : 100=2.35%, 250=91.52%, 500=3.96%, 750=0.85%, 1000=0.50%
  lat (msec)   : 2000=0.69%, >=2000=0.14%
  cpu          : usr=0.38%, sys=0.14%, ctx=13435, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.1%, 16=52.8%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.0%, 8=1.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,11072,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=92.1MiB/s (96.5MB/s), 92.1MiB/s-92.1MiB/s (96.5MB/s-96.5MB/s), io=10.8GiB (11.6GB), run=120263-120263msec
```
