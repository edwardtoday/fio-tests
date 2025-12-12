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
Jobs: 4 (f=4): [m(4)][2.5%][r=503KiB/s,w=553KiB/s][r=125,w=138 IOPS][eta Jobs: 4 (f=4): [m(4)][3.3%][r=5814KiB/s,w=6069KiB/s][r=1453,w=1517 IOPS][eta 01m:56s]
Jobs: 4 (f=4): [m(4)][4.2%][r=3778KiB/s,w=3983KiB/s][r=944,w=995 IOPS][etJobs: 4 (f=4): [m(4)][5.0%][eta 01m:54s]
Jobs: 4 (f=4): [m(4)][5.8%][r=3257KiB/s,w=3422KiB/s][r=814,w=855 IOPS][etJobs: 4 (f=4): [m(4)][6.7%][r=2950KiB/s,w=3153KiB/s][r=737,w=788 IOPS][eta 01m:52s]
Jobs: 4 (f=4): [m(4)][7.5%][r=1354KiB/s,w=1222KiB/s][r=338,w=305 IOPS][etJobs: 4 (f=4): [m(4)][8.3%][r=3684KiB/s,w=3848KiB/s][r=921,w=962 IOPS][eta 01m:50s]
Jobs: 4 (f=4): [m(4)][9.2%][eta 01m:49s]
Jobs: 4 (f=4): [m(4)][10.0%][r=1985KiB/s,w=2086KiB/s][r=496,w=521 IOPS][eJobs: 4 (f=4): [m(4)][10.8%][r=179KiB/s,w=239KiB/s][r=44,w=59 IOPS][eta 01m:47s]
Jobs: 4 (f=4): [m(4)][12.5%][r=3199KiB/s,w=3211KiB/s][r=799,w=802 IOPS][eta 01m:45s]
Jobs: 4 (f=4): [m(4)][13.3%][r=4232KiB/s,w=4436KiB/s][r=1058,w=1109 IOPS]Jobs: 4 (f=4): [m(4)][14.2%][eta 01m:43s]
Jobs: 4 (f=4): [m(4)][15.0%][r=1425KiB/s,w=1544KiB/s][r=356,w=386 IOPS][eta 01m:42s]
Jobs: 4 (f=4): [m(4)][15.8%][r=6060KiB/s,w=5995KiB/s][r=1515,w=1498 IOPS]Jobs: 4 (f=4): [m(4)][16.7%][r=1766KiB/s,w=1914KiB/s][r=441,w=478 IOPS][eta 01m:40s]
Jobs: 4 (f=4): [m(4)][18.3%][r=1022KiB/s,w=1046KiB/s][r=255,w=261 IOPS][eta 01m:38s]
Jobs: 4 (f=4): [m(4)][20.0%][r=353KiB/s,w=401KiB/s][r=88,w=100 IOPS][eta 01m:36s]
Jobs: 4 (f=4): [m(4)][20.8%][r=4075KiB/s,w=4087KiB/s][r=1018,w=1021 IOPS][eta 01m:35s]
Jobs: 4 (f=4): [m(4)][21.7%][r=5865KiB/s,w=5921KiB/s][r=1466,w=1480 IOPS]Jobs: 4 (f=4): [m(4)][22.5%][r=132KiB/s,w=176KiB/s][r=33,w=44 IOPS][eta 01m:33s]
Jobs: 4 (f=4): [m(4)][23.3%][r=3696KiB/s,w=3600KiB/s][r=924,w=900 IOPS][eJobs: 4 (f=4): [m(4)][24.2%][r=5746KiB/s,w=6073KiB/s][r=1436,w=1518 IOPS][eta 01m:31s]
Jobs: 4 (f=4): [m(4)][25.0%][r=3263KiB/s,w=3191KiB/s][r=815,w=797 IOPS][eJobs: 4 (f=4): [m(4)][25.8%][eta 01m:29s]
Jobs: 4 (f=4): [m(4)][26.7%][r=518KiB/s,w=590KiB/s][r=129,w=147 IOPS][etaJobs: 4 (f=4): [m(4)][27.5%][r=4227KiB/s,w=4255KiB/s][r=1056,w=1063 IOPS][eta 01m:27s]
Jobs: 4 (f=4): [m(4)][28.3%][r=6310KiB/s,w=6006KiB/s][r=1577,w=1501 IOPS]Jobs: 4 (f=4): [m(4)][29.2%][r=5749KiB/s,w=5709KiB/s][r=1437,w=1427 IOPS][eta 01m:25s]
Jobs: 4 (f=4): [m(4)][30.0%][r=6038KiB/s,w=5821KiB/s][r=1509,w=1455 IOPS]Jobs: 4 (f=4): [m(4)][30.8%][r=5878KiB/s,w=6121KiB/s][r=1469,w=1530 IOPS][eta 01m:23s]
Jobs: 4 (f=4): [m(4)][31.7%][r=4837KiB/s,w=4785KiB/s][r=1209,w=1196 IOPS]Jobs: 4 (f=4): [m(4)][32.5%][r=1720KiB/s,w=1828KiB/s][r=430,w=457 IOPS][eta 01m:21s]
Jobs: 4 (f=4): [m(4)][33.3%][r=336KiB/s,w=308KiB/s][r=84,w=77 IOPS][eta 0Jobs: 4 (f=4): [m(4)][34.2%][r=44KiB/s,w=36KiB/s][r=11,w=9 IOPS][eta 01m:19s]
Jobs: 4 (f=4): [m(4)][35.0%][r=4576KiB/s,w=4388KiB/s][r=1144,w=1097 IOPS]Jobs: 4 (f=4): [m(4)][35.8%][eta 01m:17s]
Jobs: 4 (f=4): [m(4)][36.7%][r=1347KiB/s,w=1288KiB/s][r=336,w=322 IOPS][eta 01m:16s]
Jobs: 4 (f=4): [m(4)][37.5%][r=5934KiB/s,w=5776KiB/s][r=1483,w=1444 IOPS][eta 01m:15s]
Jobs: 4 (f=4): [m(4)][38.3%][r=4344KiB/s,w=4451KiB/s][r=1086,w=1112 IOPS][eta 01m:14s]
Jobs: 4 (f=4): [m(4)][39.2%][eta 01m:13s]
Jobs: 4 (f=4): [m(4)][40.0%][r=1142KiB/s,w=1083KiB/s][r=285,w=270 IOPS][eta 01m:12s]
Jobs: 4 (f=4): [m(4)][40.8%][r=4299KiB/s,w=4106KiB/s][r=1074,w=1026 IOPS][eta 01m:11s]
Jobs: 4 (f=4): [m(4)][41.7%][eta 01m:10s]
Jobs: 4 (f=4): [m(4)][42.5%][r=1413KiB/s,w=1525KiB/s][r=353,w=381 IOPS][eJobs: 4 (f=4): [m(4)][43.3%][r=5105KiB/s,w=5061KiB/s][r=1276,w=1265 IOPS][eta 01m:08s]
Jobs: 4 (f=4): [m(4)][45.0%][r=738KiB/s,w=798KiB/s][r=184,w=199 IOPS][eta 01m:06s]
Jobs: 4 (f=4): [m(4)][45.8%][r=3366KiB/s,w=3121KiB/s][r=841,w=780 IOPS][eJobs: 4 (f=4): [m(4)][46.7%][eta 01m:04s]
Jobs: 4 (f=4): [m(4)][47.5%][r=669KiB/s,w=605KiB/s][r=167,w=151 IOPS][etaJobs: 4 (f=4): [m(4)][48.3%][r=124KiB/s,w=156KiB/s][r=31,w=39 IOPS][eta 01m:02s]
Jobs: 4 (f=4): [m(4)][49.2%][eta 01m:01s]
Jobs: 4 (f=4): [m(4)][50.0%][r=5860KiB/s,w=5668KiB/s][r=1465,w=1417 IOPS]Jobs: 4 (f=4): [m(4)][50.8%][r=3755KiB/s,w=3951KiB/s][r=938,w=987 IOPS][eta 00m:59s]
Jobs: 4 (f=4): [m(4)][51.7%][r=4276KiB/s,w=4244KiB/s][r=1069,w=1061 IOPS]Jobs: 4 (f=4): [m(4)][52.5%][eta 00m:57s]
Jobs: 4 (f=4): [m(4)][53.3%][r=164KiB/s,w=256KiB/s][r=41,w=64 IOPS][eta 0Jobs: 4 (f=4): [m(4)][54.2%][r=5048KiB/s,w=5016KiB/s][r=1262,w=1254 IOPS][eta 00m:55s]
Jobs: 4 (f=4): [m(4)][55.0%][r=5559KiB/s,w=5439KiB/s][r=1389,w=1359 IOPS]Jobs: 4 (f=4): [m(4)][55.8%][r=5884KiB/s,w=5884KiB/s][r=1471,w=1471 IOPS][eta 00m:53s]
Jobs: 4 (f=4): [m(4)][56.7%][r=1829KiB/s,w=2006KiB/s][r=457,w=501 IOPS][eJobs: 4 (f=4): [m(4)][57.5%][eta 00m:51s]
Jobs: 4 (f=4): [m(4)][58.3%][r=816KiB/s,w=860KiB/s][r=204,w=215 IOPS][etaJobs: 4 (f=4): [m(4)][59.2%][r=5567KiB/s,w=5787KiB/s][r=1391,w=1446 IOPS][eta 00m:49s]
Jobs: 4 (f=4): [m(4)][60.0%][r=3375KiB/s,w=3343KiB/s][r=843,w=835 IOPS][eJobs: 4 (f=4): [m(4)][60.8%][eta 00m:47s]
Jobs: 4 (f=4): [m(4)][61.7%][r=2730KiB/s,w=2646KiB/s][r=682,w=661 IOPS][eta 00m:46s]
Jobs: 4 (f=4): [m(4)][62.5%][r=3603KiB/s,w=3787KiB/s][r=900,w=946 IOPS][eJobs: 4 (f=4): [m(4)][63.3%][eta 00m:44s]
Jobs: 4 (f=4): [m(4)][64.2%][r=316KiB/s,w=300KiB/s][r=79,w=75 IOPS][eta 0Jobs: 4 (f=4): [m(4)][65.0%][r=4549KiB/s,w=4613KiB/s][r=1137,w=1153 IOPS][eta 00m:42s]
Jobs: 4 (f=4): [m(4)][65.8%][r=5696KiB/s,w=5700KiB/s][r=1424,w=1425 IOPS]Jobs: 4 (f=4): [m(4)][66.7%][eta 00m:40s]
Jobs: 4 (f=4): [m(4)][67.5%][r=2594KiB/s,w=2502KiB/s][r=648,w=625 IOPS][eJobs: 4 (f=4): [m(4)][68.3%][r=5791KiB/s,w=5967KiB/s][r=1447,w=1491 IOPS][eta 00m:38s]
Jobs: 4 (f=4): [m(4)][69.2%][r=3183KiB/s,w=3330KiB/s][r=795,w=832 IOPS][eta 00m:37s]
Jobs: 4 (f=4): [m(4)][70.0%][r=770KiB/s,w=726KiB/s][r=192,w=181 IOPS][etaJobs: 4 (f=4): [m(4)][70.8%][eta 00m:35s]
Jobs: 4 (f=4): [m(4)][71.7%][r=1578KiB/s,w=1610KiB/s][r=394,w=402 IOPS][eJobs: 4 (f=4): [m(4)][72.5%][r=2960KiB/s,w=2920KiB/s][r=740,w=730 IOPS][eta 00m:33s]
Jobs: 4 (f=4): [m(4)][73.3%][r=2683KiB/s,w=2664KiB/s][r=670,w=666 IOPS][eta 00m:32s]
Jobs: 4 (f=4): [m(4)][74.2%][r=5270KiB/s,w=5318KiB/s][r=1317,w=1329 IOPS]Jobs: 4 (f=4): [m(4)][75.0%][eta 00m:30s]
Jobs: 4 (f=4): [m(4)][75.8%][r=255KiB/s,w=311KiB/s][r=63,w=77 IOPS][eta 00m:29s]
Jobs: 4 (f=4): [m(4)][76.7%][r=4894KiB/s,w=4830KiB/s][r=1223,w=1207 IOPS]Jobs: 4 (f=4): [m(4)][77.5%][eta 00m:27s]
Jobs: 4 (f=4): [m(4)][78.3%][r=1896KiB/s,w=1940KiB/s][r=474,w=485 IOPS][eJobs: 4 (f=4): [m(4)][79.2%][r=6184KiB/s,w=5775KiB/s][r=1546,w=1443 IOPS][eta 00m:25s]
Jobs: 4 (f=4): [m(4)][80.0%][r=3775KiB/s,w=3567KiB/s][r=943,w=891 IOPS][eJobs: 4 (f=4): [m(4)][80.8%][r=3662KiB/s,w=4076KiB/s][r=915,w=1019 IOPS][eta 00m:23s]
Jobs: 4 (f=4): [m(4)][81.7%][r=4794KiB/s,w=4766KiB/s][r=1198,w=1191 IOPS][eta 00m:22s]
Jobs: 4 (f=4): [m(4)][83.3%][r=578KiB/s,w=510KiB/s][r=144,w=127 IOPS][eta 00m:20s]
Jobs: 4 (f=4): [m(4)][84.2%][r=5818KiB/s,w=5822KiB/s][r=1454,w=1455 IOPS][eta 00m:19s]
Jobs: 4 (f=4): [m(4)][85.0%][r=4788KiB/s,w=4744KiB/s][r=1197,w=1186 IOPS]Jobs: 4 (f=4): [m(4)][85.8%][eta 00m:17s]
Jobs: 4 (f=4): [m(4)][86.7%][r=2118KiB/s,w=2226KiB/s][r=529,w=556 IOPS][eJobs: 4 (f=4): [m(4)][87.5%][r=4124KiB/s,w=4380KiB/s][r=1031,w=1095 IOPS][eta 00m:15s]
Jobs: 4 (f=4): [m(4)][88.3%][r=99KiB/s,w=99KiB/s][r=24,w=24 IOPS][eta 00m:14s]
Jobs: 4 (f=4): [m(4)][89.2%][r=998KiB/s,w=890KiB/s][r=249,w=222 IOPS][etaJobs: 4 (f=4): [m(4)][90.0%][r=3396KiB/s,w=3328KiB/s][r=849,w=832 IOPS][eta 00m:12s]
Jobs: 4 (f=4): [m(4)][90.8%][eta 00m:11s]
Jobs: 4 (f=4): [m(4)][91.7%][r=950KiB/s,w=1037KiB/s][r=237,w=259 IOPS][eta 00m:10s]
Jobs: 4 (f=4): [m(4)][92.5%][r=2969KiB/s,w=2965KiB/s][r=742,w=741 IOPS][eJobs: 4 (f=4): [m(4)][93.3%][eta 00m:08s]
Jobs: 4 (f=4): [m(4)][94.2%][r=1211KiB/s,w=1307KiB/s][r=302,w=326 IOPS][eJobs: 4 (f=4): [m(4)][95.0%][r=6082KiB/s,w=5949KiB/s][r=1520,w=1487 IOPS][eta 00m:06s]
Jobs: 4 (f=4): [m(4)][95.8%][r=4974KiB/s,w=5329KiB/s][r=1243,w=1332 IOPS][eta 00m:05s]
Jobs: 4 (f=4): [m(4)][97.5%][r=2106KiB/s,w=2152KiB/s][r=526,w=538 IOPS][eta 00m:03s]
Jobs: 4 (f=4): [m(4)][98.3%][r=1548KiB/s,w=1409KiB/s][r=387,w=352 IOPS][eta 00m:02s]
Jobs: 4 (f=4): [m(4)][99.2%][eta 00m:01s]
Jobs: 4 (f=4): [m(4)][100.0%][r=3607KiB/s,w=3587KiB/s][r=901,w=896 IOPS][eta 00m:00s]
Jobs: 4 (f=4): [m(4)][13.9%][r=3140KiB/s,w=2873KiB/s][r=785,w=718 IOPS][eta 12m:27s]
Jobs: 4 (f=4): [m(4)][13.9%][eta 12m:33s]
iops-test-job: (groupid=0, jobs=4): err= 0: pid=52506: Fri May 31 10:56:19 2024
  read: IOPS=599, BW=2397KiB/s (2454kB/s)(285MiB/121796msec)
    slat (nsec): min=0, max=17057k, avg=2723.39, stdev=74033.77
    clat (usec): min=1577, max=2109.9k, avg=53552.93, stdev=225044.43
     lat (usec): min=1579, max=2109.9k, avg=53555.66, stdev=225046.50
    clat percentiles (msec):
     |  1.00th=[   16],  5.00th=[   18], 10.00th=[   19], 20.00th=[   20],
     | 30.00th=[   21], 40.00th=[   21], 50.00th=[   22], 60.00th=[   23],
     | 70.00th=[   24], 80.00th=[   25], 90.00th=[   28], 95.00th=[   32],
     | 99.00th=[ 1838], 99.50th=[ 2022], 99.90th=[ 2039], 99.95th=[ 2039],
     | 99.99th=[ 2039]
   bw (  KiB/s): min=  116, max= 6721, per=100.00%, avg=3838.05, stdev=522.92, samples=604
   iops        : min=   26, max= 1679, avg=958.11, stdev=130.78, samples=604
  write: IOPS=602, BW=2410KiB/s (2467kB/s)(287MiB/121796msec); 0 zone resets
    slat (nsec): min=0, max=5415.0k, avg=2594.49, stdev=28118.76
    clat (usec): min=925, max=2109.9k, avg=51554.16, stdev=218532.32
     lat (usec): min=1208, max=2110.0k, avg=51556.75, stdev=218532.28
    clat percentiles (msec):
     |  1.00th=[   16],  5.00th=[   18], 10.00th=[   19], 20.00th=[   20],
     | 30.00th=[   21], 40.00th=[   21], 50.00th=[   22], 60.00th=[   23],
     | 70.00th=[   24], 80.00th=[   25], 90.00th=[   27], 95.00th=[   30],
     | 99.00th=[ 1821], 99.50th=[ 1989], 99.90th=[ 2022], 99.95th=[ 2039],
     | 99.99th=[ 2106]
   bw (  KiB/s): min=   36, max= 6614, per=100.00%, avg=3858.99, stdev=524.09, samples=604
   iops        : min=    6, max= 1652, avg=963.45, stdev=131.08, samples=604
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.05%, 20=27.68%, 50=69.25%
  lat (msec)   : 100=0.26%, 250=0.26%, 500=0.93%, 750=0.12%, 2000=0.95%
  lat (msec)   : >=2000=0.50%
  cpu          : usr=0.30%, sys=0.36%, ctx=132129, majf=0, minf=44
  IO depths    : 1=0.1%, 2=0.1%, 4=0.2%, 8=51.8%, 16=48.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.3%, 8=1.6%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=72977,73371,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=2397KiB/s (2454kB/s), 2397KiB/s-2397KiB/s (2454kB/s-2454kB/s), io=285MiB (299MB), run=121796-121796msec
  WRITE: bw=2410KiB/s (2467kB/s), 2410KiB/s-2410KiB/s (2467kB/s-2467kB/s), io=287MiB (301MB), run=121796-121796msec
```

## Throughput test: sequential read

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [R(1)][2.5%][r=109MiB/s][r=108 IOPS][eta 01m:58s]
Jobs: 1 (f=1): [R(1)][4.1%][r=109MiB/s][r=108 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [R(1)][5.0%][r=106MiB/s][r=106 IOPS][eta 01m:54s]
Jobs: 1 (f=1): [R(1)][6.6%][r=118MiB/s][r=117 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [R(1)][7.5%][r=119MiB/s][r=118 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [R(1)][9.1%][r=113MiB/s][r=112 IOPS][eta 01m:50s]
Jobs: 1 (f=1): [R(1)][10.7%][r=115MiB/s][r=115 IOPS][eta 01m:48s]
Jobs: 1 (f=1): [R(1)][11.6%][r=106MiB/s][r=105 IOPS][eta 01m:47s]
Jobs: 1 (f=1): [R(1)][12.4%][r=110MiB/s][r=110 IOPS][eta 01m:46s]
Jobs: 1 (f=1): [R(1)][13.2%][r=106MiB/s][r=106 IOPS][eta 01m:45s]
Jobs: 1 (f=1): [R(1)][14.9%][r=114MiB/s][r=113 IOPS][eta 01m:43s]
Jobs: 1 (f=1): [R(1)][16.5%][r=104MiB/s][r=104 IOPS][eta 01m:41s]
Jobs: 1 (f=1): [R(1)][17.4%][r=114MiB/s][r=113 IOPS][eta 01m:40s]
Jobs: 1 (f=1): [R(1)][19.0%][r=117MiB/s][r=117 IOPS][eta 01m:38s]
Jobs: 1 (f=1): [R(1)][20.7%][r=111MiB/s][r=110 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [R(1)][22.3%][r=111MiB/s][r=111 IOPS][eta 01m:34s]
Jobs: 1 (f=1): [R(1)][23.1%][r=113MiB/s][r=112 IOPS][eta 01m:33s]
Jobs: 1 (f=1): [R(1)][24.0%][r=107MiB/s][r=107 IOPS][eta 01m:32s]
Jobs: 1 (f=1): [R(1)][25.6%][r=106MiB/s][r=105 IOPS][eta 01m:30s]
Jobs: 1 (f=1): [R(1)][27.3%][r=112MiB/s][r=112 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [R(1)][28.9%][r=114MiB/s][r=114 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [R(1)][30.6%][r=113MiB/s][r=113 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [R(1)][31.4%][r=98.6MiB/s][r=98 IOPS][eta 01m:23s]
Jobs: 1 (f=1): [R(1)][33.1%][r=117MiB/s][r=116 IOPS][eta 01m:21s]
Jobs: 1 (f=1): [R(1)][34.7%][r=110MiB/s][r=110 IOPS][eta 01m:19s]
Jobs: 1 (f=1): [R(1)][35.5%][r=113MiB/s][r=112 IOPS][eta 01m:18s]
Jobs: 1 (f=1): [R(1)][37.2%][r=102MiB/s][r=102 IOPS][eta 01m:16s]
Jobs: 1 (f=1): [R(1)][39.2%][r=104MiB/s][r=104 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [R(1)][39.7%][r=119MiB/s][r=118 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [R(1)][41.3%][r=111MiB/s][r=110 IOPS][eta 01m:11s]
Jobs: 1 (f=1): [R(1)][42.1%][r=104MiB/s][r=103 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [R(1)][43.8%][r=108MiB/s][r=107 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [R(1)][45.5%][r=114MiB/s][r=113 IOPS][eta 01m:06s]
Jobs: 1 (f=1): [R(1)][47.1%][r=104MiB/s][r=103 IOPS][eta 01m:04s]
Jobs: 1 (f=1): [R(1)][47.9%][r=113MiB/s][r=112 IOPS][eta 01m:03s]
Jobs: 1 (f=1): [R(1)][48.8%][r=110MiB/s][r=110 IOPS][eta 01m:02s]
Jobs: 1 (f=1): [R(1)][49.6%][r=113MiB/s][r=112 IOPS][eta 01m:01s]
Jobs: 1 (f=1): [R(1)][50.4%][r=113MiB/s][r=112 IOPS][eta 01m:00s]
Jobs: 1 (f=1): [R(1)][51.2%][r=112MiB/s][r=111 IOPS][eta 00m:59s]
Jobs: 1 (f=1): [R(1)][52.5%][r=111MiB/s][r=111 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [R(1)][54.2%][r=115MiB/s][r=114 IOPS][eta 00m:55s]
Jobs: 1 (f=1): [R(1)][55.8%][r=112MiB/s][r=112 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [R(1)][57.5%][r=111MiB/s][r=111 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [R(1)][59.2%][r=109MiB/s][r=108 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [R(1)][60.8%][r=106MiB/s][r=106 IOPS][eta 00m:47s]
Jobs: 1 (f=1): [R(1)][62.5%][r=113MiB/s][r=113 IOPS][eta 00m:45s]
Jobs: 1 (f=1): [R(1)][63.3%][r=111MiB/s][r=110 IOPS][eta 00m:44s]
Jobs: 1 (f=1): [R(1)][65.0%][r=109MiB/s][r=108 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [R(1)][66.7%][r=110MiB/s][r=110 IOPS][eta 00m:40s]
Jobs: 1 (f=1): [R(1)][68.1%][r=115MiB/s][r=114 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][69.2%][r=109MiB/s][r=109 IOPS][eta 00m:37s]
Jobs: 1 (f=1): [R(1)][70.8%][r=109MiB/s][r=108 IOPS][eta 00m:35s]
Jobs: 1 (f=1): [R(1)][71.7%][r=109MiB/s][r=108 IOPS][eta 00m:34s]
Jobs: 1 (f=1): [R(1)][73.3%][r=113MiB/s][r=113 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [R(1)][75.0%][r=116MiB/s][r=115 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [R(1)][75.8%][r=106MiB/s][r=105 IOPS][eta 00m:29s]
Jobs: 1 (f=1): [R(1)][77.3%][r=113MiB/s][r=112 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [R(1)][78.3%][r=113MiB/s][r=112 IOPS][eta 00m:26s]
Jobs: 1 (f=1): [R(1)][80.0%][r=116MiB/s][r=115 IOPS][eta 00m:24s]
Jobs: 1 (f=1): [R(1)][81.7%][r=119MiB/s][r=118 IOPS][eta 00m:22s]
Jobs: 1 (f=1): [R(1)][83.3%][r=111MiB/s][r=111 IOPS][eta 00m:20s]
Jobs: 1 (f=1): [R(1)][85.0%][r=108MiB/s][r=107 IOPS][eta 00m:18s]
Jobs: 1 (f=1): [R(1)][85.8%][r=115MiB/s][r=114 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [R(1)][87.5%][r=118MiB/s][r=118 IOPS][eta 00m:15s]
Jobs: 1 (f=1): [R(1)][89.2%][r=110MiB/s][r=110 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [R(1)][90.8%][r=109MiB/s][r=108 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [R(1)][92.5%][r=108MiB/s][r=108 IOPS][eta 00m:09s]
Jobs: 1 (f=1): [R(1)][93.3%][r=117MiB/s][r=116 IOPS][eta 00m:08s]
Jobs: 1 (f=1): [R(1)][95.0%][r=111MiB/s][r=111 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [R(1)][95.8%][r=112MiB/s][r=111 IOPS][eta 00m:05s]
Jobs: 1 (f=1): [R(1)][97.5%][r=115MiB/s][r=114 IOPS][eta 00m:03s]
Jobs: 1 (f=1): [R(1)][99.2%][r=118MiB/s][r=118 IOPS][eta 00m:01s]
Jobs: 1 (f=1): [R(1)][100.0%][r=103MiB/s][r=102 IOPS][eta 00m:00s]
Jobs: 1 (f=1): [R(1)][100.0%][r=110MiB/s][r=110 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=52730: Fri May 31 10:58:41 2024
  read: IOPS=110, BW=111MiB/s (116MB/s)(13.0GiB/120081msec)
    slat (nsec): min=0, max=19334k, avg=8527.73, stdev=232853.77
    clat (msec): min=35, max=270, avg=144.29, stdev=16.99
     lat (msec): min=35, max=270, avg=144.30, stdev=16.98
    clat percentiles (msec):
     |  1.00th=[   79],  5.00th=[  100], 10.00th=[  134], 20.00th=[  142],
     | 30.00th=[  144], 40.00th=[  144], 50.00th=[  150], 60.00th=[  153],
     | 70.00th=[  153], 80.00th=[  153], 90.00th=[  155], 95.00th=[  159],
     | 99.00th=[  171], 99.50th=[  178], 99.90th=[  197], 99.95th=[  207],
     | 99.99th=[  253]
   bw (  KiB/s): min=99753, max=130031, per=100.00%, avg=113594.90, stdev=7282.25, samples=238
   iops        : min=   97, max=  126, avg=110.42, stdev= 7.17, samples=238
  lat (msec)   : 50=0.01%, 100=5.17%, 250=94.80%, 500=0.02%
  cpu          : usr=0.14%, sys=0.15%, ctx=15193, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.3%, 16=52.6%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=97.1%, 8=2.4%, 16=0.5%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=13308,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=111MiB/s (116MB/s), 111MiB/s-111MiB/s (116MB/s-116MB/s), io=13.0GiB (14.0GB), run=120081-120081msec
```

## Throughput test: sequential write

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [W(1)][3.3%][w=96.7MiB/s][w=96 IOPS][eta 01m:57s]
Jobs: 1 (f=1): [W(1)][5.0%][w=103MiB/s][w=102 IOPS][eta 01m:55s]
Jobs: 1 (f=1): [W(1)][6.6%][w=101MiB/s][w=101 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [W(1)][8.3%][w=101MiB/s][w=100 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [W(1)][9.2%][w=98.1MiB/s][w=98 IOPS][eta 01m:49s]
Jobs: 1 (f=1): [W(1)][10.0%][w=101MiB/s][w=100 IOPS][eta 01m:48s]
Jobs: 1 (f=1): [W(1)][11.7%][w=101MiB/s][w=101 IOPS][eta 01m:46s]
Jobs: 1 (f=1): [W(1)][13.3%][w=101MiB/s][w=101 IOPS][eta 01m:44s]
Jobs: 1 (f=1): [W(1)][15.0%][w=85.2MiB/s][w=85 IOPS][eta 01m:42s]
Jobs: 1 (f=1): [W(1)][16.7%][w=103MiB/s][w=103 IOPS][eta 01m:40s]
Jobs: 1 (f=1): [W(1)][18.2%][w=101MiB/s][w=100 IOPS][eta 01m:39s]
Jobs: 1 (f=1): [W(1)][19.0%][w=104MiB/s][w=103 IOPS][eta 01m:38s]
Jobs: 1 (f=1): [W(1)][20.0%][w=102MiB/s][w=102 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [W(1)][22.3%][w=97.3MiB/s][w=97 IOPS][eta 01m:34s]
Jobs: 1 (f=1): [W(1)][24.0%][w=100MiB/s][w=100 IOPS][eta 01m:32s]
Jobs: 1 (f=1): [W(1)][25.6%][eta 01m:30s]
Jobs: 1 (f=1): [W(1)][26.7%][eta 01m:28s]
Jobs: 1 (f=1): [W(1)][28.3%][w=101MiB/s][w=100 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [W(1)][28.9%][w=99.9MiB/s][w=99 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [W(1)][30.6%][w=100MiB/s][w=100 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [W(1)][32.2%][w=99.1MiB/s][w=99 IOPS][eta 01m:22s]
Jobs: 1 (f=1): [W(1)][33.1%][w=101MiB/s][w=100 IOPS][eta 01m:21s]
Jobs: 1 (f=1): [W(1)][34.7%][w=100MiB/s][w=100 IOPS][eta 01m:19s]
Jobs: 1 (f=1): [W(1)][35.5%][w=90.7MiB/s][w=90 IOPS][eta 01m:18s]
Jobs: 1 (f=1): [W(1)][37.2%][w=104MiB/s][w=104 IOPS][eta 01m:16s]
Jobs: 1 (f=1): [W(1)][39.2%][w=104MiB/s][w=103 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][40.5%][w=94.9MiB/s][w=94 IOPS][eta 01m:12s]
Jobs: 1 (f=1): [W(1)][41.3%][w=99.9MiB/s][w=99 IOPS][eta 01m:11s]
Jobs: 1 (f=1): [W(1)][43.0%][w=99.0MiB/s][w=99 IOPS][eta 01m:09s]
Jobs: 1 (f=1): [W(1)][44.6%][w=101MiB/s][w=100 IOPS][eta 01m:07s]
Jobs: 1 (f=1): [W(1)][46.3%][eta 01m:05s]
Jobs: 1 (f=1): [W(1)][47.9%][eta 01m:03s]
Jobs: 1 (f=1): [W(1)][48.8%][w=26.0MiB/s][w=25 IOPS][eta 01m:02s]
Jobs: 1 (f=1): [W(1)][50.4%][w=100MiB/s][w=100 IOPS][eta 01m:00s]
Jobs: 1 (f=1): [W(1)][52.5%][w=103MiB/s][w=102 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [W(1)][53.7%][w=106MiB/s][w=106 IOPS][eta 00m:56s]
Jobs: 1 (f=1): [W(1)][55.8%][w=103MiB/s][w=103 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [W(1)][57.0%][w=103MiB/s][w=102 IOPS][eta 00m:52s]
Jobs: 1 (f=1): [W(1)][57.9%][w=107MiB/s][w=106 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [W(1)][59.2%][w=102MiB/s][w=101 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [W(1)][59.5%][w=105MiB/s][w=105 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [W(1)][60.3%][w=105MiB/s][w=105 IOPS][eta 00m:48s]
Jobs: 1 (f=1): [W(1)][61.2%][w=105MiB/s][w=105 IOPS][eta 00m:47s]
Jobs: 1 (f=1): [W(1)][62.0%][w=105MiB/s][w=105 IOPS][eta 00m:46s]
Jobs: 1 (f=1): [W(1)][62.8%][w=102MiB/s][w=101 IOPS][eta 00m:45s]
Jobs: 1 (f=1): [W(1)][65.0%][w=106MiB/s][w=106 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][65.3%][w=106MiB/s][w=105 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][66.9%][w=105MiB/s][w=105 IOPS][eta 00m:40s]
Jobs: 1 (f=1): [W(1)][68.6%][w=99.9MiB/s][w=99 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [W(1)][70.2%][w=103MiB/s][w=103 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [W(1)][71.9%][w=102MiB/s][w=102 IOPS][eta 00m:34s]
Jobs: 1 (f=1): [W(1)][73.6%][w=103MiB/s][w=103 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [W(1)][74.4%][w=105MiB/s][w=104 IOPS][eta 00m:31s]
Jobs: 1 (f=1): [W(1)][76.0%][w=102MiB/s][w=102 IOPS][eta 00m:29s]
Jobs: 1 (f=1): [W(1)][77.7%][w=105MiB/s][w=104 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [W(1)][79.3%][w=103MiB/s][w=103 IOPS][eta 00m:25s]
Jobs: 1 (f=1): [W(1)][81.0%][w=104MiB/s][w=104 IOPS][eta 00m:23s]
Jobs: 1 (f=1): [W(1)][81.8%][w=26.9MiB/s][w=26 IOPS][eta 00m:22s]
Jobs: 1 (f=1): [W(1)][83.5%][w=46.4MiB/s][w=46 IOPS][eta 00m:20s]
Jobs: 1 (f=1): [W(1)][85.1%][w=104MiB/s][w=103 IOPS][eta 00m:18s]
Jobs: 1 (f=1): [W(1)][86.8%][w=106MiB/s][w=106 IOPS][eta 00m:16s]
Jobs: 1 (f=1): [W(1)][88.4%][w=102MiB/s][w=101 IOPS][eta 00m:14s]
Jobs: 1 (f=1): [W(1)][90.1%][w=105MiB/s][w=105 IOPS][eta 00m:12s]
Jobs: 1 (f=1): [W(1)][90.9%][w=107MiB/s][w=106 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [W(1)][92.6%][w=101MiB/s][w=101 IOPS][eta 00m:09s]
Jobs: 1 (f=1): [W(1)][94.2%][w=105MiB/s][w=105 IOPS][eta 00m:07s]
Jobs: 1 (f=1): [W(1)][95.0%][w=102MiB/s][w=101 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [W(1)][95.9%][w=105MiB/s][w=104 IOPS][eta 00m:05s]
Jobs: 1 (f=1): [W(1)][97.5%][w=84.1MiB/s][w=84 IOPS][eta 00m:03s]
Jobs: 1 (f=1): [W(1)][99.2%][w=103MiB/s][w=102 IOPS][eta 00m:01s]
Jobs: 1 (f=1): [W(1)][100.0%][eta 00m:00s]
Jobs: 1 (f=1): [W(1)][100.0%][w=3068KiB/s][w=2 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=53520: Fri May 31 11:10:43 2024
  write: IOPS=90, BW=90.9MiB/s (95.3MB/s)(10.9GiB/123084msec); 0 zone resets
    slat (nsec): min=0, max=14775k, avg=29544.75, stdev=224113.66
    clat (msec): min=67, max=4263, avg=175.72, stdev=223.73
     lat (msec): min=67, max=4263, avg=175.75, stdev=223.73
    clat percentiles (msec):
     |  1.00th=[   96],  5.00th=[  114], 10.00th=[  124], 20.00th=[  133],
     | 30.00th=[  138], 40.00th=[  144], 50.00th=[  150], 60.00th=[  159],
     | 70.00th=[  165], 80.00th=[  180], 90.00th=[  203], 95.00th=[  232],
     | 99.00th=[  414], 99.50th=[ 1905], 99.90th=[ 4111], 99.95th=[ 4178],
     | 99.99th=[ 4212]
   bw (  KiB/s): min= 6095, max=117841, per=100.00%, avg=101144.24, stdev=15801.40, samples=225
   iops        : min=    5, max=  115, avg=98.28, stdev=15.48, samples=225
  lat (msec)   : 100=1.31%, 250=95.01%, 500=2.79%, 750=0.03%, 1000=0.14%
  lat (msec)   : 2000=0.29%, >=2000=0.43%
  cpu          : usr=0.37%, sys=0.14%, ctx=13511, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.3%, 16=52.7%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.1%, 8=0.9%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,11185,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=90.9MiB/s (95.3MB/s), 90.9MiB/s-90.9MiB/s (95.3MB/s-95.3MB/s), io=10.9GiB (11.7GB), run=123084-123084msec
```
