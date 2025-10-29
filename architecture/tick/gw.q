/ q tick/gw.q
/open handle to rdb/hdb
h_hdb:hopen 10812;
h_rdb:hopen 10811;

/gateway abstracts users away from end processes
/ layer of protection -- user doesnt run bad query to corrupt/bring down process or server
/ central connection point
/ join data from multiple process, join them together, return as one

/ stored procedure in gateway
/ sd:start date; ed:end date; ids:list of ids or symbols
/ simple function that calls selectFunc which is defined on both hdb and rdb
getTradeData:{[sd;ed;ids]
  hdb:h_hdb(`selectFunc;`trade;sd;ed;ids);
  rdb:h_rdb(`selectFunc;`trade;sd;ed;ids);
  hdb,rdb }

/lets add another function for dashboard query - we only want last record for each symbol in each day returned
getLastTradeData:{[sd;ed;ids]
  hdb:h_hdb(`selectFunc;`trade;sd;ed;ids);
  rdb:h_rdb(`selectFunc;`trade;sd;ed;ids);
  select from hdb,rdb where time=(max;time) fby ([] date;sym) }

//best practises for gw:
/1. run only lightweight code
/2. track disconnections and usual user queries
/3. return intelligent errors when queries fail
/4. Load management specific to what users and system needs