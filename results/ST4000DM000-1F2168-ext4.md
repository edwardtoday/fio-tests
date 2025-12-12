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
Jobs: 4 (f=4): [m(4)][3.3%][r=1044KiB/s,w=1084KiB/s][r=261,w=271 IOPS][eta 01m:57s]
Jobs: 4 (f=4): [m(4)][4.1%][r=3740KiB/s,w=4000KiB/s][r=935,w=1000 IOPS][eta 01m:Jobs: 4 (f=4): [m(4)][5.0%][r=5534KiB/s,w=5730KiB/s][r=1383,w=1432 IOPS][eta 01m:55s]
Jobs: 4 (f=4): [m(4)][5.8%][r=894KiB/s,w=914KiB/s][r=223,w=228 IOPS][eta 01m:54sJobs: 4 (f=4): [m(4)][6.6%][r=1370KiB/s,w=1531KiB/s][r=342,w=382 IOPS][eta 01m:53s]
Jobs: 4 (f=4): [m(4)][7.4%][r=5998KiB/s,w=6057KiB/s][r=1499,w=1514 IOPS][eta 01m:52s]
Jobs: 4 (f=4): [m(4)][9.1%][r=355KiB/s,w=431KiB/s][r=88,w=107 IOPS][eta 01m:50s]
Jobs: 4 (f=4): [m(4)][10.7%][eta 01m:48s]
Jobs: 4 (f=4): [m(4)][11.6%][r=1467KiB/s,w=1503KiB/s][r=366,w=375 IOPS][eta 01m:47s]
Jobs: 4 (f=4): [m(4)][13.2%][r=2954KiB/s,w=3083KiB/s][r=738,w=770 IOPS][eta 01m:45s]
Jobs: 4 (f=4): [m(4)][14.9%][r=5488KiB/s,w=5576KiB/s][r=1372,w=1394 IOPS][eta 01m:43s]
Jobs: 4 (f=4): [m(4)][15.7%][r=4598KiB/s,w=4638KiB/s][r=1149,w=1159 IOPS][eta 01m:42s]
Jobs: 4 (f=4): [m(4)][17.4%][r=15KiB/s,w=15KiB/s][r=3,w=3 IOPS][eta 01m:40s]
Jobs: 4 (f=4): [m(4)][19.0%][r=4KiB/s,w=4KiB/s][r=1,w=1 IOPS][eta 01m:38s]
Jobs: 4 (f=4): [m(4)][20.7%][eta 01m:36s]
Jobs: 4 (f=4): [m(4)][22.3%][eta 01m:34s]
Jobs: 4 (f=4): [m(4)][24.0%][r=3726KiB/s,w=3734KiB/s][r=931,w=933 IOPS][eta 01m:32s]
Jobs: 4 (f=4): [m(4)][24.8%][r=5882KiB/s,w=6017KiB/s][r=1470,w=1504 IOPS][eta 01m:31s]
Jobs: 4 (f=4): [m(4)][26.4%][r=2076KiB/s,w=2000KiB/s][r=519,w=500 IOPS][eta 01m:29s]
Jobs: 4 (f=4): [m(4)][28.1%][eta 01m:27s]
Jobs: 4 (f=4): [m(4)][28.9%][r=2833KiB/s,w=2789KiB/s][r=708,w=697 IOPS][eta 01m:26s]
Jobs: 4 (f=4): [m(4)][30.6%][r=3KiB/s][r=0 IOPS][eta 01m:24s]
Jobs: 4 (f=4): [m(4)][31.4%][r=1530KiB/s,w=1474KiB/s][r=382,w=368 IOPS][eta 01m:23s]
Jobs: 4 (f=4): [m(4)][33.1%][r=5153KiB/s,w=4968KiB/s][r=1288,w=1242 IOPS][eta 01m:21s]
Jobs: 4 (f=4): [m(4)][34.7%][r=1536KiB/s,w=1437KiB/s][r=384,w=359 IOPS][eta 01m:19s]
Jobs: 4 (f=4): [m(4)][35.5%][r=6585KiB/s,w=6529KiB/s][r=1646,w=1632 IOPS][eta 01m:18s]
Jobs: 4 (f=4): [m(4)][37.2%][r=1484KiB/s,w=1480KiB/s][r=371,w=370 IOPS][eta 01m:16s]
Jobs: 4 (f=4): [m(4)][38.0%][r=1790KiB/s,w=1842KiB/s][r=447,w=460 IOPS][eta 01m:15s]
Jobs: 4 (f=4): [m(4)][39.7%][eta 01m:13s]
Jobs: 4 (f=4): [m(4)][41.3%][r=1813KiB/s,w=1980KiB/s][r=453,w=495 IOPS][eta 01m:11s]
Jobs: 4 (f=4): [m(4)][42.1%][eta 01m:10s]
Jobs: 4 (f=4): [m(4)][43.0%][r=4691KiB/s,w=4419KiB/s][r=1172,w=1104 IOPS][eta 01m:09s]
Jobs: 4 (f=4): [m(4)][43.8%][eta 01m:08s]
Jobs: 4 (f=4): [m(4)][44.6%][eta 01m:07s]
Jobs: 4 (f=4): [m(4)][45.5%][r=5958KiB/s,w=6069KiB/s][r=1489,w=1517 IOPS][eta 01m:06s]
Jobs: 4 (f=4): [m(4)][46.3%][r=6866KiB/s,w=6763KiB/s][r=1716,w=1690 IOPS][eta 01m:05s]
Jobs: 4 (f=4): [m(4)][47.1%][r=5934KiB/s,w=5958KiB/s][r=1483,w=1489 IOPS][eta 01m:04s]
Jobs: 4 (f=4): [m(4)][47.9%][r=7082KiB/s,w=6636KiB/s][r=1770,w=1659 IOPS][eta 01m:03s]
Jobs: 4 (f=4): [m(4)][48.8%][r=6316KiB/s,w=6476KiB/s][r=1579,w=1619 IOPS][eta 01m:02s]
Jobs: 4 (f=4): [m(4)][50.4%][r=1871KiB/s,w=1783KiB/s][r=467,w=445 IOPS][eta 01m:00s]
Jobs: 4 (f=4): [m(4)][52.1%][eta 00m:58s]
Jobs: 4 (f=4): [m(4)][53.7%][r=5496KiB/s,w=5648KiB/s][r=1374,w=1412 IOPS][eta 00m:56s]
Jobs: 4 (f=4): [m(4)][54.5%][r=4000KiB/s,w=4047KiB/s][r=1000,w=1011 IOPS][eta 00m:55s]
Jobs: 4 (f=4): [m(4)][56.2%][eta 00m:53s]
Jobs: 4 (f=4): [m(4)][57.0%][r=251KiB/s,w=247KiB/s][r=62,w=61 IOPS][eta 00m:52s]
Jobs: 4 (f=4): [m(4)][58.7%][eta 00m:50s]
Jobs: 4 (f=4): [m(4)][60.3%][eta 00m:48s]
Jobs: 4 (f=4): [m(4)][62.0%][r=1141KiB/s,w=1249KiB/s][r=285,w=312 IOPS][eta 00m:46s]
Jobs: 4 (f=4): [m(4)][63.6%][r=2124KiB/s,w=2252KiB/s][r=531,w=563 IOPS][eta 00m:44s]
Jobs: 4 (f=4): [m(4)][65.3%][eta 00m:42s]
Jobs: 4 (f=4): [m(4)][66.9%][r=6452KiB/s,w=6512KiB/s][r=1613,w=1628 IOPS][eta 00m:40s]
Jobs: 4 (f=4): [m(4)][67.8%][r=6585KiB/s,w=6561KiB/s][r=1646,w=1640 IOPS][eta 00m:39s]
Jobs: 4 (f=4): [m(4)][69.4%][eta 00m:37s]
Jobs: 4 (f=4): [m(4)][70.2%][eta 00m:36s]
Jobs: 4 (f=4): [m(4)][71.1%][eta 00m:35s]
Jobs: 4 (f=4): [m(4)][72.7%][eta 00m:33s]
Jobs: 4 (f=4): [m(4)][74.4%][eta 00m:31s]
Jobs: 4 (f=4): [m(4)][76.0%][r=2873KiB/s,w=3072KiB/s][r=718,w=768 IOPS][eta 00m:29s]
Jobs: 4 (f=4): [m(4)][77.7%][eta 00m:27s]
Jobs: 4 (f=4): [m(4)][79.3%][eta 00m:25s]
Jobs: 4 (f=4): [m(4)][81.0%][r=1555KiB/s,w=1411KiB/s][r=388,w=352 IOPS][eta 00m:23s]
Jobs: 4 (f=4): [m(4)][82.6%][r=2585KiB/s,w=2693KiB/s][r=646,w=673 IOPS][eta 00m:21s]
Jobs: 4 (f=4): [m(4)][84.3%][eta 00m:19s]
Jobs: 4 (f=4): [m(4)][86.0%][eta 00m:17s]
Jobs: 4 (f=4): [m(4)][87.6%][r=1176KiB/s,w=1220KiB/s][r=294,w=305 IOPS][eta 00m:15s]
Jobs: 4 (f=4): [m(4)][88.4%][eta 00m:14s]
Jobs: 4 (f=4): [m(4)][90.1%][r=3570KiB/s,w=3566KiB/s][r=892,w=891 IOPS][eta 00m:12s]
Jobs: 4 (f=4): [m(4)][90.9%][eta 00m:11s]
Jobs: 4 (f=4): [m(4)][91.7%][r=2376KiB/s,w=2400KiB/s][r=594,w=600 IOPS][eta 00m:10s]
Jobs: 4 (f=4): [m(4)][93.4%][eta 00m:08s]
Jobs: 4 (f=4): [m(4)][95.0%][r=4023KiB/s,w=4290KiB/s][r=1005,w=1072 IOPS][eta 00m:06s]
Jobs: 4 (f=4): [m(4)][96.7%][r=596KiB/s,w=504KiB/s][r=149,w=126 IOPS][eta 00m:04s]
Jobs: 4 (f=4): [m(4)][97.5%][r=506KiB/s,w=550KiB/s][r=126,w=137 IOPS][eta 00m:03s]
Jobs: 4 (f=4): [m(4)][99.2%][r=2984KiB/s,w=2944KiB/s][r=746,w=736 IOPS][eta 00m:01s]
Jobs: 4 (f=4): [m(4)][100.0%][r=3920KiB/s,w=3916KiB/s][r=980,w=979 IOPS][eta 00m:00s]
iops-test-job: (groupid=0, jobs=4): err= 0: pid=50546: Fri May 31 10:30:07 2024
  read: IOPS=516, BW=2066KiB/s (2116kB/s)(242MiB/120019msec)
    slat (nsec): min=0, max=64824k, avg=4779.19, stdev=367327.77
    clat (usec): min=67, max=8452.2k, avg=61786.87, stdev=382627.76
     lat (usec): min=461, max=8452.2k, avg=61791.65, stdev=382627.58
    clat percentiles (msec):
     |  1.00th=[   14],  5.00th=[   16], 10.00th=[   17], 20.00th=[   18],
     | 30.00th=[   19], 40.00th=[   20], 50.00th=[   21], 60.00th=[   22],
     | 70.00th=[   23], 80.00th=[   24], 90.00th=[   27], 95.00th=[   30],
     | 99.00th=[ 1737], 99.50th=[ 2022], 99.90th=[ 5940], 99.95th=[ 6611],
     | 99.99th=[ 8423]
   bw (  KiB/s): min=   60, max= 7381, per=100.00%, avg=4333.84, stdev=512.33, samples=454
   iops        : min=   12, max= 1845, avg=1082.11, stdev=128.11, samples=454
  write: IOPS=519, BW=2079KiB/s (2128kB/s)(244MiB/120019msec); 0 zone resets
    slat (nsec): min=0, max=24855k, avg=3188.02, stdev=107983.47
    clat (usec): min=12, max=8451.1k, avg=61650.81, stdev=385123.57
     lat (usec): min=1032, max=8451.1k, avg=61654.00, stdev=385123.45
    clat percentiles (msec):
     |  1.00th=[   14],  5.00th=[   16], 10.00th=[   17], 20.00th=[   18],
     | 30.00th=[   19], 40.00th=[   20], 50.00th=[   21], 60.00th=[   22],
     | 70.00th=[   22], 80.00th=[   24], 90.00th=[   26], 95.00th=[   29],
     | 99.00th=[ 1737], 99.50th=[ 2022], 99.90th=[ 6611], 99.95th=[ 8356],
     | 99.99th=[ 8423]
   bw (  KiB/s): min=  100, max= 7295, per=100.00%, avg=4368.34, stdev=511.68, samples=453
   iops        : min=   22, max= 1823, avg=1090.80, stdev=127.94, samples=453
  lat (usec)   : 20=0.01%, 100=0.01%, 500=0.01%, 750=0.01%
  lat (msec)   : 2=0.01%, 4=0.04%, 10=0.24%, 20=45.33%, 50=51.87%
  lat (msec)   : 100=0.19%, 250=0.36%, 500=0.41%, 750=0.05%, 1000=0.01%
  lat (msec)   : 2000=0.73%, >=2000=0.76%
  cpu          : usr=0.24%, sys=0.29%, ctx=115985, majf=2, minf=45
  IO depths    : 1=0.1%, 2=0.1%, 4=0.3%, 8=51.5%, 16=48.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.4%, 8=1.5%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=62003,62365,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=2066KiB/s (2116kB/s), 2066KiB/s-2066KiB/s (2116kB/s-2116kB/s), io=242MiB (254MB), run=120019-120019msec
  WRITE: bw=2079KiB/s (2128kB/s), 2079KiB/s-2079KiB/s (2128kB/s-2128kB/s), io=244MiB (255MB), run=120019-120019msec
```

## Throughput test: sequential read

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [R(1)][2.5%][r=107MiB/s][r=106 IOPS][eta 01m:58s]
Jobs: 1 (f=1): [R(1)][4.1%][r=103MiB/s][r=102 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [R(1)][5.8%][r=103MiB/s][r=103 IOPS][eta 01m:54s]
Jobs: 1 (f=1): [R(1)][6.6%][r=119MiB/s][r=118 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [R(1)][8.3%][r=108MiB/s][r=108 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [R(1)][9.2%][r=105MiB/s][r=105 IOPS][eta 01m:49s]
Jobs: 1 (f=1): [R(1)][10.7%][r=119MiB/s][r=118 IOPS][eta 01m:48s]
Jobs: 1 (f=1): [R(1)][11.6%][r=111MiB/s][r=110 IOPS][eta 01m:47s]
Jobs: 1 (f=1): [R(1)][12.5%][r=114MiB/s][r=114 IOPS][eta 01m:45s]
Jobs: 1 (f=1): [R(1)][14.0%][r=107MiB/s][r=106 IOPS][eta 01m:44s]
Jobs: 1 (f=1): [R(1)][15.0%][r=104MiB/s][r=104 IOPS][eta 01m:42s]
Jobs: 1 (f=1): [R(1)][16.5%][r=119MiB/s][r=118 IOPS][eta 01m:41s]
Jobs: 1 (f=1): [R(1)][18.2%][r=108MiB/s][r=108 IOPS][eta 01m:39s]
Jobs: 1 (f=1): [R(1)][19.0%][r=111MiB/s][r=111 IOPS][eta 01m:38s]
Jobs: 1 (f=1): [R(1)][20.0%][r=108MiB/s][r=107 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [R(1)][21.5%][r=105MiB/s][r=104 IOPS][eta 01m:35s]
Jobs: 1 (f=1): [R(1)][23.1%][r=104MiB/s][r=103 IOPS][eta 01m:33s]
Jobs: 1 (f=1): [R(1)][24.8%][r=114MiB/s][r=114 IOPS][eta 01m:31s]
Jobs: 1 (f=1): [R(1)][26.7%][r=115MiB/s][r=115 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [R(1)][28.3%][r=116MiB/s][r=116 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [R(1)][30.0%][r=110MiB/s][r=109 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [R(1)][31.4%][r=106MiB/s][r=106 IOPS][eta 01m:23s]
Jobs: 1 (f=1): [R(1)][33.1%][r=106MiB/s][r=106 IOPS][eta 01m:21s]
Jobs: 1 (f=1): [R(1)][33.9%][r=116MiB/s][r=115 IOPS][eta 01m:20s]
Jobs: 1 (f=1): [R(1)][34.7%][r=113MiB/s][r=112 IOPS][eta 01m:19s]
Jobs: 1 (f=1): [R(1)][36.4%][r=113MiB/s][r=113 IOPS][eta 01m:17s]
Jobs: 1 (f=1): [R(1)][38.0%][r=116MiB/s][r=115 IOPS][eta 01m:15s]
Jobs: 1 (f=1): [R(1)][39.7%][r=111MiB/s][r=111 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [R(1)][40.5%][r=113MiB/s][r=112 IOPS][eta 01m:12s]
Jobs: 1 (f=1): [R(1)][41.7%][r=116MiB/s][r=116 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [R(1)][42.5%][r=109MiB/s][r=109 IOPS][eta 01m:09s]
Jobs: 1 (f=1): [R(1)][43.3%][r=115MiB/s][r=114 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [R(1)][44.6%][r=112MiB/s][r=111 IOPS][eta 01m:07s]
Jobs: 1 (f=1): [R(1)][45.5%][r=111MiB/s][r=110 IOPS][eta 01m:06s]
Jobs: 1 (f=1): [R(1)][46.3%][r=114MiB/s][r=113 IOPS][eta 01m:05s]
Jobs: 1 (f=1): [R(1)][47.1%][r=107MiB/s][r=106 IOPS][eta 01m:04s]
Jobs: 1 (f=1): [R(1)][48.8%][r=112MiB/s][r=112 IOPS][eta 01m:02s]
Jobs: 1 (f=1): [R(1)][49.6%][r=111MiB/s][r=110 IOPS][eta 01m:01s]
Jobs: 1 (f=1): [R(1)][51.2%][r=107MiB/s][r=107 IOPS][eta 00m:59s]
Jobs: 1 (f=1): [R(1)][52.5%][r=117MiB/s][r=116 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [R(1)][53.7%][r=108MiB/s][r=108 IOPS][eta 00m:56s]
Jobs: 1 (f=1): [R(1)][54.5%][r=111MiB/s][r=110 IOPS][eta 00m:55s]
Jobs: 1 (f=1): [R(1)][55.8%][r=113MiB/s][r=112 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [R(1)][57.0%][r=108MiB/s][r=108 IOPS][eta 00m:52s]
Jobs: 1 (f=1): [R(1)][59.2%][r=112MiB/s][r=112 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [R(1)][59.5%][r=113MiB/s][r=112 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [R(1)][61.2%][r=113MiB/s][r=112 IOPS][eta 00m:47s]
Jobs: 1 (f=1): [R(1)][62.8%][r=112MiB/s][r=111 IOPS][eta 00m:45s]
Jobs: 1 (f=1): [R(1)][65.0%][r=110MiB/s][r=109 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [R(1)][66.1%][r=112MiB/s][r=112 IOPS][eta 00m:41s]
Jobs: 1 (f=1): [R(1)][68.3%][r=115MiB/s][r=115 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][68.6%][r=106MiB/s][r=105 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][70.2%][r=112MiB/s][r=112 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [R(1)][71.9%][r=114MiB/s][r=114 IOPS][eta 00m:34s]
Jobs: 1 (f=1): [R(1)][73.6%][r=117MiB/s][r=117 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [R(1)][75.2%][r=119MiB/s][r=119 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [R(1)][76.0%][r=113MiB/s][r=112 IOPS][eta 00m:29s]
Jobs: 1 (f=1): [R(1)][77.7%][r=115MiB/s][r=115 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [R(1)][79.3%][r=119MiB/s][r=119 IOPS][eta 00m:25s]
Jobs: 1 (f=1): [R(1)][80.2%][r=113MiB/s][r=112 IOPS][eta 00m:24s]
Jobs: 1 (f=1): [R(1)][81.8%][r=115MiB/s][r=115 IOPS][eta 00m:22s]
Jobs: 1 (f=1): [R(1)][83.5%][r=119MiB/s][r=119 IOPS][eta 00m:20s]
Jobs: 1 (f=1): [R(1)][84.3%][r=112MiB/s][r=111 IOPS][eta 00m:19s]
Jobs: 1 (f=1): [R(1)][86.0%][r=115MiB/s][r=115 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [R(1)][87.6%][r=112MiB/s][r=111 IOPS][eta 00m:15s]
Jobs: 1 (f=1): [R(1)][89.3%][r=115MiB/s][r=114 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [R(1)][90.9%][r=117MiB/s][r=116 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [R(1)][92.6%][r=119MiB/s][r=118 IOPS][eta 00m:09s]
Jobs: 1 (f=1): [R(1)][94.2%][r=108MiB/s][r=108 IOPS][eta 00m:07s]
Jobs: 1 (f=1): [R(1)][95.9%][r=112MiB/s][r=112 IOPS][eta 00m:05s]
Jobs: 1 (f=1): [R(1)][97.5%][r=112MiB/s][r=111 IOPS][eta 00m:03s]
Jobs: 1 (f=1): [R(1)][99.2%][r=116MiB/s][r=115 IOPS][eta 00m:01s]
Jobs: 1 (f=1): [R(1)][100.0%][r=109MiB/s][r=109 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=51029: Fri May 31 10:39:02 2024
  read: IOPS=111, BW=112MiB/s (117MB/s)(13.1GiB/120139msec)
    slat (nsec): min=0, max=2679.0k, avg=3417.28, stdev=27073.64
    clat (msec): min=22, max=241, avg=143.28, stdev=17.52
     lat (msec): min=22, max=241, avg=143.29, stdev=17.52
    clat percentiles (msec):
     |  1.00th=[   72],  5.00th=[   99], 10.00th=[  134], 20.00th=[  142],
     | 30.00th=[  144], 40.00th=[  144], 50.00th=[  144], 60.00th=[  153],
     | 70.00th=[  153], 80.00th=[  153], 90.00th=[  153], 95.00th=[  153],
     | 99.00th=[  163], 99.50th=[  188], 99.90th=[  232], 99.95th=[  236],
     | 99.99th=[  241]
   bw (  KiB/s): min=69216, max=132063, per=100.00%, avg=114408.87, stdev=8079.56, samples=238
   iops        : min=   67, max=  128, avg=111.22, stdev= 7.90, samples=238
  lat (msec)   : 50=0.03%, 100=5.19%, 250=94.78%
  cpu          : usr=0.12%, sys=0.15%, ctx=14392, majf=0, minf=11
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.2%, 16=52.7%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=96.8%, 8=2.5%, 16=0.7%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=13413,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=112MiB/s (117MB/s), 112MiB/s-112MiB/s (117MB/s-117MB/s), io=13.1GiB (14.1GB), run=120139-120139msec
```

## Throughput test: sequential write

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [W(1)][3.3%][w=106MiB/s][w=106 IOPS][eta 01m:57s]
Jobs: 1 (f=1): [W(1)][4.1%][w=106MiB/s][w=105 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [W(1)][5.0%][w=103MiB/s][w=103 IOPS][eta 01m:54s]
Jobs: 1 (f=1): [W(1)][5.8%][w=101MiB/s][w=100 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [W(1)][8.3%][w=107MiB/s][w=106 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [W(1)][9.1%][w=105MiB/s][w=104 IOPS][eta 01m:50s]
Jobs: 1 (f=1): [W(1)][10.0%][w=104MiB/s][w=104 IOPS][eta 01m:48s]
Jobs: 1 (f=1): [W(1)][11.6%][w=104MiB/s][w=103 IOPS][eta 01m:47s]
Jobs: 1 (f=1): [W(1)][12.5%][w=106MiB/s][w=106 IOPS][eta 01m:45s]
Jobs: 1 (f=1): [W(1)][14.0%][w=106MiB/s][w=105 IOPS][eta 01m:44s]
Jobs: 1 (f=1): [W(1)][14.9%][w=105MiB/s][w=104 IOPS][eta 01m:43s]
Jobs: 1 (f=1): [W(1)][16.5%][w=105MiB/s][w=105 IOPS][eta 01m:41s]
Jobs: 1 (f=1): [W(1)][18.2%][w=103MiB/s][w=102 IOPS][eta 01m:39s]
Jobs: 1 (f=1): [W(1)][20.0%][w=103MiB/s][w=103 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [W(1)][21.5%][w=106MiB/s][w=105 IOPS][eta 01m:35s]
Jobs: 1 (f=1): [W(1)][22.3%][w=102MiB/s][w=101 IOPS][eta 01m:34s]
Jobs: 1 (f=1): [W(1)][24.0%][w=103MiB/s][w=103 IOPS][eta 01m:32s]
Jobs: 1 (f=1): [W(1)][25.6%][w=102MiB/s][w=102 IOPS][eta 01m:30s]
Jobs: 1 (f=1): [W(1)][26.7%][w=107MiB/s][w=106 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [W(1)][28.3%][w=106MiB/s][w=106 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [W(1)][30.0%][w=109MiB/s][w=108 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [W(1)][31.4%][eta 01m:23s]
Jobs: 1 (f=1): [W(1)][33.1%][w=106MiB/s][w=106 IOPS][eta 01m:21s]
Jobs: 1 (f=1): [W(1)][33.9%][w=103MiB/s][w=102 IOPS][eta 01m:20s]
Jobs: 1 (f=1): [W(1)][34.7%][w=101MiB/s][w=100 IOPS][eta 01m:19s]
Jobs: 1 (f=1): [W(1)][36.4%][w=102MiB/s][w=102 IOPS][eta 01m:17s]
Jobs: 1 (f=1): [W(1)][38.0%][w=106MiB/s][w=105 IOPS][eta 01m:15s]
Jobs: 1 (f=1): [W(1)][39.2%][w=100MiB/s][w=100 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][40.0%][w=103MiB/s][w=103 IOPS][eta 01m:12s]
Jobs: 1 (f=1): [W(1)][40.8%][w=105MiB/s][w=104 IOPS][eta 01m:11s]
Jobs: 1 (f=1): [W(1)][41.7%][w=102MiB/s][w=101 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [W(1)][43.0%][w=102MiB/s][w=101 IOPS][eta 01m:09s]
Jobs: 1 (f=1): [W(1)][43.8%][w=105MiB/s][w=105 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [W(1)][44.6%][w=103MiB/s][w=102 IOPS][eta 01m:07s]
Jobs: 1 (f=1): [W(1)][46.3%][w=103MiB/s][w=102 IOPS][eta 01m:05s]
Jobs: 1 (f=1): [W(1)][47.9%][w=106MiB/s][w=106 IOPS][eta 01m:03s]
Jobs: 1 (f=1): [W(1)][49.6%][w=106MiB/s][w=106 IOPS][eta 01m:01s]
Jobs: 1 (f=1): [W(1)][51.2%][w=105MiB/s][w=105 IOPS][eta 00m:59s]
Jobs: 1 (f=1): [W(1)][52.9%][w=107MiB/s][w=107 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [W(1)][54.5%][w=105MiB/s][w=104 IOPS][eta 00m:55s]
Jobs: 1 (f=1): [W(1)][56.2%][w=104MiB/s][w=104 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [W(1)][57.9%][w=106MiB/s][w=106 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [W(1)][59.2%][w=105MiB/s][w=104 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [W(1)][60.3%][eta 00m:48s]
Jobs: 1 (f=1): [W(1)][62.0%][eta 00m:46s]
Jobs: 1 (f=1): [W(1)][63.6%][w=105MiB/s][w=104 IOPS][eta 00m:44s]
Jobs: 1 (f=1): [W(1)][65.0%][w=67.8MiB/s][w=67 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][65.3%][w=105MiB/s][w=104 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][66.9%][w=105MiB/s][w=105 IOPS][eta 00m:40s]
Jobs: 1 (f=1): [W(1)][68.6%][w=103MiB/s][w=103 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [W(1)][69.4%][w=101MiB/s][w=100 IOPS][eta 00m:37s]
Jobs: 1 (f=1): [W(1)][71.1%][w=106MiB/s][w=106 IOPS][eta 00m:35s]
Jobs: 1 (f=1): [W(1)][72.7%][w=103MiB/s][w=103 IOPS][eta 00m:33s]
Jobs: 1 (f=1): [W(1)][73.6%][w=106MiB/s][w=105 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [W(1)][75.2%][w=104MiB/s][w=103 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [W(1)][77.5%][w=105MiB/s][w=105 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [W(1)][78.5%][w=104MiB/s][w=103 IOPS][eta 00m:26s]
Jobs: 1 (f=1): [W(1)][80.2%][w=99.2MiB/s][w=99 IOPS][eta 00m:24s]
Jobs: 1 (f=1): [W(1)][81.0%][w=109MiB/s][w=108 IOPS][eta 00m:23s]
Jobs: 1 (f=1): [W(1)][82.6%][w=104MiB/s][w=104 IOPS][eta 00m:21s]
Jobs: 1 (f=1): [W(1)][83.5%][w=106MiB/s][w=105 IOPS][eta 00m:20s]
Jobs: 1 (f=1): [W(1)][85.1%][w=103MiB/s][w=102 IOPS][eta 00m:18s]
Jobs: 1 (f=1): [W(1)][86.8%][w=109MiB/s][w=108 IOPS][eta 00m:16s]
Jobs: 1 (f=1): [W(1)][88.4%][w=105MiB/s][w=105 IOPS][eta 00m:14s]
Jobs: 1 (f=1): [W(1)][89.3%][w=105MiB/s][w=104 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [W(1)][90.9%][w=105MiB/s][w=105 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [W(1)][91.7%][w=106MiB/s][w=105 IOPS][eta 00m:10s]
Jobs: 1 (f=1): [W(1)][92.6%][w=105MiB/s][w=104 IOPS][eta 00m:09s]
Jobs: 1 (f=1): [W(1)][94.2%][w=105MiB/s][w=104 IOPS][eta 00m:07s]
Jobs: 1 (f=1): [W(1)][95.0%][w=106MiB/s][w=106 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [W(1)][95.8%][w=106MiB/s][w=105 IOPS][eta 00m:05s]
Jobs: 1 (f=1): [W(1)][96.7%][w=101MiB/s][w=100 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [W(1)][97.5%][eta 00m:03s]
Jobs: 1 (f=1): [W(1)][98.3%][eta 00m:02s]
Jobs: 1 (f=1): [W(1)][99.2%][w=59.8MiB/s][w=59 IOPS][eta 00m:01s]
Jobs: 1 (f=1): [W(1)][100.0%][w=107MiB/s][w=106 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=51225: Fri May 31 10:41:43 2024
  write: IOPS=97, BW=97.3MiB/s (102MB/s)(11.4GiB/120143msec); 0 zone resets
    slat (nsec): min=0, max=78942k, avg=32398.56, stdev=757659.28
    clat (msec): min=56, max=4899, avg=164.31, stdev=190.09
     lat (msec): min=56, max=4899, avg=164.34, stdev=190.09
    clat percentiles (msec):
     |  1.00th=[   94],  5.00th=[  106], 10.00th=[  114], 20.00th=[  124],
     | 30.00th=[  132], 40.00th=[  133], 50.00th=[  142], 60.00th=[  142],
     | 70.00th=[  146], 80.00th=[  161], 90.00th=[  194], 95.00th=[  266],
     | 99.00th=[  542], 99.50th=[  793], 99.90th=[ 3775], 99.95th=[ 3809],
     | 99.99th=[ 4044]
   bw (  KiB/s): min=10178, max=119873, per=100.00%, avg=105028.26, stdev=12950.26, samples=226
   iops        : min=    9, max=  117, avg=102.03, stdev=12.69, samples=226
  lat (msec)   : 100=2.27%, 250=92.18%, 500=4.24%, 750=0.77%, 1000=0.08%
  lat (msec)   : 2000=0.16%, >=2000=0.30%
  cpu          : usr=0.40%, sys=0.17%, ctx=13865, majf=0, minf=82
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=46.7%, 16=53.2%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.9%, 8=1.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,11692,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=97.3MiB/s (102MB/s), 97.3MiB/s-97.3MiB/s (102MB/s-102MB/s), io=11.4GiB (12.3GB), run=120143-120143msec
```
