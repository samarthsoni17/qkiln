/// TICKERPLANT
Last login: Tue Oct 28 22:51:06 on ttys003
(base) ~
(base) ~
(base) ~
☺  cd Projects/KDB/qkiln
(base) ~/Projects/KDB/qkiln
☺  q tick.q sym . -p 10810     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

'tick.q. OS reports: No such file or directory
q)\\
(base) ~/Projects/KDB/qkiln
☺  q ./architecture/tick.q sym . -p 10810     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

"kdb+tick 2.8 2014.03.12"
'tick/sym.q. OS reports: No such file or directory
  [3]  \l tick/sym.q
       ^
q))\\
(base) ~/Projects/KDB/qkiln
☺  cd architecture                 architecture ✗
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick.q sym . -p 10810     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

"kdb+tick 2.8 2014.03.12"
q).u.w
trade|
/list of all tables + subsequent processes connecting to this
q).u.w
trade| 9i `
/we now have a handle here confirming rdb is connected
/lets run end of day so hdb can view the table now
q).u.endofday[]
q).u.d
2025.10.30
/*** this has now increased its day from 29th to 20th!!
/*** this has now increased its day from 29th to 30th!!
/and if yo check /sym/ it will have new date saved down there
q).u.endofday[]
q).u.d
2025.10.31
q).u.endofday[]
q)\\
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick.q sym . -p 10810     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

"kdb+tick 2.8 2014.03.12"
'int
  [6]  /Users/SamarthSoni/Projects/KDB/qkiln/architecture/tick/sym.q:5: quote:([]time:`timespan$();sym:`g#`symbol$();bid:`float$();ask:`float$();bsize:`int();asize:`int());
                                                                                                                                                                    ^
q))\\
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick.q sym . -p 10810     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

"kdb+tick 2.8 2014.03.12"
q).u.w
quote| 9i `
trade| 9i `
q).u.d
2025.10.29
q)
q)
q).u.d
2025.10.29
q)system "ll -a"
sh: ll: command not found
'os
  [1]  \ll -a
       ^
q))system "ls -la"
"total 304"
"drwxr-xr-x  10 SamarthSoni  staff     320 29 Oct 10:17 ."
"drwxr-xr-x  17 SamarthSoni  staff     544 29 Oct 01:50 .."
"-rw-r--r--@  1 SamarthSoni  staff    2698 29 Oct 10:17 README.md"
"drwxr-xr-x   6 SamarthSoni  staff     192 29 Oct 08:59 sym"
"-rw-r--r--   1 SamarthSoni  staff  115199 29 Oct 10:25 sym2025.10.29"
"-rw-r--r--   1 SamarthSoni  staff     385 29 Oct 08:51 sym2025.10.30"
"-rw-r--r--   1 SamarthSoni  staff     196 29 Oct 08:59 sym2025.10.31"
"-rw-r--r--   1 SamarthSoni  staff       8 29 Oct 08:59 sym2025.11.01"
"drwxr-xr-x  10 SamarthSoni  staff     320 29 Oct 10:23 tick"
"-rw-r--r--@  1 SamarthSoni  staff    2712 29 Oct 09:32 tick.q"
q))\
q)
q)
q).u.w
quote| 9i  ` 10i ` 12i `
trade| 9i  ` 10i ` 12i `
q).u.i
1013
/tells how many records are logged in the log file
q).u.i
1013
/now lets start feedhandler back
q).u.i
1021
q).u.i
1023
q).u.i
1025
q).u.i
1027
q).u.i
1029
q).u.i
1031
q).u.i
1035
q)
q)
q).u.i
1043
q).u.i
1043
/now, even if we stop our rdb, this would continue to capture and log
q).u.i
1049
q).u.i
1051
q).u.i
1069
q).u.i
1077
q).u.i
1077
/now lets keep this stable (feedhandler stopped) and restart rdb
q).u.i
1077
q).u.i
1103
/with this we have simulated an rdb going down and how it can be restored safely
/with this we have simulated an rdb going down and how it can be restored safely
q).u.i
5861
q).u.endofday[]
q).u.i
4
q).u.i
4
q).u.i
14
q).u.i
18
q).u.i
30
q)




/// RDB
Last login: Wed Oct 29 08:23:37 on ttys003
(base) ~
☺  ~/Projects/KDB/qkiln
(base) ~/Projects/KDB/qkiln
☺  cd architecture           architecture ✗
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/rdb.q -p 10811     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

'hop. OS reports: Connection refused
  [2]  /Users/SamarthSoni/Projects/KDB/qkiln/architecture/tick/rdb.q:19: .u.rep .(hopen `$":",.u.x 0)"(.u.sub[`;`];`.u `i`L)";
                                                                                  ^
q))\\
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/rdb.q -p 10811     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)tables[]
,`trade
q)trade
time sym price side
-------------------
/same cols we specified in sym.q file
q)trade
time                 sym  price    side
---------------------------------------
0D00:38:42.888867000 AMZN 5159.796 B
0D00:38:42.888867000 MSFT 4066.642 B
q)trade
time                 sym  price    side
---------------------------------------
0D00:38:42.888867000 AMZN 5159.796 B
0D00:38:42.888867000 MSFT 4066.642 B
0D00:38:48.341427000 TSLA 7111.716 B
0D00:38:48.341427000 META 4115.97  S
/effectively capturing live data at this point
q)trade
time sym price side
-------------------
/rdb memory cleared out at EOD so its fresh for new day
/ready for tmrws data capture
q)trades
'trades
  [0]  trades
       ^
q)trade
time                 sym  price    side
---------------------------------------
0D00:50:12.873095000 META 6137.452 B
0D00:50:12.873095000 AMZN 5294.808 B
0D00:50:13.254965000 APPL 6346.716 B
0D00:50:13.254965000 MSFT 9672.398 S
0D00:50:13.898781000 APPL 8481.567 B
0D00:50:13.898781000 APPL 3890.56  S
q)latestSymPrice
'latestSymPrice
  [0]  latestSymPrice
       ^
q)trade
time                 sym   price    side
----------------------------------------
0D00:50:12.873095000 META  6137.452 B
0D00:50:12.873095000 AMZN  5294.808 B
0D00:50:13.254965000 APPL  6346.716 B
0D00:50:13.254965000 MSFT  9672.398 S
0D00:50:13.898781000 APPL  8481.567 B
0D00:50:13.898781000 APPL  3890.56  S
0D00:51:35.301539000 GOOGL 2392.341 S
0D00:51:35.301539000 TSLA  1508.133 B
q)trade
time sym price side
-------------------
q)trade
time sym price side
-------------------
q)\\
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/rdb.q -p 10811     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)tables[]
`s#`quote`trade
q)trade
time                 sym   price    side
----------------------------------------
0D00:38:42.888867000 AMZN  5159.796 B
0D00:38:42.888867000 MSFT  4066.642 B
0D00:38:48.341427000 TSLA  7111.716 B
0D00:38:48.341427000 META  4115.97  S
0D01:37:54.087231000 AMZN  5159.796 B
0D01:37:54.087231000 MSFT  4066.642 B
0D01:37:55.092900000 MSFT  6919.531 S
0D01:37:55.092900000 AMZN  4707.883 B
0D01:37:56.093452000 GOOGL 1508.133 B
0D01:37:56.093452000 TSLA  1567.317 S
0D01:37:57.094720000 AMZN  2747.066 S
0D01:37:57.094720000 TSLA  575.2516 S
0D01:37:58.094081000 APPL  6789.082 S
0D01:37:58.094081000 TSLA  4123.17  B
0D01:37:59.090539000 APPL  2430.836 S
0D01:37:59.090539000 META  3917.953 S
0D01:38:00.092973000 TSLA  2857.99  B
0D01:38:00.092973000 TSLA  6684.724 S
0D01:38:01.093030000 MSFT  4573.28  B
0D01:38:01.093030000 MSFT  80.62521 B
..
q)quote
time sym bid ask bsize asize
----------------------------
q)delete from trade
time sym price side
-------------------
q)trade
time                 sym   price    side
----------------------------------------
0D00:38:42.888867000 AMZN  5159.796 B
0D00:38:42.888867000 MSFT  4066.642 B
0D00:38:48.341427000 TSLA  7111.716 B
0D00:38:48.341427000 META  4115.97  S
0D01:37:54.087231000 AMZN  5159.796 B
0D01:37:54.087231000 MSFT  4066.642 B
0D01:37:55.092900000 MSFT  6919.531 S
0D01:37:55.092900000 AMZN  4707.883 B
0D01:37:56.093452000 GOOGL 1508.133 B
0D01:37:56.093452000 TSLA  1567.317 S
0D01:37:57.094720000 AMZN  2747.066 S
0D01:37:57.094720000 TSLA  575.2516 S
0D01:37:58.094081000 APPL  6789.082 S
0D01:37:58.094081000 TSLA  4123.17  B
0D01:37:59.090539000 APPL  2430.836 S
0D01:37:59.090539000 META  3917.953 S
0D01:38:00.092973000 TSLA  2857.99  B
0D01:38:00.092973000 TSLA  6684.724 S
0D01:38:01.093030000 MSFT  4573.28  B
0D01:38:01.093030000 MSFT  80.62521 B
..
q)delete from `trade
`trade
q)trade
time sym price side
-------------------
q)trade
time                 sym   price    side
----------------------------------------
0D01:41:40.796854000 TSLA  1047.944 B
0D01:41:40.796854000 TSLA  6990.44  B
0D01:41:41.799900000 META  7019.831 B
0D01:41:41.799900000 GOOGL 7269.904 S
0D01:41:42.800621000 APPL  6501.981 S
0D01:41:42.800621000 TSLA  4837.422 B
0D01:41:43.801427000 META  4414.907 B
0D01:41:43.801427000 GOOGL 5652.261 B
0D01:41:44.803506000 MSFT  8685.452 S
0D01:41:44.803506000 AMZN  122.1208 S
q)quote
time                 sym   bid      ask      bsize asize
--------------------------------------------------------
0D01:41:40.798503000 APPL  884.0718 5473.385 374   282
0D01:41:40.798503000 APPL  1788.229 5937.37  347   252
0D01:41:41.800726000 GOOGL 62.797   4449.053 124   65
0D01:41:41.800726000 APPL  1522.666 5429.165 234   34
0D01:41:42.801409000 GOOGL 6912.49  6417.901 489   190
0D01:41:42.801409000 GOOGL 4832.847 1608.836 146   235
0D01:41:43.802419000 AMZN  6395.903 7894.862 251   391
0D01:41:43.802419000 TSLA  1461.295 4244.823 213   193
0D01:41:44.804170000 AMZN  5938.637 5000.071 139   182
0D01:41:44.804170000 TSLA  7659.05  8392.881 108   105
0D01:41:45.801297000 GOOGL 5365.242 8429.965 395   443
0D01:41:45.801297000 META  7470.449 6214.154 487   52
0D01:41:46.803203000 GOOGL 5216.312 7290.949 213   132
0D01:41:46.803203000 AMZN  2255.7   6962.927 452   214
0D01:41:47.804030000 GOOGL 754.0168 3114.316 164   498
0D01:41:47.804030000 AMZN  7423.834 9103.693 237   415
q)count trade
26
q)count trade
28
q)count trade
30
q)count trade
34
/2 rows per second are increasing
q)count trade
120
q)count trade
120
q)count trade
120
q)count trade
126
q)count trade
130
q)count trade
132
q)count trade
134
q)count trade
136
q)
q)count trade
156
q)count trade
156
q)count trade
162
q)count quote
184
q)count quote
184
q)count quote
188
q)count quote
990
q)count quote
1022
q)count trade
1022
q)count trade
1022
q)\\
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/rdb.q -p 10811                   architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)cout trade
'cout
  [0]  cout trade
       ^
q)count trade
1098
q)count trade
1098
q)count quote
1056
q)count quote
1060
q)count trade
1108
q)count trade
5886
q)count quote
5844
q)selectFun
'selectFun
  [0]  selectFun
       ^
q)selectFunc
{[tbl;sd;ed;ids]
  $[`date in cols tbl;
  select from tbl where date within (sd;ed),sym in ids;
  [res:$[.z.D within (sd;ed); select from tbl where sym in ids;0#value tbl];
    `date xcols update date:.z.D from res]] }
q)count quote
0
q)count trade
0
q)count trade
32
q)count quote
32
q)



// FEEDHANDLER
Last login: Wed Oct 29 08:23:43 on ttys005
(base) ~
☺

(base) ~
☺  ~/Projects/KDB/qkiln
(base) ~/Projects/KDB/qkiln
☺  cd architecture           architecture ✗
(base) ~/Projects/KDB/qkiln/architecture
☺  q                                          architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)h_tp:hopen 10810;
q)h_tp"(.u.upd[`trade;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)])"
q)h_tp"(.u.upd[`trade;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)])"
q)h_tp"(.u.upd[`trade;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)])"
q)h_tp"(.u.upd[`trade;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)])"
q)h_tp"(.u.upd[`trade;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)])"
q)h_tp"(.u.upd[`trade;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)])"
q)h_tp"(.u.upd[`trade;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)])"
q)h_tp"(.u.upd[`trade;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)])"
q).z.n
0D01:23:41.859141000
q)2#.z.n
0D01:23:47.148082000 0D01:23:47.148082000
q)]
']
  [0]  ]
       ^
q)(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)
0D01:27:45.981935000 0D01:27:45.981935000
AMZN                 MSFT
5159.796             4066.642
B                    B
q)\\
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/feed.q     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)'length
'length
'length
'length
'length
'length
'length
'length
'length
'length
'length
'length
'length
'length
'length
'length
'length
'length
'length
\\
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/feed.q     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

/if we want to stop it
q)\t 0
/now we can make it back 1000 ms to again see couts in rdb will start increasing
q)\t 1000
q)system"t 0"
q)\t 1000
q)\t 0
q)\t 1000
q)\t 0
q)\t 0
q)\t 1000
q)\t 0
q)\t 0
q)\t 1000
q)\t 0
q)\t 1000
q)\t 0
/if you now stop tickerplant and then rerun feedhandler, it will throw error
q)\t 1000
q)'Cannot write to handle 6. OS reports: Bad file descriptor
'Cannot write to handle 6. OS reports: Bad file descriptor
'Cannot write to handle 6. OS reports: Bad file descriptor
'Cannot write to handle 6. OS reports: Bad file descriptor
'C.............




// HDB
Last login: Wed Oct 29 08:23:40 on ttys004
(base) ~
☺  ~/Projects/KDB/qkiln
(base) ~/Projects/KDB/qkiln
(base) ~/Projects/KDB/qkiln
☺  cd architecture           architecture ✗
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/hdb.q sym -p 10812      architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)trade
'trade
  [0]  trade
       ^
q)trade
date       sym  time                 price    side
--------------------------------------------------
2025.10.29 AMZN 0D00:38:42.888867000 5159.796 B
2025.10.29 META 0D00:38:48.341427000 4115.97  S
2025.10.29 MSFT 0D00:38:42.888867000 4066.642 B
2025.10.29 TSLA 0D00:38:48.341427000 7111.716 B
q)trade
date       sym   time                 price    side
---------------------------------------------------
2025.10.29 AMZN  0D00:38:42.888867000 5159.796 B
2025.10.29 META  0D00:38:48.341427000 4115.97  S
2025.10.29 MSFT  0D00:38:42.888867000 4066.642 B
2025.10.29 TSLA  0D00:38:48.341427000 7111.716 B
2025.10.30 AMZN  0D00:50:12.873095000 5294.808 B
2025.10.30 APPL  0D00:50:13.254965000 6346.716 B
2025.10.30 APPL  0D00:50:13.898781000 8481.567 B
2025.10.30 APPL  0D00:50:13.898781000 3890.56  S
2025.10.30 GOOGL 0D00:51:35.301539000 2392.341 S
2025.10.30 META  0D00:50:12.873095000 6137.452 B
2025.10.30 MSFT  0D00:50:13.254965000 9672.398 S
2025.10.30 TSLA  0D00:51:35.301539000 1508.133 B
q)trade
date       sym   time                 price    side
---------------------------------------------------
2025.10.29 AMZN  0D00:38:42.888867000 5159.796 B
2025.10.29 META  0D00:38:48.341427000 4115.97  S
2025.10.29 MSFT  0D00:38:42.888867000 4066.642 B
2025.10.29 TSLA  0D00:38:48.341427000 7111.716 B
2025.10.30 AMZN  0D00:50:12.873095000 5294.808 B
2025.10.30 APPL  0D00:50:13.254965000 6346.716 B
2025.10.30 APPL  0D00:50:13.898781000 8481.567 B
2025.10.30 APPL  0D00:50:13.898781000 3890.56  S
2025.10.30 GOOGL 0D00:51:35.301539000 2392.341 S
2025.10.30 META  0D00:50:12.873095000 6137.452 B
2025.10.30 MSFT  0D00:50:13.254965000 9672.398 S
2025.10.30 TSLA  0D00:51:35.301539000 1508.133 B
2025.10.31 META  0D00:59:46.718798000 7148.779 B
2025.10.31 META  0D00:59:46.718798000 1946.509 B
2025.10.31 TSLA  0D00:59:44.786584000 4099.561 B
2025.10.31 TSLA  0D00:59:44.786584000 6108.817 B
q)trade
date       sym   time                 price    side
---------------------------------------------------
2025.10.29 AMZN  0D00:38:42.888867000 5159.796 B
2025.10.29 META  0D00:38:48.341427000 4115.97  S
2025.10.29 MSFT  0D00:38:42.888867000 4066.642 B
2025.10.29 TSLA  0D00:38:48.341427000 7111.716 B
2025.10.30 AMZN  0D00:50:12.873095000 5294.808 B
2025.10.30 APPL  0D00:50:13.254965000 6346.716 B
2025.10.30 APPL  0D00:50:13.898781000 8481.567 B
2025.10.30 APPL  0D00:50:13.898781000 3890.56  S
2025.10.30 GOOGL 0D00:51:35.301539000 2392.341 S
2025.10.30 META  0D00:50:12.873095000 6137.452 B
2025.10.30 MSFT  0D00:50:13.254965000 9672.398 S
2025.10.30 TSLA  0D00:51:35.301539000 1508.133 B
2025.10.31 META  0D00:59:46.718798000 7148.779 B
2025.10.31 META  0D00:59:46.718798000 1946.509 B
2025.10.31 TSLA  0D00:59:44.786584000 4099.561 B
2025.10.31 TSLA  0D00:59:44.786584000 6108.817 B
q)selectFun
'selectFun
  [0]  selectFun
       ^
q)selectFunc
{[tbl;sd;ed;ids]
  $[`date in cols tbl;
  select from tbl where date within (sd;ed),sym in ids;
  [res:$[.z.D within (sd;ed); select from tbl where sym in ids;0#value tbl];
    `date xcols update date:.z.D from res]] }
q)count trade
5898
q)\\





// GATEWAY
Last login: Wed Oct 29 08:39:30 on ttys011
(base) ~
☺

(base) ~
☺  cd ~/Projects/KDB/qkiln/architecture
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/gw.q -p 10814     architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)getTradeData
{[sd;ed;ids]
  hdb:h_hdb(`selectFunc;`trade;sd;ed;ids);
  rdb:h_rdb(`selectFunc;`trade;sd;ed;ids);
  hdb,rdb }
/start date, enddate, symbol we want it to return
q)getTradeData[2025.10.29;2025.10.30;`]
date time sym price side
------------------------
/okay ALL not defined yet
q)getTradeData[2025.10.29;2025.10.30;`GOOGL]
date       time                 sym   price    side
---------------------------------------------------
2025.10.29 0D00:51:35.301539000 GOOGL 2392.341 S
q)getTradeData[2025.10.29;2025.10.30;`AMZN]
date       sym  time                 price    side
--------------------------------------------------
2025.10.29 AMZN 0D00:38:42.888867000 5159.796 B
2025.10.29 AMZN 0D00:50:12.873095000 5294.808 B
q)getTradeData[2025.10.29;2025.10.30;`AAPL]
date time sym price side
------------------------
q)getTradeData[2025.10.29;2025.10.30;`APPL]
date       time                 sym  price    side
--------------------------------------------------
2025.10.29 0D00:50:13.254965000 APPL 6346.716 B
2025.10.29 0D00:50:13.898781000 APPL 8481.567 B
2025.10.29 0D00:50:13.898781000 APPL 3890.56  S
/even though all of these rows from the RDB are giving us data for today, since tickerplant's .u.d points to tomorrow now, when we will save and rerun, our experience will be different
q)getTradeData[2025.10.29;2025.10.30;`APPL]
date       sym  time                 price    side
--------------------------------------------------
2025.10.30 APPL 0D00:50:13.254965000 6346.716 B
2025.10.30 APPL 0D00:50:13.898781000 8481.567 B
2025.10.30 APPL 0D00:50:13.898781000 3890.56  S
q)getTradeData[2025.10.29;2025.10.30;`AMZN]
date       sym  time                 price    side
--------------------------------------------------
2025.10.29 AMZN 0D00:38:42.888867000 5159.796 B
2025.10.30 AMZN 0D00:50:12.873095000 5294.808 B
/as we can see now the dates changed !!
q)getTradeData[2025.10.29;2025.10.30;`AMZN]
date       sym  time                 price    side
--------------------------------------------------
2025.10.29 AMZN 0D00:38:42.888867000 5159.796 B
2025.10.30 AMZN 0D00:50:12.873095000 5294.808 B
q)
q)getTradeData[2025.10.29;2025.10.30;`APPL]
date       sym  time                 price    side
--------------------------------------------------
2025.10.30 APPL 0D00:50:13.254965000 6346.716 B
2025.10.30 APPL 0D00:50:13.898781000 8481.567 B
2025.10.30 APPL 0D00:50:13.898781000 3890.56  S
q)getTradeData[2025.10.29;2025.10.30;`META]
date       sym  time                 price    side
--------------------------------------------------
2025.10.29 META 0D00:38:48.341427000 4115.97  S
2025.10.30 META 0D00:50:12.873095000 6137.452 B
q)getTradeData[2025.10.29;2025.10.31;`META]
date       sym  time                 price    side
--------------------------------------------------
2025.10.29 META 0D00:38:48.341427000 4115.97  S
2025.10.30 META 0D00:50:12.873095000 6137.452 B
2025.10.31 META 0D00:59:46.718798000 7148.779 B
2025.10.31 META 0D00:59:46.718798000 1946.509 B
/3 dates nwo!
/we didnt have to remmeber port numbers etc for hdb or rdb or have any concern about where the data was at the moment
/it just came to us
q)getTradeData[2025.10.29;2025.10.31;`META]
'Cannot write to handle 9. OS reports: Bad file descriptor
  [1]  /Users/SamarthSoni/Projects/KDB/qkiln/architecture/tick/gw.q:9: getTradeData:
  hdb:h_hdb(`selectFunc;`trade;sd;ed;ids);
  rdb:h_rdb(`selectFunc;`trade;sd;ed;ids);
      ^
  hdb,rdb }
q))\\
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/gw.q -p 10814                    architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)getTradeData[2025.10.29;2025.10.30;`GOOGL]
date       sym   time                 price    side
---------------------------------------------------
2025.10.29 GOOGL 0D01:37:56.093452000 1508.133 B
2025.10.29 GOOGL 0D01:38:04.088748000 693.8325 B
2025.10.29 GOOGL 0D01:38:05.090325000 6330.41  S
2025.10.29 GOOGL 0D01:38:06.091123000 5989.167 S
2025.10.29 GOOGL 0D01:38:07.090098000 5459.723 B
2025.10.29 GOOGL 0D01:38:08.092667000 9761.246 S
2025.10.29 GOOGL 0D01:38:11.092570000 8416.288 B
2025.10.29 GOOGL 0D01:38:12.098380000 3923.249 S
2025.10.29 GOOGL 0D01:41:41.799900000 7269.904 S
2025.10.29 GOOGL 0D01:41:43.801427000 5652.261 B
2025.10.29 GOOGL 0D01:41:46.802630000 4456.44  S
2025.10.29 GOOGL 0D01:41:48.803471000 4843.79  S
2025.10.29 GOOGL 0D01:41:53.802985000 3663.844 B
2025.10.29 GOOGL 0D01:41:56.803173000 1045.391 S
2025.10.29 GOOGL 0D01:42:07.804108000 611.9115 B
2025.10.29 GOOGL 0D01:42:11.803078000 5982.056 B
2025.10.29 GOOGL 0D01:42:12.802198000 1429.403 B
2025.10.29 GOOGL 0D01:42:16.803208000 9548.708 S
2025.10.29 GOOGL 0D01:42:20.799422000 6412.171 B
2025.10.29 GOOGL 0D01:42:25.799638000 2121.387 B
..
q)getTradeData[2025.10.30;2025.10.30;`GOOGL]
date       sym   time                 price    side
---------------------------------------------------
2025.10.30 GOOGL 0D00:51:35.301539000 2392.341 S
q)\\
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/gw.q -p 10814                    architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)getTradeData[2025.10.29;2025.10.30;`GOOGL]
date       sym   time                 price    side
---------------------------------------------------
2025.10.29 GOOGL 0D01:37:56.093452000 1508.133 B
2025.10.29 GOOGL 0D01:38:04.088748000 693.8325 B
2025.10.29 GOOGL 0D01:38:05.090325000 6330.41  S
2025.10.29 GOOGL 0D01:38:06.091123000 5989.167 S
2025.10.29 GOOGL 0D01:38:07.090098000 5459.723 B
2025.10.29 GOOGL 0D01:38:08.092667000 9761.246 S
2025.10.29 GOOGL 0D01:38:11.092570000 8416.288 B
2025.10.29 GOOGL 0D01:38:12.098380000 3923.249 S
2025.10.29 GOOGL 0D01:41:41.799900000 7269.904 S
2025.10.29 GOOGL 0D01:41:43.801427000 5652.261 B
2025.10.29 GOOGL 0D01:41:46.802630000 4456.44  S
2025.10.29 GOOGL 0D01:41:48.803471000 4843.79  S
2025.10.29 GOOGL 0D01:41:53.802985000 3663.844 B
2025.10.29 GOOGL 0D01:41:56.803173000 1045.391 S
2025.10.29 GOOGL 0D01:42:07.804108000 611.9115 B
2025.10.29 GOOGL 0D01:42:11.803078000 5982.056 B
2025.10.29 GOOGL 0D01:42:12.802198000 1429.403 B
2025.10.29 GOOGL 0D01:42:16.803208000 9548.708 S
2025.10.29 GOOGL 0D01:42:20.799422000 6412.171 B
2025.10.29 GOOGL 0D01:42:25.799638000 2121.387 B
..
q)getLastTradeData[2025.10.29;2025.10.30;`GOOGL]
date       sym   time                 price    side
---------------------------------------------------
2025.10.30 GOOGL 0D00:51:35.301539000 2392.341 S
2025.10.29 GOOGL 0D03:25:05.287314000 8760.631 B
q)getLastTradeData[2025.10.29;2025.10.30;`GOOGL`META]
date       sym   time                 price    side
---------------------------------------------------
2025.10.30 GOOGL 0D00:51:35.301539000 2392.341 S
2025.10.30 META  0D00:50:12.873095000 6137.452 B
2025.10.29 GOOGL 0D03:25:05.287314000 8760.631 B
2025.10.29 META  0D03:25:07.285805000 1734.786 B
q)getLastTradeData[2025.10.29;2025.10.31;`GOOGL`META`APPL]
date       sym   time                 price    side
---------------------------------------------------
2025.10.30 APPL  0D00:50:13.898781000 8481.567 B
2025.10.30 APPL  0D00:50:13.898781000 3890.56  S
2025.10.30 GOOGL 0D00:51:35.301539000 2392.341 S
2025.10.30 META  0D00:50:12.873095000 6137.452 B
2025.10.31 META  0D00:59:46.718798000 7148.779 B
2025.10.31 META  0D00:59:46.718798000 1946.509 B
2025.10.29 APPL  0D03:24:59.289794000 9066.913 S
2025.10.29 GOOGL 0D03:25:05.287314000 8760.631 B
2025.10.29 META  0D03:25:07.285805000 1734.786 B
q)




// REAL TIME SUBSCRIBER
Last login: Wed Oct 29 08:24:46 on ttys009
(base) ~
(base) ~
☺  cd ~/Projects/KDB/qkiln/architecture
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/rts.q -p 10813      architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

/for mock, we will tell it to save a second table called latestsymprice to keep a record of latest price for each symbol
q)
q)
q)trade
time sym price side
-------------------
q)latestSymPrice
sym| time price side
---| ---------------
q)trade
time                 sym  price    side
---------------------------------------
0D00:50:12.873095000 META 6137.452 B
0D00:50:12.873095000 AMZN 5294.808 B
0D00:50:13.254965000 APPL 6346.716 B
0D00:50:13.254965000 MSFT 9672.398 S
0D00:50:13.898781000 APPL 8481.567 B
0D00:50:13.898781000 APPL 3890.56  S
q)latestSymPrice
sym | time                 price    side
----| ----------------------------------
AMZN| 0D00:50:12.873095000 5294.808 B
META| 0D00:50:12.873095000 6137.452 B
APPL| 0D00:50:13.898781000 3890.56  S
MSFT| 0D00:50:13.254965000 9672.398 S
q)latestSymPrice
sym  | time                 price    side
-----| ----------------------------------
AMZN | 0D00:50:12.873095000 5294.808 B
META | 0D00:50:12.873095000 6137.452 B
APPL | 0D00:50:13.898781000 3890.56  S
MSFT | 0D00:50:13.254965000 9672.398 S
GOOGL| 0D00:51:35.301539000 2392.341 S
TSLA | 0D00:51:35.301539000 1508.133 B
/real time streaming analytics in action. Very quick especially or huge amouts of live data
/as data grows throughout the day, this sep process capturing the latest price provides a much more consistent performance for users all day long
q)latestSymPrice
sym  | time                 price    side
-----| ----------------------------------
AMZN | 0D00:50:12.873095000 5294.808 B
META | 0D00:50:12.873095000 6137.452 B
APPL | 0D00:50:13.898781000 3890.56  S
MSFT | 0D00:50:13.254965000 9672.398 S
GOOGL| 0D00:51:35.301539000 2392.341 S
TSLA | 0D00:51:35.301539000 1508.133 B
q)latestSymPrice
sym  | time                 price    side
-----| ----------------------------------
AMZN | 0D00:50:12.873095000 5294.808 B
META | 0D00:59:46.718798000 1946.509 B
APPL | 0D00:50:13.898781000 3890.56  S
MSFT | 0D00:50:13.254965000 9672.398 S
GOOGL| 0D00:51:35.301539000 2392.341 S
TSLA | 0D00:59:44.786584000 6108.817 B
q)latestSymPrice
sym  | time                 price    side
-----| ----------------------------------
AMZN | 0D00:50:12.873095000 5294.808 B
META | 0D00:59:46.718798000 1946.509 B
APPL | 0D00:50:13.898781000 3890.56  S
MSFT | 0D00:50:13.254965000 9672.398 S
GOOGL| 0D00:51:35.301539000 2392.341 S
TSLA | 0D00:59:44.786584000 6108.817 B
q)trade
time                 sym   price    side
----------------------------------------
0D00:50:12.873095000 META  6137.452 B
0D00:50:12.873095000 AMZN  5294.808 B
0D00:50:13.254965000 APPL  6346.716 B
0D00:50:13.254965000 MSFT  9672.398 S
0D00:50:13.898781000 APPL  8481.567 B
0D00:50:13.898781000 APPL  3890.56  S
0D00:51:35.301539000 GOOGL 2392.341 S
0D00:51:35.301539000 TSLA  1508.133 B
0D00:59:44.786584000 TSLA  4099.561 B
0D00:59:44.786584000 TSLA  6108.817 B
0D00:59:46.718798000 META  7148.779 B
0D00:59:46.718798000 META  1946.509 B
q)\\
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/rts.q -p 10813      architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)trade
time sym price side
-------------------
q)latestSymPrice
sym| time price side
---| ---------------
q)latestSymPrice
sym  | time                 price    side
-----| ----------------------------------
TSLA | 0D03:25:07.285805000 5042.288 S
GOOGL| 0D03:25:05.287314000 8760.631 B
META | 0D03:25:07.285805000 1734.786 B
APPL | 0D03:24:59.289794000 9066.913 S
AMZN | 0D03:25:04.286065000 7142.483 S
MSFT | 0D03:25:03.286501000 3758.779 S
q)trade
time                 sym   price    side
----------------------------------------
0D01:41:40.796854000 TSLA  1047.944 B
0D01:41:40.796854000 TSLA  6990.44  B
0D01:41:41.799900000 META  7019.831 B
0D01:41:41.799900000 GOOGL 7269.904 S
0D01:41:42.800621000 APPL  6501.981 S
0D01:41:42.800621000 TSLA  4837.422 B
0D01:41:43.801427000 META  4414.907 B
0D01:41:43.801427000 GOOGL 5652.261 B
0D01:41:44.803506000 MSFT  8685.452 S
0D01:41:44.803506000 AMZN  122.1208 S
0D01:41:45.800074000 APPL  5638.081 S
0D01:41:45.800074000 MSFT  3664.924 B
0D01:41:46.802630000 META  2188.574 B
0D01:41:46.802630000 GOOGL 4456.44  S
0D01:41:47.803426000 AMZN  2400.771 S
0D01:41:47.803426000 MSFT  1039.355 S
0D01:41:48.803471000 TSLA  3883.13  S
0D01:41:48.803471000 GOOGL 4843.79  S
0D01:41:49.800162000 APPL  807.7328 B
0D01:41:49.800162000 AMZN  536.7945 B
..
q)count trade
5876
q)




// CEP
Last login: Wed Oct 29 08:39:54 on ttys012
(base) ~
☺

(base) ~
☺  q tick/cep.q
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

'tick/cep.q. OS reports: No such file or directory
q)\\
(base) ~
☺  cd ~/Projects/KDB/qkiln/architecture\
>
(base) ~/Projects/KDB/qkiln/architecture
☺  q tick/cep.q                            architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)stats
'stats
  [0]  stats
       ^
q)stats
'stats
  [0]  stats
       ^
q)h_tp
6i
/now we start feedhandler
q)stats
sym  | maxPrice minPrice maxBid   minAsk
-----| -----------------------------------
APPL | 65077.85 58438.13 32251.55 32111.46
GOOGL| 52891.15 52891.15 32284.35 60252.4
MSFT | 42009.28 42009.28 24794.67 21233.14
AMZN | 1793.893 1793.893 54395.82 21248.61
META | 22284.62 22284.62 17478.16 14075.01
TSLA | 17284.84 16974.47 30343.33 40897.24
q)stats
sym  | maxPrice minPrice maxBid   minAsk
-----| -----------------------------------
APPL | 68443.6  61803.88 32251.55 32111.46
GOOGL| 52891.15 52891.15 40280.34 63933.84
MSFT | 43456.1  43456.1  30302.28 23371.04
AMZN | 12253.19 12253.19 57668    27699.78
META | 30423.3  30423.3  17478.16 14075.01
TSLA | 17284.84 16974.47 38845.79 45209.28
q)stats
sym  | maxPrice minPrice maxBid   minAsk
-----| -----------------------------------
APPL | 72247.76 65608.03 32251.55 32111.46
GOOGL| 52891.15 52891.15 40280.34 63933.84
MSFT | 48127.91 48127.91 38717.47 23593.35
AMZN | 12253.19 12253.19 57668    27699.78
META | 38496.64 33723.08 27292.74 20973.38
TSLA | 17284.84 16974.47 38845.79 45209.28
/done icnrementally by cep as new data arrives
q)







// READ TPLOG
Last login: Wed Oct 29 10:16:12 on ttys016
(base) ~
☺

(base) ~
☺  q
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)\\
(base) ~
☺  cd ~/Projects/KDB/qkiln/architecture

(base) ~/Projects/KDB/qkiln/architecture
☺  q                                       architecture ✗
KDB+ 4.0 2023.08.11 Copyright (C) 1993-2023 Kx Systems
m64/ 8(24)core 8192MB SamarthSoni macbookair 192.168.50.121 EXPIRE 2026.10.14 samarthsoni1@gmail.com KDB PLUS PERSONAL #5029847

q)get `:2025.10.29
'2025.10.29. OS reports: No such file or directory
  [0]  get `:2025.10.29
       ^
q)get `:sym2025.10.29
`upd `trade (0D00:38:42.888867000 0D00:38:42.888867000;`AMZN`MSFT;5159.796 40..
`upd `trade (0D00:38:48.341427000 0D00:38:48.341427000;`TSLA`META;7111.716 41..
`upd `trade (0D01:37:54.087231000 0D01:37:54.087231000;`AMZN`MSFT;5159.796 40..
`upd `trade (0D01:37:55.092900000 0D01:37:55.092900000;`MSFT`AMZN;6919.531 47..
`upd `trade (0D01:37:56.093452000 0D01:37:56.093452000;`GOOGL`TSLA;1508.133 1..
`upd `trade (0D01:37:57.094720000 0D01:37:57.094720000;`AMZN`TSLA;2747.066 57..
`upd `trade (0D01:37:58.094081000 0D01:37:58.094081000;`APPL`TSLA;6789.082 41..
`upd `trade (0D01:37:59.090539000 0D01:37:59.090539000;`APPL`META;2430.836 39..
`upd `trade (0D01:38:00.092973000 0D01:38:00.092973000;`TSLA`TSLA;2857.99 668..
`upd `trade (0D01:38:01.093030000 0D01:38:01.093030000;`MSFT`MSFT;4573.28 80...
`upd `trade (0D01:38:02.090175000 0D01:38:02.090175000;`MSFT`META;1069.924 42..
`upd `trade (0D01:38:03.091918000 0D01:38:03.091918000;`APPL`AMZN;9996.082 74..
`upd `trade (0D01:38:04.088748000 0D01:38:04.088748000;`GOOGL`TSLA;693.8325 4..
`upd `trade (0D01:38:05.090325000 0D01:38:05.090325000;`MSFT`GOOGL;4121.866 6..
`upd `trade (0D01:38:06.091123000 0D01:38:06.091123000;`META`GOOGL;683.2366 5..
`upd `trade (0D01:38:07.090098000 0D01:38:07.090098000;`GOOGL`TSLA;5459.723 8..
`upd `trade (0D01:38:08.092667000 0D01:38:08.092667000;`GOOGL`MSFT;9761.246 5..
`upd `trade (0D01:38:09.093475000 0D01:38:09.093475000;`APPL`META;2065.625 52..
`upd `trade (0D01:38:10.092798000 0D01:38:10.092798000;`AMZN`APPL;4194.691 18..
`upd `trade (0D01:38:11.092570000 0D01:38:11.092570000;`AMZN`GOOGL;1872.634 8..
`upd `trade (0D01:38:12.098380000 0D01:38:12.098380000;`GOOGL`AMZN;3923.249 8..
`upd `trade (0D01:41:40.796854000 0D01:41:40.796854000;`TSLA`TSLA;1047.944 69..
..
q)type get `:2025.10.29
'2025.10.29. OS reports: No such file or directory
  [0]  type get `:2025.10.29
            ^
q)type get `:sym2025.10.29
0h
q)bufv:get `:sym2025.10.29
q)bufv where bufv like "*quote*"
'type
  [0]  bufv where bufv like "*quote*"
                       ^
q)select quote from bufv
'type
  [0]  select quote from bufv
       ^
q)bufv
`upd `trade (0D00:38:42.888867000 0D00:38:42.888867000;`AMZN`MSFT;5159.796 40..
`upd `trade (0D00:38:48.341427000 0D00:38:48.341427000;`TSLA`META;7111.716 41..
`upd `trade (0D01:37:54.087231000 0D01:37:54.087231000;`AMZN`MSFT;5159.796 40..
`upd `trade (0D01:37:55.092900000 0D01:37:55.092900000;`MSFT`AMZN;6919.531 47..
`upd `trade (0D01:37:56.093452000 0D01:37:56.093452000;`GOOGL`TSLA;1508.133 1..
`upd `trade (0D01:37:57.094720000 0D01:37:57.094720000;`AMZN`TSLA;2747.066 57..
`upd `trade (0D01:37:58.094081000 0D01:37:58.094081000;`APPL`TSLA;6789.082 41..
`upd `trade (0D01:37:59.090539000 0D01:37:59.090539000;`APPL`META;2430.836 39..
`upd `trade (0D01:38:00.092973000 0D01:38:00.092973000;`TSLA`TSLA;2857.99 668..
`upd `trade (0D01:38:01.093030000 0D01:38:01.093030000;`MSFT`MSFT;4573.28 80...
`upd `trade (0D01:38:02.090175000 0D01:38:02.090175000;`MSFT`META;1069.924 42..
`upd `trade (0D01:38:03.091918000 0D01:38:03.091918000;`APPL`AMZN;9996.082 74..
`upd `trade (0D01:38:04.088748000 0D01:38:04.088748000;`GOOGL`TSLA;693.8325 4..
`upd `trade (0D01:38:05.090325000 0D01:38:05.090325000;`MSFT`GOOGL;4121.866 6..
`upd `trade (0D01:38:06.091123000 0D01:38:06.091123000;`META`GOOGL;683.2366 5..
`upd `trade (0D01:38:07.090098000 0D01:38:07.090098000;`GOOGL`TSLA;5459.723 8..
`upd `trade (0D01:38:08.092667000 0D01:38:08.092667000;`GOOGL`MSFT;9761.246 5..
`upd `trade (0D01:38:09.093475000 0D01:38:09.093475000;`APPL`META;2065.625 52..
`upd `trade (0D01:38:10.092798000 0D01:38:10.092798000;`AMZN`APPL;4194.691 18..
`upd `trade (0D01:38:11.092570000 0D01:38:11.092570000;`AMZN`GOOGL;1872.634 8..
`upd `trade (0D01:38:12.098380000 0D01:38:12.098380000;`GOOGL`AMZN;3923.249 8..
`upd `trade (0D01:41:40.796854000 0D01:41:40.796854000;`TSLA`TSLA;1047.944 69..
..
q)get `:sym2025.10.30
`upd `trade (0D00:50:12.873095000 0D00:50:12.873095000;`META`AMZN;6137.452 52..
`upd `trade (0D00:50:13.254965000 0D00:50:13.254965000;`APPL`MSFT;6346.716 96..
`upd `trade (0D00:50:13.898781000 0D00:50:13.898781000;`APPL`APPL;8481.567 38..
`upd `trade (0D00:51:35.301539000 0D00:51:35.301539000;`GOOGL`TSLA;2392.341 1..
`upd `trade (0D03:24:52.281617000 0D03:24:52.281617000;`MSFT`TSLA;3795.739 11..
`upd `quote (0D03:24:52.284135000 0D03:24:52.284135000;`AMZN`META;9933.337 58..
`upd `trade (0D03:24:53.286036000 0D03:24:53.286036000;`TSLA`TSLA;1988.952 84..
`upd `quote (0D03:24:53.286972000 0D03:24:53.286972000;`MSFT`AMZN;2793.491 40..
`upd `trade (0D03:24:54.283936000 0D03:24:54.283936000;`TSLA`META;700.4357 47..
`upd `quote (0D03:24:54.284533000 0D03:24:54.284533000;`MSFT`MSFT;3467.747 30..
`upd `trade (0D03:24:55.283339000 0D03:24:55.283339000;`MSFT`GOOGL;8132.29 25..
`upd `quote (0D03:24:55.284232000 0D03:24:55.284232000;`META`META;2124.561 39..
`upd `trade (0D03:24:56.285956000 0D03:24:56.285956000;`META`MSFT;9458.25 132..
`upd `quote (0D03:24:56.286528000 0D03:24:56.286528000;`TSLA`MSFT;5018.75 472..
`upd `trade (0D03:24:57.286281000 0D03:24:57.286281000;`TSLA`AMZN;5660.835 30..
`upd `quote (0D03:24:57.287341000 0D03:24:57.287341000;`GOOGL`APPL;8688.112 2..
`upd `trade (0D03:24:58.283545000 0D03:24:58.283545000;`AMZN`META;4203.975 80..
`upd `quote (0D03:24:58.286667000 0D03:24:58.286667000;`MSFT`AMZN;2532.575 44..
`upd `trade (0D03:24:59.289794000 0D03:24:59.289794000;`APPL`MSFT;9066.913 32..
`upd `quote (0D03:24:59.290827000 0D03:24:59.290827000;`MSFT`META;7756.408 48..
`upd `trade (0D03:25:00.286926000 0D03:25:00.286926000;`META`TSLA;4581.945 17..
`upd `quote (0D03:25:00.287418000 0D03:25:00.287418000;`META`GOOGL;6578.309 1..
..
q)