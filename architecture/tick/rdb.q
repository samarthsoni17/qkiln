/q tick/rdb.q [host]:port[:usr:pwd] [host]:port[:usr:pwd]
/2008.09.09 .k ->.q

if[not "w"=first string .z.o;system "sleep 1"];

upd:insert;

/ get the ticker plant and history ports, defaults are 10810,10812
.u.x:.z.x,(count .z.x)_(":10810";":10812");

/ end of day: save, clear, hdb reload
/ helps in step 2-3 of EOD - write data to disk. Uses in-built functions, saves table to location specified, clears table from memory
/ sends reload message to processes so new data is mapped there available for users to query
/ MODIFICATION - can tell rdb which tables we'd like to be saved as partitioned/splayed/flat files --- by swapping out .Q.hdpf for more customised use of various q functions like .Q.dpft, .Q.par, .Q.en
.u.end:{t:tables`.;t@:where `g=attr each t@\:`sym;.Q.hdpf[`$":",.u.x 1;`:.;x;`sym];@[;`sym;`g#] each t;};

/ init schema and sync up from log file;cd to hdb(so client save can run)
/ "replay the log file to preserve the integrity of the data" -- << -11! >> is what does it
/ -11! (bang) does it row by row so if we have a really large log file in GB etc,it safely loads it in and doesnt crash
/ ^^ as opposed to using get, which would load everything all at once
.u.rep:{(.[;();:;].)each x;if[null first y;:()];-11!y;system "cd ",1_-10_string first reverse y};
/ HARDCODE \cd if other than logdir/db

/ connect to ticker plant for (schema;(logcount;log))
/if rdb stops and needs to reload, it reads back everything from tplog file

.u.rep .(hopen `$":",.u.x 0)"(.u.sub[`;`];`.u `i`L)";

/ access function in RDB/HDB
selectFunc:{[tbl;sd;ed;ids]
  $[`date in cols tbl;
  select from tbl where date within (sd;ed),sym in ids;
  [res:$[.z.D within (sd;ed); select from tbl where sym in ids;0#value tbl];
    `date xcols update date:.z.D from res]] }

