/ q tick/feed.q
/open port to TP
h_tp:hopen 10810;

/.z.n - gives system time
/the inner thing inside those practed is just selecting 2 rows randomly from those values
/.u.upd -- defined in tick.q, it is called whenever feedhandler publihes data to TP
/ we will use batch mode -- so set timer ( -- .z.ts -- ), for every 1sec/1000 ms for now
.z.ts:{h_tp"(.u.upd[`trade;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)])";
       h_tp"(.u.upd[`quote;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?10000f;2?500i;2?500i)])"};
system"t 1000"; /interval is set here -- 1000 ms

/ to run manually for demo purposes copy/paste the following:
/ create table two rows in length - columns time, sym, price, side - schemas must match,else we will get mismatch
/ h_tp"(.u.upd[`trade;(2#.z.n;2?`APPL`MSFT`AMZN`GOOGL`TSLA`META;2?10000f;2?`B`S)])"