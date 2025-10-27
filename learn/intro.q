show "Hare Krishna"
/ "succinct" seems to be one of qauthor's fav words - and it very well describes the whole language as well!

"c"$0x57656c6c20646f6e6521
/"Well done!"

42
show a:42
b:1+a:42 / nothing here counts c:6*7
show b
c:45
3+d:7 / d is NOT referenced, rather the value of assignment is propagated forward

4%2
4.0%2.0

`aapl
`reallylongsymbol
`aapl=`apl

//date = num of days since millenium
2000.01.01 
2000.01.01=0 / actually 0
2000.01.01-1 /1999.12.31
//time = nanoseconds since midnight
00:00:00.000000001=1
00:00:00.100000000-100000000 /0.1s
00:00:01.000000000-1000000000 /1s
00:00:01.000000000-0010000000 /10 ms
00:00:01.000000000-0001000000 /1 ms
00:00:01.000000000-0001000000 /100 ms = 100,000,000 ns
12:00:00.000000000
12:00:00.000000000=12*60*60*1000000000 / this is noon
12:00:00.000000000+1000 /advance by 1 micros

//LISTS
(1; 1.2; `one) /general - one item per line
(1; 2; 3) /just space separated if homogenous
(2000.01.01; 2000.01.02; 2001.01.03)
(1b; 0b; 1b) /no spaces, just b at end
// constructing lists
42+2*til 10 / obtain the first 10 even numbers starting at 42.
// join "," operator -- just concats right to left
1 2 3,4 5
1 2 3,100
0,1 2 3
// take "#" operator -- ALWAYS returns a list
0#0 /0# returns empty list of same type
-2#til 10 /take from end
2#til 10 /take from start
20#til 10 /if more arguments, just repeats from start
-20#til 10 /negative also order remainds same
5 # 42 /make X copies of an atom
5#`apl
// assign and index - use square braces
L:10+til 3
L[2]

// FUNCTIONS
{[x] x*x}
{[x]x*x} /whitespace optional
sq:{[x] x*x}
pyth:{[x;y] a:x*x; b:y*y; a+b}
sq[5]
pyth[3;4]
{[x;y]a:x*x;b:y*y;a+b}[3;4]
/ function juxtaposition - dont require [..] for ONE param funcs
{x*x}5 /give whitespace though for clarity
{x*x}5 3
{x*x} 5 3
{a:x[0]*x[0];b:x[1]*x[1];a+b}3 4 /can use a list as a "single param" input as well
/ Functions are First-Class Citizens
(sq;pyth)         / Functions in a list
h:{:{x+y}}[]      / Return a function
/ an atomic function (built in operator) operates on lists by application to the individual items. For e.g., plain addition adds an atom to a list, a list to an atom or two lists of the same length.
42+100 200 300
100 200 300+42
100 200 300+3#42
100 200 300+1 2 3
/ this is also true of equality and comparison operators
100=99 100 101
100 100 100=100 101 102
100<99 100 101
// Higher order functions/ADVERBs
/"over" -- In words, we tell q to start with the initial value of 0 in the accumulator and then modify + with the iterator / so that it adds across the list
0 +/ 1 2 3 4 5
0 +/ 1+til 100 /5050
/we can use any operator or even our own function:
5000 -/ 1+til 100 /-50
0 {x+y}/ 1 2 3 4 5
0 {x+y}/ 1+til 100
0 {x-y}/ 1+til 100
/no need to specify first value of accumulator
(+/) 1 2 3 4 5
(+/) 1+til 100
/ for factorial
(*/) 1+til 5 /120
(*/) 1+til 10 /3628800
/ use | and & for finding max and min of a list:
42|98 /98
42&98 /42
(|/) 20 10 40 30 /40
(&/) 20 10 40 30 /10
prd sum max min /just names given to the above 4 
/ raise a num X to an exponent n using: (*/) n#X
(*/) 2#1.4142135623730949 /1.9999999999999996
n:5
(*/) n#10 /100000

/"scan" - does same as "over" except returns all intermediate values as well
(+\) 1+til 10 /1 3 6 10 15 21 28 36 45 55
(*\) 1+til 10 /1 2 6 24 120 720 5040 40320 362880 3628800
(|\) 20 10 40 30 /20 20 40 40
(&\) 20 10 40 30 /20 10 10 10
sums prds maxs mins /just names given to the above 4

/fibonacci
F0basecase:1 1
-2#F0basecase /take last 2 items
F1firstcase:1 1 2 /just for understanding
-2#F1firstcase
sum -2#F0basecase /add all elements
F0basecase,sum -2#F0basecase /append the sum of last 2 to the list
{x,sum -2#x} /rewritten for brevity
{x,sum -2#x}1 1
{x,sum -2#x}1 1 2
/^^ "apply function {..} on inp list 1 1 2"
/vv "apply function {..} on inp list 1 1 2, 10 times"
10 {x,sum -2#x}/ 1 1 2 /1 1 2 3 5 8 13 21 34 55 89 144 233
10 {x,sum -2#x}/ (1;1;2) /same
10 {x,sum -2#x}/ [(1;1;2)] /NOT SAME - tries to run recursively unti conversion, maybe due to the [..]
/^^*** q4m3 defines: "Wouldn’t it be nice if q had a higher-order function that applies a recursive function a specified number of times, starting with the base case" 

/newtons approximation to find zeroes
{[xn] xn-((xn*xn)-2)%2*xn}1 /for 2, num=x^2 -2, den=2x=derivative of num
{[xn] xn-((xn*xn)-2)%2*xn}1.5
{[xn] xn-((xn*xn)-2)%2*xn}1.416667
{[xn] xn-((xn*xn)-2)%2*xn}1.414216 /...so on
/vv*** q4m3 defines: "Wouldn't it be nice of q had a higher-order function to apply a function recursively, starting at the base case, until the output converges" 
{x,sum -2#x}/ [1 1] /starts spiralling because this keeps increasing

{[xn] xn-((xn*xn)-2)%2*xn}/ [1]

/to witness the convergence
\P 0 
/^^ max float point display
{[xn] xn-((xn*xn)-2)%2*xn}\ [1] /scan

/generalising,
{[c; xn] xn-((xn*xn)-c)%2*xn}
{[c; xn] xn-((xn*xn)-c)%2*xn}[2.0;] /now a projection, just unary
{[c; xn] xn-((xn*xn)-c)%2*xn}[2.0;]/ [1] /applied recursively on base case
{[c; xn] xn-((xn*xn)-c)%2*xn}[3.0;]/ [1] /for 3
{[c; xn] xn-((xn*xn)-c)%2*xn}[3.0;]\ [1] /to see all steps
3 {[c; xn] xn-((xn*xn)-c)%2*xn}[3.0;]\ 1 5 /to stop at 3rd step done twice with 2 different initial values (notice how we cannot use [..] aroud the input param

/more abstract, pth power in num, (p-1) power in den:
num:((*/) p#xn)-c
den:(p* (*/) (p-1)#xn)
{[p; c; xn] xn-(((*/)p#xn)-c)%p*(*/)(p-1)#xn} /just removed spaces
{[p; c; xn] xn-(((*/)p#xn)-c)%p*(*/)(p-1)#xn}[2;3]/[1] /replicating for 3
{[p; c; xn] xn-(((*/)p#xn)-c)%p*(*/)(p-1)#xn}[2;3]\[1]
{[p; c; xn] xn-(((*/)p#xn)-c)%p*(*/)(p-1)#xn}[5;7]/[1] /5th root of 7
{[p; c; xn] xn-(((*/)p#xn)-c)%p*(*/)(p-1)#xn}[5;7]\[1]



/ vv *** q4m3 defines: "Wouldn't it be nice if q had a built-in function that returned the successive differences of a numeric list?"
deltas 1 2 3 4 5 /1 1 1 1 1
deltas 10 15 20 /10 5 5
deltas 2 2 2 2 / 2 0 0 0
deltas (2 2 2 2;2 3 3 3) /applies successive difference where each successor is now a list not a number

/apply to FIFO
buys:2 1 4 3 5 4f
sell:12f
targetallocation:2 1 4 3 2 0
sums targetallocation /2 3 7 10 12 12 -- what we require
sums buys /2 3 7 10 15 19f
sell&sums buys /CAP cumulative buys at the sell --- use '&' to make it level off at max amount
/ 2 3 7 10 12 12f - equal to what we need. Now, use delta to unwrap
deltas sell&sums buys
/ 2 1 4 3 2 0f - equal to targetallocation

/what if we have list of sells
sells:2 4 3 2
targetallocations:((2 0 0 0 0 0);(0 1 3 0 0 0);(0 0 1 2 0 0);(0 0 0 1 1 0))
/ cumulative amounts to be allocated
sums[buys] /2 3 7 10 15 19f
/ cumulative amounts available for allocation
sums[sells] /2 6 9 11
/CAP cumulative buys at each cumulative sell
2&sums[buys] /2 2 2 2 2 2f
6&sums[buys] /2 3 6 6 6 6f
9&sums[buys] /2 3 7 9 9 9f
11&sums[buys] /2 3 7 10 11 11f 
/vv *** an iterator that applies a binary function and a given right operand to each item of a list on the left
/ "each left" \: (slash swinging left)
sums[sells] &\:sums[buys]
/ vertical successive differences
deltas sums[sells] &\:sums[buys]

/vv *** "each" applies a given function to each item of a list
count (2 2 2 2;2 3 3)
count each (2 2 2 2;2 3 3)
deltas each (2 2 2 2;2 3 3 3)
deltas each sums[sells] &\:sums[buys]
deltas each deltas sums[sells] &\:sums[buys] /final ans


// DICTIONARY
d:`a`b`c!10 20 30
d
d1:`a`b!(10 20 30;1 2)
/column dict;
d2:`a`b!(10 20 30;1.1 2.2 3.3) /each value is considered a column here
d2[`b][1] /index nested
d2[`b;1] /indexing at depth
d2[`b;0]
d2[`a;] /as if every ligitimate value had been specified in omitted position
d2[;]
d2[;1]
d2[1] /wont work
/ but [x;y] generally we're used to x=row, y=col. So we "flip"
d3:flip d2
/just difference, columns from second slot, sectoin dicts from first slot i.e. vice versa
d3[;]
d3[1;]
d3[;`a]
d3[1;`b]
d3[1] /logically same as a record dictoinary and hence table ==> list of record dicts logically; still flipped column dict on disk

/more convenient syntax:
([] a:10 20 30; b:1.1 2.2 3.3) /no need to specifically write column names symbols
([] `a1: 10 20 30; `b1:1.1 2.2 3.3) /but we can -- NOPE WE CANNOT

// q-sql
t:([] c1:1000+til 6; c2:`a`b`c`a`b`a; c3:10*1+til 6)
select from t
select c1, val:2*c3 from t
select count c1, sum c3 by c2 from t /all records having common values in by col are grouped together and then either aggregation is performed or all values are joined together onto a list
select count c2 by ovrund:c3<=40 from t / CAN BY ON COMPUTED COLUMNS
select c2 by ovrund:c3<=40 from t
update c3:10*c3 from t where c2=`a /scale the c3 column of t just in the positions having c2 equal to `a
/ sort table; left operand ==> symbol column names in major-to-minor order
`c2 xasc t
`c2 xdesc t
`c2`c3 xdesc t
/ rng
10?20
10?1.0
10?100.0
100*(10?1.0)
16?`hare`krishna`rama
16?`hare`krishna`hare`rama
10*1+1000000?1000 /1 add to ensure no 0s
10*1000000?1000

1000000?1.0
90.0+(1000000?2001)%100 /random 90.0-110.0 values
90.0+(1000000?1000)%100
90.0+(1000000?21.0)

/trades table
dts:2025.10.01+1000000?31
tms:1000000?24:00:00.000000000
syms:1000000?`aapl`goog`ibm
vols:10*1+1000000?1000 /volumes in blocks of 10
pxs:90.0+(1000000?2001)%100 /in cents, frmo 90.0-110.0
trades:([] dt:dts; tm:tms; sym:syms; vol:vols; px:pxs)
5#trades
trades:`dt`tm xasc trades
5#trades
/adjust prices according to Oct 2025
trades:update px:px*2.5 from trades where sym=`aapl
trades:update px:px*2.5 from trades where sym=`goog
trades:update px:px*2.9 from trades where sym=`ibm
5#trades
/sanity checks
select avg px, avg vol by sym from trades
select min px, max px by sym from trades
/ "xbar"
5 xbar til 15 /pull down all intervals of "leftoperandvalue's width" to leftmost value
/ "wavg"
1 2 3 wavg 50 60 70 /attach weights from left onto right before avg
1 2 30 wavg 50 60 70 
/calc vwap in 100ms buckets:
select vwap:vol wavg px by sym,bkt:100000000 xbar tm from trades
/calc max drawdown i.e. largest +ve difference in profit where buy precedes sell
/basically its about buying as low as possible and selling as high as possible
/so we calculate the max possible difference betw the lowest price uptil a current moment and the current moment's current price
select max px-mins px from trades where sym=`aapl
mins pxs
pxs
pxs-mins pxs
max pxs-mns pxs