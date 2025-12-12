# 性能测试

`posixaio`是macOS的异步读写库，如果在Linux下运行测试，请改为`libaio`。

## IOPS test: random read/write

```sh
sudo fio --filename=./fio-test.bin --size=1GB --direct=1 --rw=randrw --bs=4k --ioengine=posixaio --iodepth=256 --runtime=120 --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1
```

```sh
iops-test-job: Laying out IO file (1 file / 1024MiB)
Jobs: 4 (f=4): [m(4)][2.5%][r=35.8MiB/s,w=36.1MiB/s][r=9156,w=9245 IOPS][eta 01m:57s]
Jobs: 4 (f=4): [m(4)][3.3%][r=35.9MiB/s,w=35.4MiB/s][r=9196,w=9074 IOPS][eta 01m:56s]
Jobs: 4 (f=4): [m(4)][5.0%][r=34.1MiB/s,w=34.7MiB/s][r=8731,w=8879 IOPS][eta 01m:54s]
Jobs: 4 (f=4): [m(4)][6.7%][r=33.7MiB/s,w=33.5MiB/s][r=8635,w=8565 IOPS][eta 01m:52s]
Jobs: 4 (f=4): [m(4)][7.5%][r=32.8MiB/s,w=33.3MiB/s][r=8386,w=8527 IOPS][eta 01m:51s]
Jobs: 4 (f=4): [m(4)][9.2%][r=32.9MiB/s,w=32.7MiB/s][r=8414,w=8381 IOPS][eta 01m:49s]
Jobs: 4 (f=4): [m(4)][10.0%][r=31.8MiB/s,w=32.1MiB/s][r=8148,w=8228 IOPS][eta 01m:48s]
Jobs: 4 (f=4): [m(4)][11.7%][r=31.5MiB/s,w=31.9MiB/s][r=8057,w=8159 IOPS][eta 01m:46s]
Jobs: 4 (f=4): [m(4)][12.5%][r=31.2MiB/s,w=31.7MiB/s][r=7989,w=8112 IOPS][eta 01m:45s]
Jobs: 4 (f=4): [m(4)][14.2%][r=31.7MiB/s,w=30.7MiB/s][r=8108,w=7862 IOPS][eta 01m:43s]
Jobs: 4 (f=4): [m(4)][15.8%][r=27.2MiB/s,w=27.0MiB/s][r=6961,w=6913 IOPS][eta 01m:41s]
Jobs: 4 (f=4): [m(4)][16.7%][r=31.4MiB/s,w=30.8MiB/s][r=8049,w=7891 IOPS][eta 01m:40s]
Jobs: 4 (f=4): [m(4)][18.3%][r=30.7MiB/s,w=31.0MiB/s][r=7860,w=7925 IOPS][eta 01m:38s]
Jobs: 4 (f=4): [m(4)][20.0%][r=31.2MiB/s,w=31.3MiB/s][r=7988,w=8018 IOPS][eta 01m:36s]
Jobs: 4 (f=4): [m(4)][21.7%][r=30.8MiB/s,w=31.3MiB/s][r=7877,w=8009 IOPS][eta 01m:34s]
Jobs: 4 (f=4): [m(4)][23.3%][r=31.1MiB/s,w=30.7MiB/s][r=7968,w=7868 IOPS][eta 01m:32s]
Jobs: 4 (f=4): [m(4)][25.0%][r=31.0MiB/s,w=31.1MiB/s][r=7944,w=7968 IOPS][eta 01m:30s]
Jobs: 4 (f=4): [m(4)][26.7%][r=31.2MiB/s,w=30.9MiB/s][r=7996,w=7911 IOPS][eta 01m:28s]
Jobs: 4 (f=4): [m(4)][28.3%][r=31.2MiB/s,w=31.3MiB/s][r=7993,w=8004 IOPS][eta 01m:26s]
Jobs: 4 (f=4): [m(4)][30.0%][r=31.3MiB/s,w=31.3MiB/s][r=8020,w=8013 IOPS][eta 01m:24s]
Jobs: 4 (f=4): [m(4)][30.8%][r=28.2MiB/s,w=28.3MiB/s][r=7226,w=7256 IOPS][eta 01m:23s]
Jobs: 4 (f=4): [m(4)][32.5%][r=27.6MiB/s,w=27.6MiB/s][r=7076,w=7078 IOPS][eta 01m:21s]
Jobs: 4 (f=4): [m(4)][34.2%][r=26.8MiB/s,w=27.4MiB/s][r=6848,w=7014 IOPS][eta 01m:19s]
Jobs: 4 (f=4): [m(4)][35.8%][r=29.5MiB/s,w=29.3MiB/s][r=7540,w=7510 IOPS][eta 01m:17s]
Jobs: 4 (f=4): [m(4)][37.5%][r=30.2MiB/s,w=30.3MiB/s][r=7730,w=7769 IOPS][eta 01m:15s]
Jobs: 4 (f=4): [m(4)][38.7%][r=29.6MiB/s,w=29.4MiB/s][r=7573,w=7533 IOPS][eta 01m:13s]
Jobs: 4 (f=4): [m(4)][40.0%][r=30.0MiB/s,w=29.6MiB/s][r=7669,w=7586 IOPS][eta 01m:12s]
Jobs: 4 (f=4): [m(4)][40.8%][r=24.1MiB/s,w=24.5MiB/s][r=6174,w=6276 IOPS][eta 01m:11s]
Jobs: 4 (f=4): [m(4)][42.5%][r=29.4MiB/s,w=29.8MiB/s][r=7538,w=7631 IOPS][eta 01m:09s]
Jobs: 4 (f=4): [m(4)][44.2%][r=31.1MiB/s,w=30.6MiB/s][r=7974,w=7836 IOPS][eta 01m:07s]
Jobs: 4 (f=4): [m(4)][45.8%][r=31.1MiB/s,w=30.8MiB/s][r=7966,w=7889 IOPS][eta 01m:05s]
Jobs: 4 (f=4): [m(4)][47.5%][r=30.9MiB/s,w=30.7MiB/s][r=7918,w=7860 IOPS][eta 01m:03s]
Jobs: 4 (f=4): [m(4)][49.2%][r=26.7MiB/s,w=27.3MiB/s][r=6834,w=6995 IOPS][eta 01m:01s]
Jobs: 4 (f=4): [m(4)][50.8%][r=30.3MiB/s,w=30.8MiB/s][r=7749,w=7880 IOPS][eta 00m:59s]
Jobs: 4 (f=4): [m(4)][52.5%][r=30.1MiB/s,w=30.9MiB/s][r=7697,w=7915 IOPS][eta 00m:57s]
Jobs: 4 (f=4): [m(4)][54.2%][r=29.7MiB/s,w=30.9MiB/s][r=7594,w=7913 IOPS][eta 00m:55s]
Jobs: 4 (f=4): [m(4)][55.5%][r=22.7MiB/s,w=23.1MiB/s][r=5819,w=5925 IOPS][eta 00m:53s]
Jobs: 4 (f=4): [m(4)][56.7%][r=29.2MiB/s,w=29.4MiB/s][r=7485,w=7535 IOPS][eta 00m:52s]
Jobs: 4 (f=4): [m(4)][58.8%][r=31.0MiB/s,w=31.0MiB/s][r=7923,w=7926 IOPS][eta 00m:49s]
Jobs: 4 (f=4): [m(4)][59.2%][r=31.1MiB/s,w=30.8MiB/s][r=7970,w=7890 IOPS][eta 00m:49s]
Jobs: 4 (f=4): [m(4)][60.0%][r=31.3MiB/s,w=30.9MiB/s][r=8003,w=7916 IOPS][eta 00m:48s]
Jobs: 4 (f=4): [m(4)][60.8%][r=31.0MiB/s,w=31.1MiB/s][r=7924,w=7972 IOPS][eta 00m:47s]
Jobs: 4 (f=4): [m(4)][61.7%][r=30.9MiB/s,w=30.8MiB/s][r=7903,w=7877 IOPS][eta 00m:46s]
Jobs: 4 (f=4): [m(4)][62.5%][r=30.8MiB/s,w=31.1MiB/s][r=7876,w=7950 IOPS][eta 00m:45s]
Jobs: 4 (f=4): [m(4)][64.7%][r=30.3MiB/s,w=31.4MiB/s][r=7766,w=8036 IOPS][eta 00m:42s]
Jobs: 4 (f=4): [m(4)][65.0%][r=31.4MiB/s,w=31.0MiB/s][r=8038,w=7939 IOPS][eta 00m:42s]
Jobs: 4 (f=4): [m(4)][65.8%][r=27.4MiB/s,w=27.5MiB/s][r=7024,w=7031 IOPS][eta 00m:41s]
Jobs: 4 (f=4): [m(4)][68.1%][r=30.6MiB/s,w=31.2MiB/s][r=7842,w=7985 IOPS][eta 00m:38s]
Jobs: 4 (f=4): [m(4)][69.2%][r=30.4MiB/s,w=31.3MiB/s][r=7782,w=8007 IOPS][eta 00m:37s]
Jobs: 4 (f=4): [m(4)][70.8%][r=31.1MiB/s,w=31.1MiB/s][r=7953,w=7972 IOPS][eta 00m:35s]
Jobs: 4 (f=4): [m(4)][72.5%][r=30.6MiB/s,w=31.3MiB/s][r=7835,w=8013 IOPS][eta 00m:33s]
Jobs: 4 (f=4): [m(4)][74.2%][r=31.0MiB/s,w=30.8MiB/s][r=7923,w=7895 IOPS][eta 00m:31s]
Jobs: 4 (f=4): [m(4)][75.8%][r=31.3MiB/s,w=30.8MiB/s][r=8012,w=7886 IOPS][eta 00m:29s]
Jobs: 4 (f=4): [m(4)][77.3%][r=31.4MiB/s,w=30.4MiB/s][r=8041,w=7788 IOPS][eta 00m:27s]
Jobs: 4 (f=4): [m(4)][78.3%][r=30.5MiB/s,w=31.5MiB/s][r=7805,w=8060 IOPS][eta 00m:26s]
Jobs: 4 (f=4): [m(4)][80.0%][r=30.9MiB/s,w=30.9MiB/s][r=7922,w=7913 IOPS][eta 00m:24s]
Jobs: 4 (f=4): [m(4)][81.7%][r=31.5MiB/s,w=30.9MiB/s][r=8062,w=7917 IOPS][eta 00m:22s]
Jobs: 4 (f=4): [m(4)][82.5%][r=30.0MiB/s,w=31.1MiB/s][r=7686,w=7959 IOPS][eta 00m:21s]
Jobs: 4 (f=4): [m(4)][84.2%][r=30.9MiB/s,w=30.7MiB/s][r=7905,w=7868 IOPS][eta 00m:19s]
Jobs: 4 (f=4): [m(4)][85.8%][r=31.4MiB/s,w=30.4MiB/s][r=8039,w=7786 IOPS][eta 00m:17s]
Jobs: 4 (f=4): [m(4)][86.7%][r=29.7MiB/s,w=31.0MiB/s][r=7608,w=7924 IOPS][eta 00m:16s]
Jobs: 4 (f=4): [m(4)][88.3%][r=30.7MiB/s,w=31.1MiB/s][r=7855,w=7957 IOPS][eta 00m:14s]
Jobs: 4 (f=4): [m(4)][89.2%][r=31.0MiB/s,w=31.0MiB/s][r=7945,w=7946 IOPS][eta 00m:13s]
Jobs: 4 (f=4): [m(4)][90.8%][r=31.0MiB/s,w=30.4MiB/s][r=7945,w=7786 IOPS][eta 00m:11s]
Jobs: 4 (f=4): [m(4)][92.5%][r=31.4MiB/s,w=30.7MiB/s][r=8045,w=7852 IOPS][eta 00m:09s]
Jobs: 4 (f=4): [m(4)][94.2%][r=31.0MiB/s,w=30.9MiB/s][r=7948,w=7917 IOPS][eta 00m:07s]
Jobs: 4 (f=4): [m(4)][95.8%][r=30.6MiB/s,w=31.3MiB/s][r=7831,w=8002 IOPS][eta 00m:05s]
Jobs: 4 (f=4): [m(4)][97.5%][r=31.4MiB/s,w=30.9MiB/s][r=8047,w=7912 IOPS][eta 00m:03s]
Jobs: 4 (f=4): [m(4)][99.2%][r=30.7MiB/s,w=31.4MiB/s][r=7849,w=8028 IOPS][eta 00m:01s]
Jobs: 4 (f=4): [m(4)][100.0%][r=31.7MiB/s,w=30.8MiB/s][r=8123,w=7883 IOPS][eta 00m:00s]
iops-test-job: (groupid=0, jobs=4): err= 0: pid=60709: Fri May 31 13:37:48 2024
  read: IOPS=7875, BW=30.8MiB/s (32.3MB/s)(3692MiB/120005msec)
    slat (nsec): min=0, max=35821k, avg=1293.90, stdev=92319.27
    clat (usec): min=7, max=93431, avg=4006.27, stdev=1140.84
     lat (usec): min=152, max=93431, avg=4007.56, stdev=1146.39
    clat percentiles (usec):
     |  1.00th=[ 2900],  5.00th=[ 3326], 10.00th=[ 3458], 20.00th=[ 3621],
     | 30.00th=[ 3720], 40.00th=[ 3785], 50.00th=[ 3884], 60.00th=[ 3949],
     | 70.00th=[ 4047], 80.00th=[ 4178], 90.00th=[ 4490], 95.00th=[ 5211],
     | 99.00th=[ 6718], 99.50th=[ 7504], 99.90th=[14484], 99.95th=[21627],
     | 99.99th=[47973]
   bw (  KiB/s): min=19004, max=39190, per=100.00%, avg=31527.91, stdev=559.85, samples=952
   iops        : min= 4750, max= 9796, avg=7880.63, stdev=139.95, samples=952
  write: IOPS=7885, BW=30.8MiB/s (32.3MB/s)(3697MiB/120005msec); 0 zone resets
    slat (nsec): min=0, max=48638k, avg=1355.58, stdev=83459.77
    clat (usec): min=7, max=93755, avg=4094.79, stdev=1218.53
     lat (usec): min=95, max=93756, avg=4096.15, stdev=1220.82
    clat percentiles (usec):
     |  1.00th=[ 2933],  5.00th=[ 3359], 10.00th=[ 3523], 20.00th=[ 3654],
     | 30.00th=[ 3752], 40.00th=[ 3851], 50.00th=[ 3949], 60.00th=[ 4015],
     | 70.00th=[ 4113], 80.00th=[ 4293], 90.00th=[ 4686], 95.00th=[ 5538],
     | 99.00th=[ 6849], 99.50th=[ 7701], 99.90th=[15795], 99.95th=[21627],
     | 99.99th=[53740]
   bw (  KiB/s): min=19545, max=40806, per=100.00%, avg=31566.10, stdev=552.26, samples=952
   iops        : min= 4884, max=10200, avg=7890.22, stdev=138.08, samples=952
  lat (usec)   : 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=0.01%
  lat (usec)   : 500=0.01%, 750=0.02%, 1000=0.03%
  lat (msec)   : 2=0.12%, 4=61.01%, 10=38.57%, 20=0.17%, 50=0.05%
  lat (msec)   : 100=0.01%
  cpu          : usr=1.28%, sys=1.33%, ctx=2244987, majf=0, minf=39
  IO depths    : 1=0.1%, 2=0.1%, 4=0.2%, 8=48.5%, 16=51.1%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.8%, 8=1.2%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=945103,946306,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=30.8MiB/s (32.3MB/s), 30.8MiB/s-30.8MiB/s (32.3MB/s-32.3MB/s), io=3692MiB (3871MB), run=120005-120005msec
  WRITE: bw=30.8MiB/s (32.3MB/s), 30.8MiB/s-30.8MiB/s (32.3MB/s-32.3MB/s), io=3697MiB (3876MB), run=120005-120005msec
```

## Throughput test: sequential read

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=read --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [R(1)][2.5%][r=870MiB/s][r=869 IOPS][eta 01m:57s]
Jobs: 1 (f=1): [R(1)][3.3%][r=865MiB/s][r=865 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [R(1)][5.0%][r=864MiB/s][r=864 IOPS][eta 01m:55s]
Jobs: 1 (f=1): [R(1)][6.6%][r=862MiB/s][r=862 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [R(1)][7.5%][r=863MiB/s][r=862 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [R(1)][9.1%][r=864MiB/s][r=863 IOPS][eta 01m:50s]
Jobs: 1 (f=1): [R(1)][10.7%][r=855MiB/s][r=855 IOPS][eta 01m:48s]
Jobs: 1 (f=1): [R(1)][12.4%][r=862MiB/s][r=862 IOPS][eta 01m:46s]
Jobs: 1 (f=1): [R(1)][14.0%][r=861MiB/s][r=861 IOPS][eta 01m:44s]
Jobs: 1 (f=1): [R(1)][15.7%][r=850MiB/s][r=849 IOPS][eta 01m:42s]
Jobs: 1 (f=1): [R(1)][16.5%][r=861MiB/s][r=861 IOPS][eta 01m:41s]
Jobs: 1 (f=1): [R(1)][18.2%][r=857MiB/s][r=857 IOPS][eta 01m:39s]
Jobs: 1 (f=1): [R(1)][19.0%][r=862MiB/s][r=862 IOPS][eta 01m:38s]
Jobs: 1 (f=1): [R(1)][20.7%][r=863MiB/s][r=863 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [R(1)][21.5%][r=862MiB/s][r=862 IOPS][eta 01m:35s]
Jobs: 1 (f=1): [R(1)][23.1%][r=866MiB/s][r=866 IOPS][eta 01m:33s]
Jobs: 1 (f=1): [R(1)][24.8%][r=865MiB/s][r=865 IOPS][eta 01m:31s]
Jobs: 1 (f=1): [R(1)][26.7%][r=860MiB/s][r=860 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [R(1)][28.3%][r=855MiB/s][r=855 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [R(1)][30.0%][r=864MiB/s][r=863 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [R(1)][30.6%][r=862MiB/s][r=862 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [R(1)][31.4%][r=861MiB/s][r=861 IOPS][eta 01m:23s]
Jobs: 1 (f=1): [R(1)][33.1%][r=860MiB/s][r=859 IOPS][eta 01m:21s]
Jobs: 1 (f=1): [R(1)][34.7%][r=860MiB/s][r=859 IOPS][eta 01m:19s]
Jobs: 1 (f=1): [R(1)][35.5%][r=864MiB/s][r=864 IOPS][eta 01m:18s]
Jobs: 1 (f=1): [R(1)][37.2%][r=862MiB/s][r=861 IOPS][eta 01m:16s]
Jobs: 1 (f=1): [R(1)][38.0%][r=862MiB/s][r=862 IOPS][eta 01m:15s]
Jobs: 1 (f=1): [R(1)][39.7%][r=863MiB/s][r=862 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [R(1)][40.8%][r=860MiB/s][r=860 IOPS][eta 01m:11s]
Jobs: 1 (f=1): [R(1)][41.7%][r=863MiB/s][r=862 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [R(1)][42.5%][r=861MiB/s][r=861 IOPS][eta 01m:09s]
Jobs: 1 (f=1): [R(1)][43.3%][r=863MiB/s][r=862 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [R(1)][44.6%][r=860MiB/s][r=860 IOPS][eta 01m:07s]
Jobs: 1 (f=1): [R(1)][45.5%][r=864MiB/s][r=864 IOPS][eta 01m:06s]
Jobs: 1 (f=1): [R(1)][46.3%][r=862MiB/s][r=861 IOPS][eta 01m:05s]
Jobs: 1 (f=1): [R(1)][47.1%][r=858MiB/s][r=858 IOPS][eta 01m:04s]
Jobs: 1 (f=1): [R(1)][48.8%][r=860MiB/s][r=860 IOPS][eta 01m:02s]
Jobs: 1 (f=1): [R(1)][50.4%][r=861MiB/s][r=860 IOPS][eta 01m:00s]
Jobs: 1 (f=1): [R(1)][51.2%][r=864MiB/s][r=864 IOPS][eta 00m:59s]
Jobs: 1 (f=1): [R(1)][52.5%][r=862MiB/s][r=861 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [R(1)][53.7%][r=864MiB/s][r=864 IOPS][eta 00m:56s]
Jobs: 1 (f=1): [R(1)][55.8%][r=863MiB/s][r=863 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [R(1)][57.0%][r=862MiB/s][r=862 IOPS][eta 00m:52s]
Jobs: 1 (f=1): [R(1)][57.9%][r=861MiB/s][r=861 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [R(1)][59.2%][r=863MiB/s][r=863 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [R(1)][60.3%][r=859MiB/s][r=858 IOPS][eta 00m:48s]
Jobs: 1 (f=1): [R(1)][62.0%][r=862MiB/s][r=862 IOPS][eta 00m:46s]
Jobs: 1 (f=1): [R(1)][62.8%][r=861MiB/s][r=861 IOPS][eta 00m:45s]
Jobs: 1 (f=1): [R(1)][65.0%][r=863MiB/s][r=863 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [R(1)][66.1%][r=861MiB/s][r=861 IOPS][eta 00m:41s]
Jobs: 1 (f=1): [R(1)][68.3%][r=861MiB/s][r=861 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][68.6%][r=862MiB/s][r=861 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [R(1)][70.2%][r=861MiB/s][r=860 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [R(1)][71.1%][r=857MiB/s][r=857 IOPS][eta 00m:35s]
Jobs: 1 (f=1): [R(1)][72.7%][r=860MiB/s][r=860 IOPS][eta 00m:33s]
Jobs: 1 (f=1): [R(1)][74.4%][r=861MiB/s][r=860 IOPS][eta 00m:31s]
Jobs: 1 (f=1): [R(1)][76.0%][r=863MiB/s][r=863 IOPS][eta 00m:29s]
Jobs: 1 (f=1): [R(1)][77.5%][r=862MiB/s][r=862 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [R(1)][78.5%][r=862MiB/s][r=861 IOPS][eta 00m:26s]
Jobs: 1 (f=1): [R(1)][79.3%][r=863MiB/s][r=863 IOPS][eta 00m:25s]
Jobs: 1 (f=1): [R(1)][81.0%][r=864MiB/s][r=864 IOPS][eta 00m:23s]
Jobs: 1 (f=1): [R(1)][82.6%][r=860MiB/s][r=860 IOPS][eta 00m:21s]
Jobs: 1 (f=1): [R(1)][84.3%][r=863MiB/s][r=863 IOPS][eta 00m:19s]
Jobs: 1 (f=1): [R(1)][86.0%][r=863MiB/s][r=863 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [R(1)][86.8%][r=861MiB/s][r=861 IOPS][eta 00m:16s]
Jobs: 1 (f=1): [R(1)][88.4%][r=862MiB/s][r=861 IOPS][eta 00m:14s]
Jobs: 1 (f=1): [R(1)][89.3%][r=862MiB/s][r=862 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [R(1)][90.9%][r=862MiB/s][r=861 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [R(1)][92.6%][r=860MiB/s][r=860 IOPS][eta 00m:09s]
Jobs: 1 (f=1): [R(1)][94.2%][r=862MiB/s][r=862 IOPS][eta 00m:07s]
Jobs: 1 (f=1): [R(1)][95.9%][r=866MiB/s][r=866 IOPS][eta 00m:05s]
Jobs: 1 (f=1): [R(1)][97.5%][r=866MiB/s][r=865 IOPS][eta 00m:03s]
Jobs: 1 (f=1): [R(1)][98.3%][r=861MiB/s][r=861 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [R(1)][99.2%][r=862MiB/s][r=861 IOPS][eta 00m:01s]
Jobs: 1 (f=1): [R(1)][100.0%][r=861MiB/s][r=860 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=60877: Fri May 31 13:39:48 2024
  read: IOPS=861, BW=861MiB/s (903MB/s)(101GiB/120019msec)
    slat (nsec): min=0, max=8869.0k, avg=3178.86, stdev=47096.84
    clat (usec): min=67, max=39153, avg=18559.58, stdev=2106.79
     lat (usec): min=1340, max=39156, avg=18562.76, stdev=2104.14
    clat percentiles (usec):
     |  1.00th=[10945],  5.00th=[14222], 10.00th=[16188], 20.00th=[17695],
     | 30.00th=[18482], 40.00th=[18482], 50.00th=[18744], 60.00th=[19530],
     | 70.00th=[19530], 80.00th=[19792], 90.00th=[20055], 95.00th=[20579],
     | 99.00th=[23200], 99.50th=[24773], 99.90th=[30278], 99.95th=[32900],
     | 99.99th=[36963]
   bw (  KiB/s): min=847588, max=900308, per=100.00%, avg=882816.22, stdev=6669.72, samples=238
   iops        : min=  827, max=  879, avg=861.75, stdev= 6.55, samples=238
  lat (usec)   : 100=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.02%, 10=0.43%, 20=89.94%, 50=9.61%
  cpu          : usr=0.72%, sys=1.09%, ctx=101626, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.2%, 8=49.3%, 16=50.5%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=97.6%, 8=2.2%, 16=0.2%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=103371,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=861MiB/s (903MB/s), 861MiB/s-861MiB/s (903MB/s-903MB/s), io=101GiB (108GB), run=120019-120019msec
```

## Throughput test: sequential write

```sh
sudo fio --filename=./fio-test.bin --direct=1 --rw=write --bs=1M --ioengine=posixaio --iodepth=64 --runtime=120 --numjobs=1 --time_based --group_reporting --name=throughput-test-job --eta-newline=1
```

```sh
throughput-test-job: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=posixaio, iodepth=64
fio-3.37
Starting 1 process
Jobs: 1 (f=1): [W(1)][2.5%][w=922MiB/s][w=922 IOPS][eta 01m:58s]
Jobs: 1 (f=1): [W(1)][4.1%][w=921MiB/s][w=920 IOPS][eta 01m:56s]
Jobs: 1 (f=1): [W(1)][5.8%][w=927MiB/s][w=927 IOPS][eta 01m:54s]
Jobs: 1 (f=1): [W(1)][6.6%][w=916MiB/s][w=916 IOPS][eta 01m:53s]
Jobs: 1 (f=1): [W(1)][8.3%][w=924MiB/s][w=924 IOPS][eta 01m:51s]
Jobs: 1 (f=1): [W(1)][9.1%][w=915MiB/s][w=915 IOPS][eta 01m:50s]
Jobs: 1 (f=1): [W(1)][10.7%][w=924MiB/s][w=924 IOPS][eta 01m:48s]
Jobs: 1 (f=1): [W(1)][12.4%][w=926MiB/s][w=926 IOPS][eta 01m:46s]
Jobs: 1 (f=1): [W(1)][13.2%][w=928MiB/s][w=928 IOPS][eta 01m:45s]
Jobs: 1 (f=1): [W(1)][14.9%][w=821MiB/s][w=820 IOPS][eta 01m:43s]
Jobs: 1 (f=1): [W(1)][15.7%][w=929MiB/s][w=929 IOPS][eta 01m:42s]
Jobs: 1 (f=1): [W(1)][17.4%][w=905MiB/s][w=904 IOPS][eta 01m:40s]
Jobs: 1 (f=1): [W(1)][18.2%][w=923MiB/s][w=923 IOPS][eta 01m:39s]
Jobs: 1 (f=1): [W(1)][19.0%][w=924MiB/s][w=924 IOPS][eta 01m:38s]
Jobs: 1 (f=1): [W(1)][20.7%][w=784MiB/s][w=784 IOPS][eta 01m:36s]
Jobs: 1 (f=1): [W(1)][22.3%][w=931MiB/s][w=931 IOPS][eta 01m:34s]
Jobs: 1 (f=1): [W(1)][24.0%][w=925MiB/s][w=924 IOPS][eta 01m:32s]
Jobs: 1 (f=1): [W(1)][24.8%][w=928MiB/s][w=928 IOPS][eta 01m:31s]
Jobs: 1 (f=1): [W(1)][26.7%][w=903MiB/s][w=903 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [W(1)][27.3%][w=932MiB/s][w=932 IOPS][eta 01m:28s]
Jobs: 1 (f=1): [W(1)][28.9%][w=917MiB/s][w=917 IOPS][eta 01m:26s]
Jobs: 1 (f=1): [W(1)][30.6%][w=925MiB/s][w=925 IOPS][eta 01m:24s]
Jobs: 1 (f=1): [W(1)][32.2%][w=918MiB/s][w=918 IOPS][eta 01m:22s]
Jobs: 1 (f=1): [W(1)][33.9%][w=920MiB/s][w=920 IOPS][eta 01m:20s]
Jobs: 1 (f=1): [W(1)][35.5%][w=927MiB/s][w=926 IOPS][eta 01m:18s]
Jobs: 1 (f=1): [W(1)][37.2%][w=929MiB/s][w=928 IOPS][eta 01m:16s]
Jobs: 1 (f=1): [W(1)][38.7%][w=924MiB/s][w=923 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][39.7%][w=929MiB/s][w=928 IOPS][eta 01m:13s]
Jobs: 1 (f=1): [W(1)][40.5%][w=923MiB/s][w=923 IOPS][eta 01m:12s]
Jobs: 1 (f=1): [W(1)][41.3%][w=925MiB/s][w=925 IOPS][eta 01m:11s]
Jobs: 1 (f=1): [W(1)][42.1%][w=924MiB/s][w=923 IOPS][eta 01m:10s]
Jobs: 1 (f=1): [W(1)][43.0%][w=926MiB/s][w=925 IOPS][eta 01m:09s]
Jobs: 1 (f=1): [W(1)][43.8%][w=926MiB/s][w=926 IOPS][eta 01m:08s]
Jobs: 1 (f=1): [W(1)][45.5%][w=928MiB/s][w=928 IOPS][eta 01m:06s]
Jobs: 1 (f=1): [W(1)][47.1%][w=919MiB/s][w=918 IOPS][eta 01m:04s]
Jobs: 1 (f=1): [W(1)][48.8%][w=912MiB/s][w=911 IOPS][eta 01m:02s]
Jobs: 1 (f=1): [W(1)][49.6%][w=934MiB/s][w=934 IOPS][eta 01m:01s]
Jobs: 1 (f=1): [W(1)][51.2%][w=916MiB/s][w=915 IOPS][eta 00m:59s]
Jobs: 1 (f=1): [W(1)][52.9%][w=926MiB/s][w=926 IOPS][eta 00m:57s]
Jobs: 1 (f=1): [W(1)][53.7%][w=927MiB/s][w=927 IOPS][eta 00m:56s]
Jobs: 1 (f=1): [W(1)][55.8%][w=916MiB/s][w=916 IOPS][eta 00m:53s]
Jobs: 1 (f=1): [W(1)][57.0%][w=923MiB/s][w=922 IOPS][eta 00m:52s]
Jobs: 1 (f=1): [W(1)][57.9%][w=888MiB/s][w=888 IOPS][eta 00m:51s]
Jobs: 1 (f=1): [W(1)][59.5%][w=924MiB/s][w=924 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [W(1)][61.2%][w=923MiB/s][w=923 IOPS][eta 00m:47s]
Jobs: 1 (f=1): [W(1)][62.8%][w=884MiB/s][w=884 IOPS][eta 00m:45s]
Jobs: 1 (f=1): [W(1)][65.0%][w=904MiB/s][w=904 IOPS][eta 00m:42s]
Jobs: 1 (f=1): [W(1)][66.1%][w=925MiB/s][w=925 IOPS][eta 00m:41s]
Jobs: 1 (f=1): [W(1)][68.3%][w=904MiB/s][w=903 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [W(1)][68.6%][w=928MiB/s][w=927 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [W(1)][70.2%][w=928MiB/s][w=927 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [W(1)][71.1%][w=923MiB/s][w=923 IOPS][eta 00m:35s]
Jobs: 1 (f=1): [W(1)][71.9%][w=916MiB/s][w=916 IOPS][eta 00m:34s]
Jobs: 1 (f=1): [W(1)][73.6%][w=900MiB/s][w=900 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [W(1)][74.4%][w=926MiB/s][w=926 IOPS][eta 00m:31s]
Jobs: 1 (f=1): [W(1)][76.0%][w=923MiB/s][w=923 IOPS][eta 00m:29s]
Jobs: 1 (f=1): [W(1)][77.7%][w=924MiB/s][w=923 IOPS][eta 00m:27s]
Jobs: 1 (f=1): [W(1)][78.5%][w=925MiB/s][w=925 IOPS][eta 00m:26s]
Jobs: 1 (f=1): [W(1)][80.2%][w=927MiB/s][w=926 IOPS][eta 00m:24s]
Jobs: 1 (f=1): [W(1)][81.0%][w=915MiB/s][w=915 IOPS][eta 00m:23s]
Jobs: 1 (f=1): [W(1)][82.6%][w=921MiB/s][w=921 IOPS][eta 00m:21s]
Jobs: 1 (f=1): [W(1)][84.3%][w=900MiB/s][w=899 IOPS][eta 00m:19s]
Jobs: 1 (f=1): [W(1)][85.1%][w=925MiB/s][w=925 IOPS][eta 00m:18s]
Jobs: 1 (f=1): [W(1)][86.0%][w=914MiB/s][w=913 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [W(1)][86.8%][w=921MiB/s][w=921 IOPS][eta 00m:16s]
Jobs: 1 (f=1): [W(1)][88.4%][w=925MiB/s][w=924 IOPS][eta 00m:14s]
Jobs: 1 (f=1): [W(1)][90.1%][w=924MiB/s][w=923 IOPS][eta 00m:12s]
Jobs: 1 (f=1): [W(1)][90.9%][w=923MiB/s][w=922 IOPS][eta 00m:11s]
Jobs: 1 (f=1): [W(1)][91.7%][w=924MiB/s][w=923 IOPS][eta 00m:10s]
Jobs: 1 (f=1): [W(1)][92.6%][w=918MiB/s][w=918 IOPS][eta 00m:09s]
Jobs: 1 (f=1): [W(1)][93.4%][w=922MiB/s][w=921 IOPS][eta 00m:08s]
Jobs: 1 (f=1): [W(1)][94.2%][w=917MiB/s][w=916 IOPS][eta 00m:07s]
Jobs: 1 (f=1): [W(1)][95.0%][w=912MiB/s][w=911 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [W(1)][96.7%][w=918MiB/s][w=918 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [W(1)][98.3%][w=921MiB/s][w=920 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [W(1)][100.0%][w=931MiB/s][w=931 IOPS][eta 00m:00s]
throughput-test-job: (groupid=0, jobs=1): err= 0: pid=60974: Fri May 31 13:41:49 2024
  write: IOPS=918, BW=919MiB/s (963MB/s)(108GiB/120015msec); 0 zone resets
    slat (nsec): min=0, max=41540k, avg=109603.34, stdev=451662.94
    clat (usec): min=208, max=167145, avg=17109.48, stdev=3659.03
     lat (usec): min=1381, max=167147, avg=17219.08, stdev=3656.03
    clat percentiles (msec):
     |  1.00th=[   10],  5.00th=[   13], 10.00th=[   15], 20.00th=[   16],
     | 30.00th=[   17], 40.00th=[   18], 50.00th=[   18], 60.00th=[   18],
     | 70.00th=[   18], 80.00th=[   19], 90.00th=[   20], 95.00th=[   21],
     | 99.00th=[   25], 99.50th=[   27], 99.90th=[   37], 99.95th=[   45],
     | 99.99th=[  167]
   bw (  KiB/s): min=670476, max=971174, per=100.00%, avg=941507.41, stdev=28551.80, samples=238
   iops        : min=  654, max=  948, avg=918.98, stdev=27.88, samples=238
  lat (usec)   : 250=0.01%, 750=0.01%
  lat (msec)   : 2=0.02%, 4=0.09%, 10=1.41%, 20=92.38%, 50=6.06%
  lat (msec)   : 100=0.02%, 250=0.03%
  cpu          : usr=5.65%, sys=7.60%, ctx=125042, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.5%, 8=50.7%, 16=48.7%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=97.4%, 8=2.3%, 16=0.3%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,110237,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=919MiB/s (963MB/s), 919MiB/s-919MiB/s (963MB/s-963MB/s), io=108GiB (116GB), run=120015-120015msec
```
