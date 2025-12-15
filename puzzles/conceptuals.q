// conceptual questions

whats causing bad side or scripterror or expected result of this query, wjhat might be causing this particular error etc.
matrix multiplaction and iterator style questions

/ 1. shorthand way of getting a null — which is the same type of a given number
null 5 /to check if null
/fails...
(type 5)$5 /fail
type 0N
x:4.5
`(0N)$5
0W*x 
0N!3.14
0n*3.1
0n*2025.01.01
0n*4
0n*" "
0W*" "
/workaround:
NullOf:{[x] (enlist x) 1}
NullOf 8
NullOf 8.8
NullOf 2025.05m
NullOf " "
NullOf 1b

/ 2. 3 ways to define a table?
/ONE
([] c1:`a`b;c2:(1 2))
/keyed table
([sym:`a`b] price:100 200; size:10 20)
/TWO
flip (`c1`c2)!(`a`b;1 2)
t:([] time:`time$(); sym:`$(); price:`float$(); size:`int$())
t upsert (12:00:00.000;`aapl;3.14;500) /THIRDS WAY: UPSERT
`t upsert (12:00:00.000;`aapl;3.14;500)
t,:(13:00:00.000;`goog;6.14;200)
t
update c3:`c`d, c4:6 7 from ([] c1:`a`b;c2:(1 2)) /FOURTH WAY -- Add columns
/FIFTH WAY
d1:`c1`c2!(`a`d;1 7)
d2:`c1`c2!(`b`c;2 9)
type d1 /99h
type (d1; d2) /98h
t:(d1; d2)

/ 3. how to apply data attributes to a dictionary
`attr#y /attr is one of s, u, g, p; y is a list, dictionary or table
(`u#`a`b`c)!100 200 300 / unique attribute applied
`s# (`a`d`b`c!1 100 2 3) /s-fail
`s# (`a`a`b`c!1 100 2 3) /success
(`u#`a`d`b`c)!(1 100 2 3) /success
(`u#`a`a`b`c)!(1 100 2 3) /success
(`a`a`b`c)!(`u#1 1 2 3) /u-fail
(`a`a`b`c)!(`u#1 1.1 2 3) /sucess
/check
attr `s# (`a`a`b`c!1 100 2 3)
attr value (`a`a`b`c)!(`u#1 1.1 2 3)
attr key (`a`a`b`c)!(`u#1 1.1 2 3) /none
attr (`a`a`b`c)!(`u#1 1.1 2 3) /none
dic: (`c1`c2)!(`a`b;1 2)
dic:`s # dic
dic[`c0]:100 40 /step error
dic[`c3]:100 4000 /step error
attr[dic]=`s
attr[ dic[`c2]]=`s/ 0b

s:`a`b`c
attr [s]=`s /false since not yet assigned

/ Sorted  `s#
/ Asserts that the list (or keys of a dictionary/table) are in ascending order. Enables binary search, step-function behaviour for dictionaries. -- query by ranges
/ Lists; dictionaries (via keys); table columns (and thereby tables) 
/ Must be truly sorted or you’ll get ’s-fail. On dictionaries it gives step-function behaviour. 
/ Unique  `u#
/ Asserts that all items are unique. Enables hash-based lookup optimisations.  ---- fast exact lookups on distinct keys/values
/ Lists (and thus table columns) 
/ Useful when you know values are distinct and will be used for lookups. Memory overhead may increase. 
/ Parted  `p#
/ Asserts that equal values are adjacent (grouped) in a list. Good for run-length / partitioned storage optimisations. ---- logic by block or efficient storage
/ Lists (and columns) 
/ Much more efficient on disk or compressed when data is naturally “blocks” of identical values. 
/ Grouped  `g#
/ Builds a hash / index of value → positions so fast lookup of all occurrences. ---- Data has repeated values but spread out and you want lookup positions of each value
/ Lists (and columns) 
l:3 1 2
l:asc l        / sort the list
l:`s#l
attr l /`s

t:([] dt:`#asc 2002.03.04 + til 3; sym:`a`a`b; price:10 20 30)
update `s#dt from `t
meta t

l:`a`b`a
l:`u#l
attr l /hash table internally, so lookups on that list are O(1)

l:`a`b`a`c`b`c`c
attr l
l:`p#l /fail
l:asc l
l:`p#l /each unique value forms a contiguous block; look-ups can leverage that

/ Assume `sym` column has many repeated values and queries filter on `sym`
update `p#sym from `t
meta t

l:`a`b`c`a`b
l:`g#l
attr l /`g -- q builds an index (hash table) mapping each distinct value to the list of positions where it occurs; useful when values repeat but you still need to find all occurrences quickly


/ 4.
/ q - WHAT (declarative/desired transformation, no describing the process, only describing the RESULT)
/  -- here, Double of all even numbers --  "Give me 2 times the numbers where remainder is 0"
/ - HOW = you control the machinery (loops, counters, temporary variables) ==> You must mentally execute the loop to understand final result, so more cognitive load; simulate the process step by step
/ - WHAT = you describe transformations (the system figures out the machinery) ==> You immediately understand the transformation; less cognitive load: Just pattern match the transformation
result: 2 * nums where 0 = nums mod 2
/ another puzzle: return double of all nums at the even indices, not caring what the actual value is
{[nums] 2 * nums where 0 = (til count nums) mod 2} [1 5 6 7] /2 12
{[nums] 2 * nums where 1 = (til count nums) mod 2} [1 5 6 7] /10 14

/ 5. some practise questions for fby
\l architecture/sym
/ then we go back up the two levels to original root
\cd ../..
\pwd
.sam.quote:select from quote
.sam.trade:select from trade
fbyt:aj[`sym`time;`time xasc .sam.trade;`time xasc .sam.quote]
fbyt /loaded above
/5.1. Select all trades where the price equals the maximum price for that symbol
select from fbyt where price=(max;price) fby sym
select from fbyt where price=(max;price) fby ([] sym;side) /both sym and side together
/5.2 Select all trades where bsize is greater than the average bsize for that symbol
select from fbyt where bsize>(avg;bsize) fby sym
/ if you want to add the column to the above table without listing out all columns, you must update later
select (cols fbyt),avbsz:avg bsize from fbyt where bsize>(avg;bsize) fby sym /DOESNT WORK
update avbsz:avg bsize from (select from fbyt where bsize>(avg;bsize) fby sym)
/5.3 Add a column showing each symbol's total volume, alongside each trade   *****   Adding fby result as column
update totalvol:(sum;bsize) fby sym from fbyt
/5.4 Select trades where price is above that symbol's average price AND size is at least 100
select from fbyt where price>(avg;price) fby sym,bsize>=100
/5.5 Add a column showing how many trades exist for each symbol
update counttrd:(count;i) fby sym from fbyt

/ 6. string functions
"," sv ("one";"two";"three") /"one,two,three"
` sv ("one";"two";"three")
/    "one
/    two
/    three
/    "
` sv `$("one";"two";"three") /`one.two.three
"," sv `$("one";"two";"three") /'type'

/string search and replace function ssr[x; y; z] /returns string x with each substring matching pattern y replaced by z
ssr["toronto ontario"; "ont"; "x"] /"torxo xario"

/trim/ltrim/rtrim: These remove nulls or whitespace from ends of lists. trim x removes both leading and trailing nulls (or spaces for strings), ltrim x removes leading ones, and rtrim x removes trailing ones
/For example, trim "   IBM   " yields "IBM" ￼, and trim 0N 0N 1 2 3 0N 0N 4 5 0N 0N yields 1 2 3 0N 0N 4 5 (leading/trailing 0N removed)

/postfixed ’ applies a function to each element of a list or pair of lists
{x*x}'[1 2 3] /squares each number, and
-[1]'/: 2 3 5 7 /would compute successive differences (each-prior)
(-) prior 2 3 5 7 /2 1 2 2
(-)': 2 3 5 7 /2 1 2 2

/?[x; y; z] is the vector conditional (ternary vectorized): if x is a boolean list, it picks elements from list y where x is true and from list z where x is false ￼. For example,
?[11001b; 1 2 3 4 5; 10 20 30 40 50] /1 2 30 40 5 -- element wise if-else logic

/with a list x ? y finds the index of y in list x (or count x if not found)

/With an integer, n?m deals a random subset of size n from 0..m-1 (or shuffles if n is negative)

/A$B does matrix multiply


/.Q.get vs .Q.value: These are essentially the same. Both load or evaluate an object from a file or string. By convention, get is used for file I/O and value for evaluating strings, but “the function value is the same as get” ￼. For example, value "2+3" and get "2+3" both return 5 ￼. Under the hood they share the same internal code

/.Q.prior vs .Q.peach: Prior and peach are both adverbs in q (and also accessible via .Q). prior applies a binary function between each consecutive pair of elements (it’s a mnemonic for the each-prior adverb ':) ￼. For example,
(-) prior 10 11 12 13 14 /yields 10 1 1 1 1 (first element 10, then successive differences) ￼.
/peach applies a unary function to items in parallel (each on multiple threads). If no secondary threads are available, peach falls back to regular each
/a dyadic function used with peach will actually behave like each-prior on the list (applying to consecutive pairs) due to how the iterator resolves arity. This is why one might see .Q.prior and .Q.peach mentioned together – for unary functions they do different things (sequential vs parallel application), but a binary function with peach ends up akin to using prior
(-) peach 10 11 12 13 14 /ALSO yields 10 1 1 1 1
(count) peach 10 11 12 13 14 / yields 1 1 1 1 1
({2*x}) peach 10 11 12 13 14 / yields 20 22 24 26 28

/rran func generator
ops:(+;-;*;%);
ops[rand count ops]

.sam.dic
delete dic from `.sam /delete a value from its namespace
.Q.gc[]   / force garbage collection to reclaim memory

