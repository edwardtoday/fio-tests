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
Jobs: 4 (f=1): [m(4)][2.5%][eta 01m:57s]
Jobs: 4 (f=1): [m(4)][3.3%][eta 01m:56s]
Jobs: 4 (f=1): [m(4)][4.2%][eta 01m:55s]
Jobs: 4 (f=1): [m(4)][5.0%][eta 01m:54s]
Jobs: 4 (f=1): [m(4)][5.8%][eta 01m:53s]
Jobs: 4 (f=1): [m(4)][6.7%][eta 01m:52s]
Jobs: 4 (f=1): [m(4)][7.5%][eta 01m:51s]
Jobs: 4 (f=4): [m(4)][8.3%][r=2456KiB/s,w=2524KiB/s][r=614,w=631 IOPS][etJobs: 4 (f=4): [m(4)][9.2%][r=5609KiB/s,w=5953KiB/s][r=1402,w=1488 IOPS][eta 01m:49s]
Jobs: 4 (f=4): [m(4)][10.0%][r=5620KiB/s,w=5796KiB/s][r=1405,w=1449 IOPS]Jobs: 4 (f=4): [m(4)][10.8%][r=4319KiB/s,w=4546KiB/s][r=1079,w=1136 IOPS][eta 01m:47s]
Jobs: 4 (f=4): [m(4)][11.7%][r=5573KiB/s,w=5805KiB/s][r=1393,w=1451 IOPS]Jobs: 4 (f=4): [m(4)][12.5%][r=3979KiB/s,w=4112KiB/s][r=994,w=1028 IOPS][eta 01m:45s]
Jobs: 4 (f=4): [m(4)][13.3%][eta 01m:44s]
Jobs: 4 (f=4): [m(4)][14.2%][r=1066KiB/s,w=1010KiB/s][r=266,w=252 IOPS][eJobs: 4 (f=4): [m(4)][15.0%][r=506KiB/s,w=590KiB/s][r=126,w=147 IOPS][eta 01m:42s]
Jobs: 4 (f=4): [m(4)][15.8%][eta 01m:41s]
Jobs: 4 (f=4): [m(4)][16.7%][r=1874KiB/s,w=1950KiB/s][r=468,w=487 IOPS][eta 01m:40s]
Jobs: 4 (f=4): [m(4)][17.5%][r=1609KiB/s,w=1851KiB/s][r=402,w=462 IOPS][eJobs: 4 (f=4): [m(4)][18.3%][eta 01m:38s]
Jobs: 4 (f=4): [m(4)][19.2%][r=3490KiB/s,w=3442KiB/s][r=872,w=860 IOPS][eta 01m:37s]
Jobs: 4 (f=4): [m(4)][20.8%][r=407KiB/s,w=339KiB/s][r=101,w=84 IOPS][eta 01m:35s]
Jobs: 4 (f=4): [m(4)][21.7%][r=2241KiB/s,w=2257KiB/s][r=560,w=564 IOPS][eta 01m:34s]
Jobs: 4 (f=4): [m(4)][22.5%][r=220KiB/s,w=188KiB/s][r=55,w=47 IOPS][eta 0Jobs: 4 (f=4): [m(4)][23.3%][r=364KiB/s,w=360KiB/s][r=91,w=90 IOPS][eta 01m:32s]
Jobs: 4 (f=4): [m(4)][24.2%][r=1558KiB/s,w=1810KiB/s][r=389,w=452 IOPS][eta 01m:31s]
Jobs: 4 (f=4): [m(4)][25.0%][r=176KiB/s,w=140KiB/s][r=44,w=35 IOPS][eta 0Jobs: 4 (f=4): [m(4)][25.8%][r=260KiB/s,w=196KiB/s][r=65,w=49 IOPS][eta 01m:29s]
Jobs: 4 (f=4): [m(4)][26.7%][r=3486KiB/s,w=3562KiB/s][r=871,w=890 IOPS][eJobs: 4 (f=4): [m(4)][27.5%][r=1060KiB/s,w=988KiB/s][r=265,w=247 IOPS][eta 01m:27s]
Jobs: 4 (f=4): [m(4)][28.3%][r=172KiB/s,w=216KiB/s][r=43,w=54 IOPS][eta 0Jobs: 4 (f=4): [m(4)][29.2%][r=3583KiB/s,w=3727KiB/s][r=895,w=931 IOPS][eta 01m:25s]
Jobs: 4 (f=4): [m(4)][30.0%][r=5980KiB/s,w=5916KiB/s][r=1495,w=1479 IOPS]Jobs: 4 (f=4): [m(4)][30.8%][r=75KiB/s,w=83KiB/s][r=18,w=20 IOPS][eta 01m:23s]
Jobs: 4 (f=4): [m(4)][31.7%][eta 01m:22s]
Jobs: 4 (f=4): [m(4)][32.5%][r=3108KiB/s,w=3215KiB/s][r=777,w=803 IOPS][eta 01m:21s]
Jobs: 4 (f=4): [m(4)][33.3%][r=4774KiB/s,w=4826KiB/s][r=1193,w=1206 IOPS][eta 01m:20s]
Jobs: 4 (f=4): [m(4)][34.2%][r=534KiB/s,w=475KiB/s][r=133,w=118 IOPS][eta 01m:19s]
Jobs: 4 (f=4): [m(4)][35.0%][r=3KiB/s,w=3KiB/s][r=0,w=0 IOPS][eta 01m:18s]
Jobs: 4 (f=4): [m(4)][35.8%][r=4465KiB/s,w=4670KiB/s][r=1116,w=1167 IOPS]Jobs: 4 (f=4): [m(4)][36.7%][r=611KiB/s,w=643KiB/s][r=152,w=160 IOPS][eta 01m:16s]
Jobs: 4 (f=4): [m(4)][37.5%][r=504KiB/s,w=488KiB/s][r=126,w=122 IOPS][etaJobs: 4 (f=4): [m(4)][38.3%][eta 01m:14s]
Jobs: 4 (f=4): [m(4)][39.2%][r=4428KiB/s,w=4240KiB/s][r=1107,w=1060 IOPS]Jobs: 4 (f=4): [m(4)][40.0%][r=5290KiB/s,w=5226KiB/s][r=1322,w=1306 IOPS][eta 01m:12s]
Jobs: 4 (f=4): [m(4)][40.8%][r=341KiB/s,w=277KiB/s][r=85,w=69 IOPS][eta 0Jobs: 4 (f=4): [m(4)][41.7%][r=600KiB/s,w=493KiB/s][r=150,w=123 IOPS][eta 01m:10s]
Jobs: 4 (f=4): [m(4)][42.5%][r=6056KiB/s,w=5859KiB/s][r=1514,w=1464 IOPS]Jobs: 4 (f=4): [m(4)][43.3%][r=3508KiB/s,w=3600KiB/s][r=877,w=900 IOPS][eta 01m:08s]
Jobs: 4 (f=4): [m(4)][45.0%][r=433KiB/s,w=469KiB/s][r=108,w=117 IOPS][eta 01m:06s]
Jobs: 4 (f=4): [m(4)][45.8%][r=5378KiB/s,w=5533KiB/s][r=1344,w=1383 IOPS][eta 01m:05s]
Jobs: 4 (f=4): [m(4)][46.7%][r=2313KiB/s,w=2317KiB/s][r=578,w=579 IOPS][eJobs: 4 (f=4): [m(4)][47.5%][r=375KiB/s,w=279KiB/s][r=93,w=69 IOPS][eta 01m:03s]
Jobs: 4 (f=4): [m(4)][48.3%][r=4928KiB/s,w=4808KiB/s][r=1232,w=1202 IOPS]Jobs: 4 (f=4): [m(4)][49.2%][eta 01m:01s]
Jobs: 4 (f=4): [m(4)][50.0%][r=2533KiB/s,w=2581KiB/s][r=633,w=645 IOPS][eta 01m:00s]
Jobs: 4 (f=4): [m(4)][50.8%][r=6043KiB/s,w=5804KiB/s][r=1510,w=1451 IOPS][eta 00m:59s]
Jobs: 4 (f=4): [m(4)][51.7%][r=188KiB/s,w=212KiB/s][r=47,w=53 IOPS][eta 0Jobs: 4 (f=4): [m(4)][52.5%][r=517KiB/s,w=449KiB/s][r=129,w=112 IOPS][eta 00m:57s]
Jobs: 4 (f=4): [m(4)][53.3%][r=4392KiB/s,w=4600KiB/s][r=1098,w=1150 IOPS]Jobs: 4 (f=4): [m(4)][54.2%][r=5892KiB/s,w=5633KiB/s][r=1473,w=1408 IOPS][eta 00m:55s]
Jobs: 4 (f=4): [m(4)][55.0%][r=6034KiB/s,w=6030KiB/s][r=1508,w=1507 IOPS]Jobs: 4 (f=4): [m(4)][55.8%][r=6105KiB/s,w=5870KiB/s][r=1526,w=1467 IOPS][eta 00m:53s]
Jobs: 4 (f=4): [m(4)][56.7%][r=5747KiB/s,w=5707KiB/s][r=1436,w=1426 IOPS]Jobs: 4 (f=4): [m(4)][57.5%][r=1972KiB/s,w=2083KiB/s][r=493,w=520 IOPS][eta 00m:51s]
Jobs: 4 (f=4): [m(4)][58.3%][r=540KiB/s,w=536KiB/s][r=135,w=134 IOPS][etaJobs: 4 (f=4): [m(4)][59.2%][eta 00m:49s]
Jobs: 4 (f=4): [m(4)][60.0%][r=1807KiB/s,w=1907KiB/s][r=451,w=476 IOPS][eJobs: 4 (f=4): [m(4)][60.8%][r=5003KiB/s,w=4812KiB/s][r=1250,w=1203 IOPS][eta 00m:47s]
Jobs: 4 (f=4): [m(4)][61.7%][r=5983KiB/s,w=5967KiB/s][r=1495,w=1491 IOPS]Jobs: 4 (f=4): [m(4)][62.5%][r=1695KiB/s,w=1755KiB/s][r=423,w=438 IOPS][eta 00m:45s]
Jobs: 4 (f=4): [m(4)][63.3%][r=115KiB/s,w=99KiB/s][r=28,w=24 IOPS][eta 00m:44s]
Jobs: 4 (f=4): [m(4)][64.2%][r=4484KiB/s,w=4596KiB/s][r=1121,w=1149 IOPS]Jobs: 4 (f=4): [m(4)][65.0%][eta 00m:42s]
Jobs: 4 (f=4): [m(4)][65.8%][r=527KiB/s,w=451KiB/s][r=131,w=112 IOPS][eta 00m:41s]
Jobs: 4 (f=4): [m(4)][66.7%][r=2172KiB/s,w=2240KiB/s][r=543,w=560 IOPS][eJobs: 4 (f=4): [m(4)][67.5%][r=1330KiB/s,w=1342KiB/s][r=332,w=335 IOPS][eta 00m:39s]
Jobs: 4 (f=4): [m(4)][69.2%][r=3276KiB/s,w=3452KiB/s][r=819,w=863 IOPS][eta 00m:37s]
Jobs: 4 (f=4): [m(4)][70.0%][r=622KiB/s,w=706KiB/s][r=155,w=176 IOPS][etaJobs: 4 (f=4): [m(4)][70.8%][eta 00m:35s]
Jobs: 4 (f=4): [m(4)][71.7%][r=3006KiB/s,w=2981KiB/s][r=751,w=745 IOPS][eJobs: 4 (f=4): [m(4)][72.5%][r=5884KiB/s,w=5968KiB/s][r=1471,w=1492 IOPS][eta 00m:33s]
Jobs: 4 (f=4): [m(4)][73.3%][r=5945KiB/s,w=6010KiB/s][r=1486,w=1502 IOPS]Jobs: 4 (f=4): [m(4)][74.2%][r=6093KiB/s,w=5974KiB/s][r=1523,w=1493 IOPS][eta 00m:31s]
Jobs: 4 (f=4): [m(4)][75.0%][r=1979KiB/s,w=2072KiB/s][r=494,w=518 IOPS][eJobs: 4 (f=4): [m(4)][75.8%][eta 00m:29s]
Jobs: 4 (f=4): [m(4)][76.7%][r=3839KiB/s,w=3891KiB/s][r=959,w=972 IOPS][eJobs: 4 (f=4): [m(4)][77.5%][r=790KiB/s,w=886KiB/s][r=197,w=221 IOPS][eta 00m:27s]
Jobs: 4 (f=4): [m(4)][79.2%][r=4776KiB/s,w=4908KiB/s][r=1194,w=1227 IOPS][eta 00m:25s]
Jobs: 4 (f=4): [m(4)][80.0%][r=3482KiB/s,w=3444KiB/s][r=870,w=861 IOPS][eJobs: 4 (f=4): [m(4)][80.8%][eta 00m:23s]
Jobs: 4 (f=4): [m(4)][81.7%][r=2386KiB/s,w=2477KiB/s][r=596,w=619 IOPS][eta 00m:22s]
Jobs: 4 (f=4): [m(4)][82.5%][r=6033KiB/s,w=5890KiB/s][r=1508,w=1472 IOPS][eta 00m:21s]
Jobs: 4 (f=4): [m(4)][83.3%][r=5988KiB/s,w=5912KiB/s][r=1497,w=1478 IOPS][eta 00m:20s]
Jobs: 4 (f=4): [m(4)][84.2%][r=1163KiB/s,w=1092KiB/s][r=290,w=273 IOPS][eta 00m:19s]
Jobs: 4 (f=4): [m(4)][85.0%][r=2568KiB/s,w=2759KiB/s][r=642,w=689 IOPS][eta 00m:18s]
Jobs: 4 (f=4): [m(4)][85.8%][r=60KiB/s,w=36KiB/s][r=15,w=9 IOPS][eta 00m:Jobs: 4 (f=4): [m(4)][86.7%][eta 00m:16s]
Jobs: 4 (f=4): [m(4)][87.5%][r=790KiB/s,w=850KiB/s][r=197,w=212 IOPS][etaJobs: 4 (f=4): [m(4)][88.3%][eta 00m:14s]
Jobs: 4 (f=4): [m(4)][89.2%][r=203KiB/s,w=167KiB/s][r=50,w=41 IOPS][eta 0Jobs: 4 (f=4): [m(4)][90.0%][r=324KiB/s,w=284KiB/s][r=81,w=71 IOPS][eta 00m:12s]
Jobs: 4 (f=4): [m(4)][90.8%][eta 00m:11s]
Jobs: 4 (f=4): [m(4)][91.7%][r=5349KiB/s,w=4935KiB/s][r=1337,w=1233 IOPS]Jobs: 4 (f=4): [m(4)][92.5%][r=5784KiB/s,w=5908KiB/s][r=1446,w=1477 IOPS][eta 00m:09s]
Jobs: 4 (f=4): [m(4)][93.3%][r=5808KiB/s,w=5944KiB/s][r=1452,w=1486 IOPS]Jobs: 4 (f=4): [m(4)][94.2%][r=2490KiB/s,w=2442KiB/s][r=622,w=610 IOPS][eta 00m:07s]
Jobs: 4 (f=4): [m(4)][95.8%][r=3375KiB/s,w=3391KiB/s][r=843,w=847 IOPS][eta 00m:05s]
Jobs: 4 (f=4): [m(4)][96.7%][r=5899KiB/s,w=5967KiB/s][r=1474,w=1491 IOPS]Jobs: 4 (f=4): [m(4)][97.5%][r=5689KiB/s,w=5964KiB/s][r=1422,w=1491 IOPS][eta 00m:03s]
Jobs: 4 (f=4): [m(4)][98.3%][r=373KiB/s,w=393KiB/s][r=93,w=98 IOPS][eta 0Jobs: 4 (f=4): [m(4)][99.2%][eta 00m:01s]
Jobs: 4 (f=4): [m(4)][100.0%][r=2363KiB/s,w=2327KiB/s][r=590,w=581 IOPS][eta 00m:00s]
Jobs: 4 (f=4): [m(4)][12.6%][eta 14m:02s]
iops-test-job: (groupid=0, jobs=4): err= 0: pid=53867: Fri May 31 11:14:25 2024
  read: IOPS=543, BW=2175KiB/s (2227kB/s)(257MiB/120925msec)
    slat (nsec): min=0, max=6978.0k, avg=2825.27, stdev=43779.87
    clat (usec): min=210, max=9381.8k, avg=55664.15, stdev=243952.81
     lat (usec): min=404, max=9381.8k, avg=55666.98, stdev=243953.50
    clat percentiles (msec):
     |  1.00th=[   16],  5.00th=[   18], 10.00th=[   19], 20.00th=[   20],
     | 30.00th=[   21], 40.00th=[   21], 50.00th=[   22], 60.00th=[   23],
     | 70.00th=[   24], 80.00th=[   25], 90.00th=[   28], 95.00th=[   32],
     | 99.00th=[ 1938], 99.50th=[ 2022], 99.90th=[ 2039], 99.95th=[ 2072],
     | 99.99th=[ 2089]
   bw (  KiB/s): min=   54, max= 6761, per=100.00%, avg=3766.99, stdev=549.37, samples=554
   iops        : min=   12, max= 1689, avg=940.24, stdev=137.40, samples=554
  write: IOPS=547, BW=2189KiB/s (2241kB/s)(258MiB/120925msec); 0 zone resets
    slat (nsec): min=0, max=3212.0k, avg=2802.78, stdev=27802.18
    clat (usec): min=545, max=7662.7k, avg=54797.68, stdev=248482.28
     lat (usec): min=556, max=7662.7k, avg=54800.48, stdev=248482.25
    clat percentiles (msec):
     |  1.00th=[   16],  5.00th=[   18], 10.00th=[   19], 20.00th=[   20],
     | 30.00th=[   21], 40.00th=[   21], 50.00th=[   22], 60.00th=[   23],
     | 70.00th=[   23], 80.00th=[   24], 90.00th=[   27], 95.00th=[   30],
     | 99.00th=[ 1888], 99.50th=[ 2022], 99.90th=[ 2039], 99.95th=[ 2072],
     | 99.99th=[ 7684]
   bw (  KiB/s): min=   39, max= 6639, per=100.00%, avg=3792.48, stdev=552.53, samples=554
   iops        : min=    9, max= 1658, avg=946.57, stdev=138.20, samples=554
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%
  lat (msec)   : 2=0.01%, 4=0.02%, 10=0.14%, 20=28.48%, 50=68.36%
  lat (msec)   : 100=0.14%, 250=0.47%, 500=0.63%, 750=0.09%, 1000=0.16%
  lat (msec)   : 2000=0.89%, >=2000=0.59%
  cpu          : usr=0.25%, sys=0.29%, ctx=115251, majf=0, minf=43
  IO depths    : 1=0.1%, 2=0.1%, 4=0.3%, 8=52.8%, 16=46.9%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.2%, 8=1.7%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=65742,66174,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=2175KiB/s (2227kB/s), 2175KiB/s-2175KiB/s (2227kB/s-2227kB/s), io=257MiB (269MB), run=120925-120925msec
  WRITE: bw=2189KiB/s (2241kB/s), 2189KiB/s-2189KiB/s (2241kB/s-2241kB/s), io=258MiB (271MB), run=120925-120925msec
```

## Throughput test: sequential read

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [R(1)][3.3%][r=102MiB/s][r=101 IOPS][eta 01m:57s]
Jobs: 1 (f=1): [R(1)][5.0%][r=112MiB/s][r=111 IOPS][eta 01m:55s]
Jobs: 1 (f=1): [R(1)][5.8%][r=111MiB/s][r=111 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [R(1)][8.3%][r=115MiB/s][r=115 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [R(1)][9.1%][r=107MiB/s][r=106 IOPS][eta 01m:50s]
Jobs: 1 (f=1): [R(1)][10.7%][r=109MiB/s][r=108 IOPS][eta 01m:48s]
Jobs: 1 (f=1): [R(1)][11.7%][r=115MiB/s][r=115 IOPS][eta 01m:46s]
Jobs: 1 (f=1): [R(1)][13.2%][r=112MiB/s][r=111 IOPS][eta 01m:45s]
Jobs: 1 (f=1): [R(1)][14.9%][r=109MiB/s][r=108 IOPS][eta 01m:43s]
Jobs: 1 (f=1): [R(1)][16.5%][r=115MiB/s][r=114 IOPS][eta 01m:41s]
Jobs: 1 (f=1): [R(1)][18.2%][r=109MiB/s][r=109 IOPS][eta 01m:39s]
Jobs: 1 (f=1): [R(1)][20.0%][r=113MiB/s][r=112 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [R(1)][20.7%][r=109MiB/s][r=109 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [R(1)][22.3%][r=115MiB/s][r=115 IOPS][eta 01m:34s]
Jobs: 1 (f=1): [R(1)][24.0%][r=109MiB/s][r=109 IOPS][eta 01m:32s]
Jobs: 1 (f=1): [R(1)][25.6%][r=112MiB/s][r=112 IOPS][eta 01m:30s]
Jobs: 1 (f=1): [R(1)][26.7%][r=109MiB/s][r=108 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [R(1)][28.3%][r=107MiB/s][r=107 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [R(1)][28.9%][r=112MiB/s][r=111 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [R(1)][30.0%][r=106MiB/s][r=106 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [R(1)][31.4%][r=114MiB/s][r=113 IOPS][eta 01m:23s]
Jobs: 1 (f=1): [R(1)][33.1%][r=111MiB/s][r=110 IOPS][eta 01m:21s]
Jobs: 1 (f=1): [R(1)][34.7%][r=111MiB/s][r=111 IOPS][eta 01m:19s]
Jobs: 1 (f=1): [R(1)][36.4%][r=116MiB/s][r=115 IOPS][eta 01m:17s]
Jobs: 1 (f=1): [R(1)][38.0%][r=114MiB/s][r=114 IOPS][eta 01m:15s]
Jobs: 1 (f=1): [R(1)][39.7%][r=112MiB/s][r=111 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [R(1)][40.5%][r=110MiB/s][r=110 IOPS][eta 01m:12s]
Jobs: 1 (f=1): [R(1)][41.3%][r=115MiB/s][r=114 IOPS][eta 01m:11s]
Jobs: 1 (f=1): [R(1)][42.1%][r=112MiB/s][r=111 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [R(1)][43.8%][r=114MiB/s][r=113 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [R(1)][45.5%][r=116MiB/s][r=116 IOPS][eta 01m:06s]
Jobs: 1 (f=1): [R(1)][46.3%][r=112MiB/s][r=111 IOPS][eta 01m:05s]
Jobs: 1 (f=1): [R(1)][47.1%][r=112MiB/s][r=111 IOPS][eta 01m:04s]
Jobs: 1 (f=1): [R(1)][48.8%][r=109MiB/s][r=108 IOPS][eta 01m:02s]
Jobs: 1 (f=1): [R(1)][50.4%][r=111MiB/s][r=111 IOPS][eta 01m:00s]
Jobs: 1 (f=1): [R(1)][52.5%][r=112MiB/s][r=112 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [R(1)][52.9%][r=110MiB/s][r=110 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [R(1)][54.5%][r=112MiB/s][r=112 IOPS][eta 00m:55s]
Jobs: 1 (f=1): [R(1)][55.8%][r=111MiB/s][r=110 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [R(1)][57.0%][r=112MiB/s][r=111 IOPS][eta 00m:52s]
Jobs: 1 (f=1): [R(1)][57.9%][r=113MiB/s][r=112 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [R(1)][59.5%][r=116MiB/s][r=116 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [R(1)][60.3%][r=111MiB/s][r=110 IOPS][eta 00m:48s]
Jobs: 1 (f=1): [R(1)][62.0%][r=113MiB/s][r=113 IOPS][eta 00m:46s]
Jobs: 1 (f=1): [R(1)][63.6%][r=115MiB/s][r=115 IOPS][eta 00m:44s]
Jobs: 1 (f=1): [R(1)][65.0%][r=111MiB/s][r=110 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [R(1)][66.1%][r=115MiB/s][r=114 IOPS][eta 00m:41s]
Jobs: 1 (f=1): [R(1)][68.3%][r=115MiB/s][r=114 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][68.6%][r=111MiB/s][r=110 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][70.2%][r=115MiB/s][r=115 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [R(1)][71.1%][r=110MiB/s][r=109 IOPS][eta 00m:35s]
Jobs: 1 (f=1): [R(1)][72.7%][r=111MiB/s][r=110 IOPS][eta 00m:33s]
Jobs: 1 (f=1): [R(1)][74.4%][r=113MiB/s][r=113 IOPS][eta 00m:31s]
Jobs: 1 (f=1): [R(1)][75.2%][r=112MiB/s][r=111 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [R(1)][77.5%][r=112MiB/s][r=112 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [R(1)][77.7%][r=111MiB/s][r=110 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [R(1)][79.3%][r=111MiB/s][r=110 IOPS][eta 00m:25s]
Jobs: 1 (f=1): [R(1)][81.0%][r=109MiB/s][r=108 IOPS][eta 00m:23s]
Jobs: 1 (f=1): [R(1)][81.8%][r=114MiB/s][r=113 IOPS][eta 00m:22s]
Jobs: 1 (f=1): [R(1)][83.5%][r=113MiB/s][r=113 IOPS][eta 00m:20s]
Jobs: 1 (f=1): [R(1)][85.0%][r=113MiB/s][r=112 IOPS][eta 00m:18s]
Jobs: 1 (f=1): [R(1)][85.8%][r=109MiB/s][r=108 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [R(1)][87.5%][r=108MiB/s][r=108 IOPS][eta 00m:15s]
Jobs: 1 (f=1): [R(1)][89.2%][r=113MiB/s][r=112 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [R(1)][90.8%][r=113MiB/s][r=113 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [R(1)][91.7%][r=111MiB/s][r=110 IOPS][eta 00m:10s]
Jobs: 1 (f=1): [R(1)][93.3%][r=112MiB/s][r=111 IOPS][eta 00m:08s]
Jobs: 1 (f=1): [R(1)][95.0%][r=111MiB/s][r=111 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [R(1)][96.7%][r=112MiB/s][r=112 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [R(1)][97.5%][r=112MiB/s][r=111 IOPS][eta 00m:03s]
Jobs: 1 (f=1): [R(1)][98.3%][r=110MiB/s][r=110 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [R(1)][99.2%][r=113MiB/s][r=113 IOPS][eta 00m:01s]
Jobs: 1 (f=1): [R(1)][100.0%][r=106MiB/s][r=106 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=53962: Fri May 31 11:16:26 2024
  read: IOPS=111, BW=112MiB/s (117MB/s)(13.1GiB/120137msec)
    slat (nsec): min=0, max=5926.0k, avg=5585.82, stdev=76213.91
    clat (msec): min=69, max=267, avg=143.40, stdev=13.45
     lat (msec): min=69, max=267, avg=143.41, stdev=13.45
    clat percentiles (msec):
     |  1.00th=[   99],  5.00th=[  116], 10.00th=[  126], 20.00th=[  136],
     | 30.00th=[  144], 40.00th=[  144], 50.00th=[  146], 60.00th=[  153],
     | 70.00th=[  153], 80.00th=[  153], 90.00th=[  153], 95.00th=[  155],
     | 99.00th=[  165], 99.50th=[  169], 99.90th=[  197], 99.95th=[  205],
     | 99.99th=[  259]
   bw (  KiB/s): min=99952, max=129774, per=100.00%, avg=114281.76, stdev=4182.00, samples=238
   iops        : min=   97, max=  126, avg=111.12, stdev= 4.12, samples=238
  lat (msec)   : 100=1.85%, 250=98.13%, 500=0.01%
  cpu          : usr=0.14%, sys=0.16%, ctx=14751, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.4%, 16=52.6%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.1%, 8=1.9%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=13400,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=112MiB/s (117MB/s), 112MiB/s-112MiB/s (117MB/s-117MB/s), io=13.1GiB (14.1GB), run=120137-120137msec
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
Jobs: 1 (f=1): [W(1)][4.1%][w=104MiB/s][w=103 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [W(1)][5.8%][w=104MiB/s][w=104 IOPS][eta 01m:54s]
Jobs: 1 (f=1): [W(1)][6.6%][w=104MiB/s][w=103 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [W(1)][8.3%][w=103MiB/s][w=102 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [W(1)][9.1%][w=109MiB/s][w=108 IOPS][eta 01m:50s]
Jobs: 1 (f=1): [W(1)][10.7%][w=104MiB/s][w=104 IOPS][eta 01m:48s]
Jobs: 1 (f=1): [W(1)][12.4%][w=103MiB/s][w=103 IOPS][eta 01m:46s]
Jobs: 1 (f=1): [W(1)][14.0%][w=110MiB/s][w=109 IOPS][eta 01m:44s]
Jobs: 1 (f=1): [W(1)][15.7%][w=105MiB/s][w=104 IOPS][eta 01m:42s]
Jobs: 1 (f=1): [W(1)][17.4%][w=108MiB/s][w=108 IOPS][eta 01m:40s]
Jobs: 1 (f=1): [W(1)][19.0%][w=108MiB/s][w=108 IOPS][eta 01m:38s]
Jobs: 1 (f=1): [W(1)][20.7%][w=103MiB/s][w=103 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [W(1)][22.3%][w=105MiB/s][w=105 IOPS][eta 01m:34s]
Jobs: 1 (f=1): [W(1)][23.1%][w=106MiB/s][w=105 IOPS][eta 01m:33s]
Jobs: 1 (f=1): [W(1)][24.8%][w=105MiB/s][w=104 IOPS][eta 01m:31s]
Jobs: 1 (f=1): [W(1)][26.7%][w=104MiB/s][w=104 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [W(1)][28.3%][eta 01m:26s]
Jobs: 1 (f=1): [W(1)][30.0%][eta 01m:24s]
Jobs: 1 (f=1): [W(1)][30.6%][w=64.8MiB/s][w=64 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [W(1)][32.2%][w=37.0MiB/s][w=37 IOPS][eta 01m:22s]
Jobs: 1 (f=1): [W(1)][33.1%][w=86.9MiB/s][w=86 IOPS][eta 01m:21s]
Jobs: 1 (f=1): [W(1)][34.2%][eta 01m:19s]
Jobs: 1 (f=1): [W(1)][35.0%][w=74.4MiB/s][w=74 IOPS][eta 01m:18s]
Jobs: 1 (f=1): [W(1)][36.4%][w=56.7MiB/s][w=56 IOPS][eta 01m:17s]
Jobs: 1 (f=1): [W(1)][37.2%][eta 01m:16s]
Jobs: 1 (f=1): [W(1)][38.0%][eta 01m:15s]
Jobs: 1 (f=1): [W(1)][39.2%][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][39.7%][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][41.3%][w=34.0MiB/s][w=34 IOPS][eta 01m:11s]
Jobs: 1 (f=1): [W(1)][43.0%][w=55.9MiB/s][w=55 IOPS][eta 01m:09s]
Jobs: 1 (f=1): [W(1)][44.6%][eta 01m:07s]
Jobs: 1 (f=1): [W(1)][46.3%][eta 01m:05s]
Jobs: 1 (f=1): [W(1)][47.9%][w=75.1MiB/s][w=75 IOPS][eta 01m:03s]
Jobs: 1 (f=1): [W(1)][48.8%][eta 01m:02s]
Jobs: 1 (f=1): [W(1)][49.6%][w=72.9MiB/s][w=72 IOPS][eta 01m:01s]
Jobs: 1 (f=1): [W(1)][51.2%][w=106MiB/s][w=106 IOPS][eta 00m:59s]
Jobs: 1 (f=1): [W(1)][52.9%][w=106MiB/s][w=105 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [W(1)][54.5%][w=104MiB/s][w=103 IOPS][eta 00m:55s]
Jobs: 1 (f=1): [W(1)][56.2%][w=106MiB/s][w=105 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [W(1)][57.9%][w=108MiB/s][w=107 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [W(1)][59.2%][w=106MiB/s][w=105 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [W(1)][59.5%][w=105MiB/s][w=104 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [W(1)][61.2%][w=106MiB/s][w=105 IOPS][eta 00m:47s]
Jobs: 1 (f=1): [W(1)][62.8%][w=106MiB/s][w=105 IOPS][eta 00m:45s]
Jobs: 1 (f=1): [W(1)][65.0%][w=105MiB/s][w=105 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][65.3%][w=105MiB/s][w=104 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][66.9%][w=103MiB/s][w=103 IOPS][eta 00m:40s]
Jobs: 1 (f=1): [W(1)][68.6%][w=106MiB/s][w=106 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [W(1)][69.4%][w=107MiB/s][w=106 IOPS][eta 00m:37s]
Jobs: 1 (f=1): [W(1)][71.1%][w=105MiB/s][w=105 IOPS][eta 00m:35s]
Jobs: 1 (f=1): [W(1)][72.7%][w=109MiB/s][w=108 IOPS][eta 00m:33s]
Jobs: 1 (f=1): [W(1)][74.4%][w=95.2MiB/s][w=95 IOPS][eta 00m:31s]
Jobs: 1 (f=1): [W(1)][76.0%][eta 00m:29s]
Jobs: 1 (f=1): [W(1)][77.7%][eta 00m:27s]
Jobs: 1 (f=1): [W(1)][79.3%][w=98.1MiB/s][w=98 IOPS][eta 00m:25s]
Jobs: 1 (f=1): [W(1)][81.0%][w=60.1MiB/s][w=60 IOPS][eta 00m:23s]
Jobs: 1 (f=1): [W(1)][82.6%][w=27.0MiB/s][w=27 IOPS][eta 00m:21s]
Jobs: 1 (f=1): [W(1)][83.5%][eta 00m:20s]
Jobs: 1 (f=1): [W(1)][84.3%][eta 00m:19s]
Jobs: 1 (f=1): [W(1)][86.0%][eta 00m:17s]
Jobs: 1 (f=1): [W(1)][86.8%][eta 00m:16s]
Jobs: 1 (f=1): [W(1)][88.4%][w=94.2MiB/s][w=94 IOPS][eta 00m:14s]
Jobs: 1 (f=1): [W(1)][90.1%][w=75.0MiB/s][w=75 IOPS][eta 00m:12s]
Jobs: 1 (f=1): [W(1)][90.9%][w=53.9MiB/s][w=53 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [W(1)][92.6%][eta 00m:09s]
Jobs: 1 (f=1): [W(1)][93.4%][w=62.9MiB/s][w=62 IOPS][eta 00m:08s]
Jobs: 1 (f=1): [W(1)][95.0%][eta 00m:06s]
Jobs: 1 (f=1): [W(1)][95.9%][eta 00m:05s]
Jobs: 1 (f=1): [W(1)][96.7%][w=66.6MiB/s][w=66 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [W(1)][97.5%][w=98.3MiB/s][w=98 IOPS][eta 00m:03s]
Jobs: 1 (f=1): [W(1)][98.3%][w=73.6MiB/s][w=73 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [W(1)][99.2%][w=103MiB/s][w=103 IOPS][eta 00m:01s]
Jobs: 1 (f=1): [W(1)][100.0%][w=109MiB/s][w=109 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=54057: Fri May 31 11:18:26 2024
  write: IOPS=70, BW=70.0MiB/s (73.4MB/s)(8411MiB/120137msec); 0 zone resets
    slat (nsec): min=1000, max=2911.0k, avg=23271.43, stdev=68525.36
    clat (msec): min=56, max=6803, avg=228.42, stdev=555.51
     lat (msec): min=56, max=6803, avg=228.44, stdev=555.51
    clat percentiles (msec):
     |  1.00th=[   95],  5.00th=[  113], 10.00th=[  121], 20.00th=[  125],
     | 30.00th=[  133], 40.00th=[  142], 50.00th=[  142], 60.00th=[  146],
     | 70.00th=[  153], 80.00th=[  163], 90.00th=[  184], 95.00th=[  334],
     | 99.00th=[ 3104], 99.50th=[ 5067], 99.90th=[ 6611], 99.95th=[ 6611],
     | 99.99th=[ 6812]
   bw (  KiB/s): min= 6083, max=117607, per=100.00%, avg=97500.71, stdev=25431.01, samples=175
   iops        : min=    5, max=  114, avg=94.66, stdev=24.89, samples=175
  lat (msec)   : 100=1.65%, 250=92.05%, 500=3.10%, 750=0.82%, 1000=0.08%
  lat (msec)   : 2000=0.75%, >=2000=1.55%
  cpu          : usr=0.31%, sys=0.13%, ctx=9578, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.0%, 16=52.9%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.1%, 8=0.9%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,8411,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=70.0MiB/s (73.4MB/s), 70.0MiB/s-70.0MiB/s (73.4MB/s-73.4MB/s), io=8411MiB (8820MB), run=120137-120137msec
```
