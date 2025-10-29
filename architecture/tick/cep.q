/ q tick/cep.q  -p 5015
system"l tick/sym.q"

/cep = complex event processor
/rte = real time engine
/for e.g. last value cache - maintains a keyed table where it keeps updating each sym with its latest received price
/connects to tickerplant
/no need to do basic select statements or multiple calculations on rdb anymore - everything's in this table already
/^^ anyways for rdb data volumes keep increasing and query times get slower
/more complex real time subscribers could do further abstraction and output summary statistics etc
/^^-- e.g. do vwap/ohlc/mavg calculations for each sym, add business logic, update in a keyed statistics table
/done incrementally by cep so client doesnt need to re-calculate from raw data every time they need it

h_tp:hopen 10810;

/ initialize empty stats tables -- similar lines along regular tables; these are keyed on sym
.cep.tradeStats:([sym:`symbol$()]maxPrice:`float$();minPrice:`float$())
.cep.quoteStats:([sym:`symbol$()]maxBid:`float$();minAsk:`float$())

.cep.updTrade:{[x] /max price and min price grouped by sym
    .cep.tradeStats+:select maxPrice:max price, minPrice:min price by sym from x;
    `stats set .cep.tradeStats lj .cep.quoteStats /join to have stats from trades table as well as quotes table
    }

.cep.updQuote:{[x] /max bid price, min ask price
    .cep.quoteStats+:select maxBid:max bid, minAsk:min ask by sym from x;
    `stats set .cep.tradeStats lj .cep.quoteStats
    }

/because of the above, whether an update for trades comes in or update for quotes, that stats table will be updated with the ;atest info

upd:`trade`quote!(.cep.updTrade;.cep.updQuote) /instead of regular insert, "if trade record comes in run updTrade, if quote record comes in, run updQuote"
h_tp"(.u.sub[`;`])";
.u.end:{}

/advanced production application:
/log user queries --> look for frequently ran ones/identify & log most frequent --> implement logic in custom calculations in cep process
/ like open high low close
/ volume weighted average price
/ trades asof quote value -- calc real tiem trades with latest quote value (for each trade, get the prevailing quote asof the time of that trade); uses asof time series join -- can refer to "Real-time tick susbcribers white paper"
