(1; 1.1; `1) /multi line
(1;2;3) /1 2 3 -- automatic conversion to simple list
("a";"b";"c";"d") /"abcd"
(`Life;`the;`Universe;`and;`Everything) /`Life`the`Universe`and`Everything -- symbol lists
(-10.0; 3.1415e; 1b; `abc; "z") /multi line
((1; 2; 3); (4; 5)) /1 2 3 \n 4 5
((1; 2; 3); (`1; "2"; 3); 4.4)
/        1 2 3
/        (`1;"2";3) ==> this time it didnt go multi line
/        4.4

/for simple lists of short and int
(1h; 2h; 3h) /1 2 3h
1 2 3h /1 2 3h
(100i; 200i; 300i) /100 200 300i
(1; 2; 3h) /now this is a mixed list

/float same as long
(123.4567; 9876.543; 99.0) /123.4567 9876.543 99
123.4567 9876.543 99 /123.4567 9876.543 99
/a list of floats having no decimal parts displays with a trailing ‘f’
1.0 2.0 3.0 /1 2 3f
1.1 2 3.3~1.1 2.0 3.3 /q assumes you are following its convention by leaving out the redundant ".0" ...

/boolean and bytes get juxtaposed together
(0b;1b;0b;1b;1b) /01011b
01011b /01011b
(0x20;0xa1;0xff) /0x20a1ff
0x20a1ff~(0x20;0xa1;0xff) /1b

/like ints, guids are separated by spaces
3?0Ng /you'll get these around the 25th-30th mark i think:.... 6c6f0626-e96a-5a7c-6a3d-5db67d4a4a62 ee853957-d502-d30d-5945-bf8c97022332 3c2cc08f-763b-0812-06e5-5f36344623c7

/symbols needs NO spaces
`bad `news /error
`Hare`Krishna / `Hare`Krishna

/char lists look like strings
("s"; "t"; "r"; "i"; "n"; "g") /"string"
"string" /"string"
/strings are not atoms, hence '=' doesnt work
"string"="text" /len error
"string"="Krishn" /000000b
"string"~"text" /0b

/temporal are integers hence space separated
(2000.01.01; 2001.01.01; 2002.01.01) /2000.01.01 2001.01.01 2002.01.01
(00:00:00.000; 00:00:01.000; 00:00:02.000) /00:00:00.000 00:00:01.000 00:00:02.000
/The temporal vector notation allows items to be written in the notation of a narrower type, which the parser silently widens
12:34 01:02:03 /12:34:00 01:02:03
01:02:03 12:34 /01:02:03 12:34:00
/   *****   to force the type of a mixed list of temporal values, append a type specifier
01:02:03 12:34 11:59:59.999u /01:02 12:34 11:59

/empty list
() /no console display
-3!() /   *****   "Wizard of Oz" operator -- converts any q entity into a string suitable for display
.Q.s1 () /   *****   .Q.s1 is the utility that does the same thing
-3!`Hare`Krishna /"`Hare`Krishna"
string(`Hare`Krishna) /("Hare";"Krishna")

/singleton list - only way to create is using enlist
(42) /doesnt work, == (40+2)
,42 /doesnt work, ',' is not a monadic function in q as it is in k
enlist 42 /only way ==> ,42
42,() /also another way ==> ,42
(),42 /also another way ==> ,42
enlist "a" /string with single character ==> ,"a"
"a"~enlist "a" /0b ... different from "a"
"a"=enlist "a" /,1b ... elementwise comparision
/singleton with complex element as item not atom:
enlist 1 2 3 /1 2 3
type enlist 1 2 3 /0h
enlist (10 20 30; `a`b`c) /10 20 30 a  b  c
first enlist (10 20 30; `a`b`c) /the internals now get unpacked

/mutation vs rebinding
a: 1 2 3
a: a, 4      / Creates new list [1 2 3 4], rebinds 'a' to it
             / Original [1 2 3] is discarded

/We can verify this isn't mutation by checking if other references change:
b: a         / b and a point to SAME list
b / 1 2 3 4
a: a, 5      / Creates NEW list, rebinds a
a            / 1 2 3 4 5
b            / 1 2 3 4 (unchanged! proves a got NEW list)

/Now, Compare to actual mutation with amend:
a[3]: 108      / MUTATES the list in place (using indexed assignment)
a              / 1 2 3 108 5
b              / 1 2 3 4  (still unchanged! same underlying object)


count 1 2 4 /3
count `zaphod /1 - cout of atom is always 1
count `boolean$() /0 - empty list

first 1 2 4 /1
last 1 2 4 /4

/indexing -- out of bounds returns     *****    null of type of ITEM AT INDEX=0
100 200 300[2] /300
100 200 300f[4] /out of bounds = null = 0n here
100 200 300f[-1] /-1 index also out of bounds = anything outside 0..n-1
(`1; 2; 3.3)[0W] /`
(`1; 2; 3.3)[] /omitted index returns the ENTIRE list
(`1; 2; 3.3)[1 2] /we can index with a list
(`1; 2; 3.3)[()] /    *****    indexing with an empty list returns an empty list
(`1; 2; 3.3)[::] /    *****    nil item ==> allows explicit notation for empty index

type :: /==> @: the type of the nil item does not match any other type in q
type (::; 1 ; 2 ; 3) /==> 0h;  hence inclusion of the nil item in a list forces the list to be general.
L:(::; 1 ; 2 ; 3)
.Q.s1 L[0]
/ inclusion of '::' in the list can act as a guard, preventing it from being auto converted to a simple list
(1; 2; 3; `a)[3]:4 /gives 'assign error since the underlying object is ummutable (this is my own reflection)
type L2:(1; 2; 3; `a) /0h
L2[3]:4
type L2 /7h
L2[3]:`a / 'type error

type L /0h
L[3]:`a / if you try to do type L[3]:`a directly, you get -11h instead............
type L /0h

/list construction via expressions
b:1+a:42
(a; b) /42 43
a b /ERROR 'Cannot write to handle 42. OS reports: Bad file descripto
L1:1 2 3
L3:40 50
(L1; L3) /1 2 3 \n 40 50
(count L1; sum L3) /3 90

/join
1 2 3,4 5
1,2 3
1 2,3
1 2 3,4.4 5.5 /general list
1 2 3,4,4 5,5 /see? it is appending multiple times with no problem... 1 2 3 4 4 5 5
1 2 3,4.4,4 5,5 /(1;2;3;4.4;4;5;5)

/coalesce -- right prevails except when it is Null
L1[1]:0N /possible, because L1 was long list
L1[0]:0n /'type error
L3,:2#0N /40 50 0N 0N
L1,:0N /1 0N 3 0N

L1^L3 /40 50 3 0N

101 102 103 104 /can be seen as a   *****   MAP from domain of integers to codomain of f:{101 + x},x<4

L4:(1;2;(100 200))
count L4 /3

()~enlist () /0b
count () /0
count enlist () /1

/indexing
L5:enlist L2 /1 2 3 4
count L5 /1
count L5[0] /4
count L5[1] /0 ==> because now L5 is a list of `long$()
L5:enlist L /:: 1 2 `a
count L5 /1
count L5[0] /4
count L5[1] /   *****   4 ==> because now L5 is a list of (::;0N;0N;`) now.....
/if oyu try to index an atom you get 'type error...
L5[0][1] /1
L5[0][1][0] /`type

m:((11; 12; 13; 14); (21; 22; 23; 24); (31; 32; 33; 34))
m
/    11 12 13 14
/    21 22 23 24
/    31 32 33 34
m[0] /11 12 13 14
m[1] /21 22 23 24
m[1][0] /21
m[1][3] /24
m[1,3] /(21 22 23 24;`long$()) ==> doesnt work as expected, 1,3 becomes a list 1 3
m[1;3] /24 ==> DOES work as expected, dont confuse with ',', common qbie mistake

L6:(1; (100; 200; (1000; 2000; 3000; 4000)))
L6[0] /1
L6[1]
/    100
/    200
/    1000 2000 3000 4000
/iterated indexing
L6[1][2] /1000 2000 3000 4000
L6[1][2][0] /1000 ==> kind of one by one
/indexing at depth
L6[1;2;0] /1000 ==> kind of all at once
L6[1 2 0] /((100;200;1000 2000 3000 4000);0N;1)
/assignment
L6[1; 2; 0]: 999 /works ==> (1;(100;200;999 2000 3000 4000))
L6[1][2][0]:42 /'assign

/   *****   creating (possibly ragged) arrays from a flat list
FL:til 10 /0 1 2 3 4 5 6 7 8 9
2 0N#FL /==> cut the flat list into two rows, i dont care how many columns/individual items in each
/    0 1 2 3 4
/    5 6 7 8 9
0N 3#FL /==> cut the flat list into three cols, i dont care how many rows/total lists that come
/    0 1 2
/    3 4 5
/    6 7 8
/    ,9

/indexing with lists
"beeblebrox"[0 7 8] /bro
01101011b[0 2 4] /011b

/Indexing via a Variable
I:0 2
100 200 300 400[I] /100 300
/Indexing with Nested Lists -- gives same shape as the index list
100 200 300 400[(0 1; 2 3)] /(100 200;300 400)

/Assignment with List Indexing
L3[1 2 3]:2000 3000 4000
L3[1 1 1]: 50 101 108 /happens in sequence, so if repeated item, rightmost item prevails
L2[1 3]:1080 /single element assigned to multiple
L2[1 3 2]:11 22 /'length

/indexing without brackets -- "juxtaposition"
L2 0 /1
L3 1 2 3 /108 3000 4000
I /0 2
L3 I /   *****   can index via lists ==> 40 3000
L3 :: /   *****   returns everything

/find -- Since Find maps an item to its index, it is inverse to indexing – i.e., list positional retrieval thought of as a mapping
1001 1002 1003?1002 /1
1001 1002 1003?1003 1001 /2 0 ==> extends to lists, it is atomic in its right operand

/elided index - eliding any index slot == specifying all legitimate indices for that slot
m /3x4 matrix, first didigt = row; seconnd digit = col
m[1;2] /23
m[;2] /13 23 33
m[1;] /21 22 23 24
m[1;]~m[1] /1b ==> eliding the last index reduces to item indexing at the top level.

/three levels of nesting
L7:((1 2 3;4 5 6 7);(`a`b`c`d;`z`y`x`;`0`1`2);("now";"is";"the"))
L7
/    (1 2 3;4 5 6 7)
/    (`a`b`c`d;`z`y`x`;`0`1`2)
/    ("now";"is";"the")
/ lvl1 == items at top level i.e. (1 2 3;4 5 6 7) & ("now";"is";"the")
/ lvl2 == items at second level i.e. 1 2 3  &  `z`y`x`  &  "the"
/ lvl3 == items at third level i.e. 7  &  `d  &  "w"
L7[2;;] /==> L7[2] ==> Retrieve the top level list at 2 == the item at index 2
/    "now"
/    "is"
/    "the"
/| shape: 1*(len of cluster of lvl2-items at 2th lvl1)*(len of cluster of lvl3-items at each lvl2 inside 2th lvl1) == 1*3*(3,2,3) == dimn of 2th row/lvl1
/    ("now";"is";"the")
L7[;1;] /==> Retrieve all items at index 1 of each top level list
/    4 5 6 7
/    `z`y`x`
/    "is"
/| shape: (len of cluster of lvl1 items = count L7)*1*(len of cluster of lvl3-items at 1th lvl2 at each lvl1) == 3*1*(4,4,2) == dim of 1th column
/    (4 5 6 7;`z`y`x`;"is")
L7[;;2] /==> Retrieve the items at index 2 for each list inside each top level list (i.e. for each list at the second level of the matrix)
/    3 6
/    `c`x`2
/    "w e"
/| shape: (len of cluster of lvl1 items)*(len of cluster of lvl2 items at each lvl1)*1 == 3*(2,3,3)*1

/lets combine elided indexing with list-driven indexing...
L7[0 2;;0 1] /get the 0th and 1th element from each second level list inside the 0th and 2th top level list
/my prediction:  (WRONG)
/    1 4
/    "nit"
/    2 5
/    "osh"
/| shape has to conform to:   2 * (len of cluster of lvl2 items at 0th and 2th lvl1) * 2 == 2 * (2,3) * 2
/ ANSWER
/    (1 2);(4 5)
/    "no";"is";"th"
/ interpretation -- Retrieve the items at positions 0 and 1 from all columns in rows 0 and 2

/transpose
rect:(1 2 3; 10 20 30; 100 200 300)
rect
1 2 3
10 20 30
100 200 300
flip rect
1 10 100
2 20 200
3 30 300
rect[1;2]~(flip rect)[2;1] /1b ==> reverses the first and second slots in indexing at depth -- but not the further depths if present...
rect[2;] /ith row ==> 100 200 300
rect[;2] /jth col ==> 3 30 300

/3-d and higher matrices... less frequent in q
mm:((1 2;3 4;5 6);(10 20;30 40;50 60))
mm
/    1 2   3 4   5 6
/    10 20 30 40 50 60
mm[0]
/    1 2
/    3 4
/    5 6
mm[1]
/    10 20
/    30 40
/    50 60
m 0 2
/    11 12 13 14
/    31 32 33 34

/til
-5+4*til 3 /-5 -1 3
/distinct
distinct 1 2 3 2 3 4 6 4 3 5 6 /1 2 3 4 6 5
/where
where 101010b /0 2 4

L8:10*1+til 5 /10 20 30 40 50
L8[where L8>20]:42
L8 /10 20 30 40 50

/group
group "i miss mississippi" /==> ("i msp")!(0 3 8 11 14 17;1 6;2 7;4 5 9 10 12 13;15 16)
/    i| 0 3 8 11 14 17
/     | 1 6
/    m| 2 7
/    s| 4 5 9 10 12 13
/    p| 15 16

/ some more experiments on where, ".", "@" ...
show (5 xprev til 10) /0N 0N 0N 0N 0N 0 1 2 3 4
where show (5 xprev til 10) /'type
til 5 /0 1 2 3 4
where til 5 /1 2 2 3 3 3 4 4 4 4
where 1 2 /0 1 1
where 0 1 /,1
where 0 1 2 /1 2 2
where 2 3 / 0 0 1 1 1
(0 1 2 3 4) where 2 3 /first element 2 times, second element 3 times ==> 0 0 1 1 1
(5 4 3 2) where 2 3 /first element 2 times, second element 3 times ==> 5 5 4 4 4
(5 4 3 2) where 2 3 2 2 2 /first element 2 times, second element 3 times ==> 5 5 4 4 4 3 3 2 2 0N 0N
(5 4 3 2) where 10101b /first element 2 times, second element 3 times ==> 5 5 4 4 4 3 3 2 2 0N 0N
{x#1b} each (2 3 2 2 2)
(5 4 3 2) where {x#1b} each (2 3 2 2 2) /==> DOESNT WORK
where 10101b /==> 0 2 4 ==> basically if left operand not provided to where, it will assume it is list of integers starting from until (-1+count leftoperand)
where 0N /'type
where 1 /'type ==> needs list of atoms as input
where enlist 1 /0 ==> hence works
where enlist 1 2 /'type ==> needs list of atoms as input
where 0N 1 /'limit ==> atom cannot be null, must be integer
where (5 xprev til 10)
show i: {null x} d: (5 xprev til 10) /1111100000b
d /0N 0N 0N 0N 0N 0 1 2 3 4
i /1111100000b
show .[d;i; "a"]; /'type ==> because we are trying to amend a integer list with a character
show .[d;i; 5]; /'type ==> because '.' is for nested lists
show @[d;i;:;5]; /5 5 0N 0N 0N 0 1 2 3 4
@[5 xprev til 10;null 5 xprev til 10;:;99] /99 99 0N 0N 0N 0 1 2 3 4
@[5 xprev til 10;where null 5 xprev til 10;:;99] /99 99 99 99 99 0 1 2 3 4