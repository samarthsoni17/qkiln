/ adapted from https://learnxinyminutes.com/kdb+/
/ all important clauses are tagged with a "   *****   " so can search for just them

/ Single line comments start with a forward-slash
/ These can also be used in-line, so long as at least one whitespace character
/ separates it from text to the left
/
  A forward-slash on a line by itself starts a multiline comment
  and a backward-slash on a line by itself terminates it
\

/ Run this file in an empty directory


////////////////////////////////////
// Basic Operators and Datatypes  //
////////////////////////////////////

/ We have integers, which are 8 byte by default
3 / => 3

/ And floats, also 8 byte as standard. Trailing f distinguishes from int
3.0 / => 3f

/ 4 byte numerical types can also be specified with trailing chars
3i / => 3i
3.0e / => 3e

/ Math is mostly what you would expect
1+1 / => 2
8-1 / => 7
10*2 / => 20
/ Except division, which uses percent (%) instead of forward-slash (/)
35%5 / => 7f  (the result of division is always a float)

/ For integer division we have the keyword div
4 div 3 / => 1

/ Modulo also uses a keyword, since percent (%) is taken
/    *****    mod means remainder after dividing by the number on the right
4 mod 3 / => 1
height:180 175 160
12*(height*0.032) mod 1
(height*0.032) mod 1
(height*0.032) mod 5
(height*0.032) mod 4
5.74 mod 4 / => 1.74

/ And exponentiation...
2 xexp 4 / => 16

/ ...and truncating...
floor 3.14159 / => 3
(ceil:{floor[x] + 1}) 3.14159 /can make my own

/ ...getting the absolute value...
abs -3.14159 / => 3.14159
/ ...and many other things
/ see http://code.kx.com/q/ref/ for more

/ q has no operator precedence, everything is evaluated right to left
/ so results like this might take some getting used to
2*1+1 / => 4 / (no operator precedence tables to remember!)

/ Precedence can be modified with parentheses (restoring the 'normal' result)
(2*1)+1 / => 3

/ Assignment uses colon (:) instead of equals (=)
/ No need to declare variables before assignment
a:3
a / => 3

/ Variables can also be assigned in-line
/ this does not affect the value passed on
c:3+b:2+a:1 / (data "flows" from right to left)
a / => 1
b / => 3
c / => 6

/ In-place operations are also as you might expect
a+:2
a / => 3

/ There are no "true" or "false" keywords in q
/ boolean values are indicated by the bit value followed by b
1b / => true value
0b / => false value

/ Equality comparisons use equals (=) (since we don't need it for assignment)
1=1 / => 1b
2=1 / => 0b

/ Inequality uses <>
1<>1 / => 0b
2<>1 / => 1b

/ The other comparisons are as you might expect
1<2 / => 1b
1>2 / => 0b
2<=2 / => 1b
2>=2 / => 1b
0<=2-2

/ Comparison is not strict with regard to types...
42=42.0 / => 1b

/ ...unless we use the match operator (~)
/ *****
/ ***** which only returns true if entities are identical
42~42.0 / => 0b

/ The not operator returns true ***** if the underlying value is zero
not 0b / => 1b
not 1b / => 0b
not 42 / => 0b
not 0.0 / => 1b

/ The max operator (|) reduces to logical "or" for bools
42|2.0 / => 42f / *****
1b|0b / => 1b

/ The min operator (&) reduces to logical "and" for bools
42&2.0 / => 2f / *****
1b&0b / => 0b

/ q provides two ways to store character data
/ Chars in q are stored in a single byte and use double-quotes (")
ch:"a"
/ Strings are simply lists of char (more on lists later)
str:"This is a string"
/ Escape characters work as normal
str:"This is a string with \"quotes\""

/ Char data can also be stored as symbols using backtick (`)
symbol:`sym
/ Symbols are NOT LISTS, they are    *****   an enumeration
/ the q process stores internally a vector of strings
/ symbols are enumerated against this vector
/ this can be more space and speed efficient as these are constant width

/ The string function converts to strings
string `symbol / => "symbol"
string 1.2345 / => "1.2345"

/ q has a time type...
t:01:00:00.000
/ date type...
d:2015.12.25
/ and a datetime type (among other time types)
dt:2015.12.25D12:00:00.000000000

/ These support some arithmetic for easy manipulation
dt + t / => 2015.12.25D13:00:00.000000000
t - 00:10:00.000 / => 00:50:00.000
/ and can be decomposed using dot notation
d.year / => 2015i
d.mm / => 12i
d.dd / => 25i
/ see http://code.kx.com/q4m3/2_Basic_Data_Types_Atoms/#25-temporal-data for more

/ q also has an infinity value so div by zero will not throw an error
1%0 / => 0w
-1%0 / => -0w

/ And null types for representing missing values
0N / => null int
0n / => null float
/ see http://code.kx.com/q4m3/2_Basic_Data_Types_Atoms/#27-nulls for more

/ q has standard control structures
/ if is as you might expect (; separates the condition and instructions)
if[1=1;a:"hi"]
a / => "hi"
/ if-else uses $ (and unlike if, returns a value)
$[1=0;a:"hi";a:"bye"] / => "bye"
a / => "bye"
/ if-else can be extended to multiple clauses by adding args separated by ;
$[1=0;a:"hi";0=1;a:"bye";a:"hello again"]
a / => "hello again"

/vector‐conditional ?[x;y;z]
/used when you have vector (list) inputs:
/	•	x is a boolean vector,
/	•	y and z are vectors of the same type (or atoms broadcasted), and
/	•	it returns a new vector where for each position, if x[i] is true then y[i] else z[i]

////////////////////////////////////
////      Data Structures       ////
////////////////////////////////////

/ q is not an object oriented language
/ instead complexity is built through ordered lists
/ and mapping them into higher order structures: dictionaries and tables

/ Lists (or arrays if you prefer) are simple ordered collections
/ they are defined using parentheses () and semi-colons (;)
(1;2;3) / => 1 2 3
(-10.0;3.14159e;1b;`abc;"c")
/ => -10f
/ => 3.14159e
/ => 1b
/ => `abc
/ => "c"  (mixed type lists are displayed on multiple lines)
((1;2;3);(4;5;6);(7;8;9))
/ => 1 2 3
/ => 4 5 6
/ => 7 8 9

/ Lists of uniform type can also be defined more concisely
1 2 3 / => 1 2 3
`list`of`syms / => `list`of`syms
`list`of`syms ~ (`list;`of;`syms) / => 1b

/ List length
count (1;2;3) / => 3
count "I am a string" / => 13 (string are lists of char)

/ Empty lists are defined with parentheses
l:()
count l / => 0
type l
lsy:`symbol$()
type lsy /=> 11h
type `sym / => -11h

/ Simple variables and single item lists are not equivalent
/ parentheses syntax cannot create a single item list (they indicate precedence)
(1)~1 / => 1b
/ single item lists can be created using enlist
singleton:enlist 1
/ or appending to an empty list
singleton:(),1
1~(),1 / => 0b
/ CANNOT: using semicolon
(1;2;) /=> (1;2;@-1)

/ Speaking of    *****   appending, comma (,) is used for this, not plus (+)
1 2 3,4 5 6 / => 1 2 3 4 5 6
"hello ","there" / => "hello there"

/ Indexing uses square brackets []
l:1 2 3 4
l[0] / => 1
l[1] / => 2
/ indexing out of bounds returns a    *****   null value rather than an error
l[5] / => 0N
/ and indexed assignment
l[0]:5
l / => 5 2 3 4
l[4]:56 / => length error

/ Lists can also be used for indexing and    *****   indexed assignment
l[1 3] / => 2 4
l[1 3]: 1 3
l / => 5 1 3 3

/ Lists can be untyped/mixed type
l:(1;2;`hi)
/ but    *****   once they are uniformly typed, q will enforce this
l[2]:3
l / => 1 2 3
l[2]:`hi / throws a type error
/ this makes sense in the context of lists as table columns (more later)

/ For a nested list we can index at depth
l:((1;2;3);(4;5;6);(7;8;9))
l[1;1] / => 5

/ We can    *****   elide the indexes to return entire rows or columns
l[;1] / => 2 5 8
l[1;] / => 4 5 6

/ All the functions mentioned in the previous section work on lists natively
1+(1;2;3) / => 2 3 4 (single variable and list)
(1;2;3) - (3;2;1) / => -2 0 2 (list and list)

/ And there are many more that are designed specifically for lists
avg 1 2 3 / => 2f
sum 1 2 3 / => 6
sums 1 2 3 / => 1 3 6 (running sum)
last 1 2 3 / => 3
1 rotate 1 2 3 / => 2 3 1
/    *****    rotate brings elements X times to the left
2 rotate 1 350 5 42 / => 5 42 1 350
/ etc.
/ Using and combining these functions to manipulate lists is where much of the power and expressiveness of the language comes from

/    *****   Take (#), drop (_) and find (?) are also useful working with lists
l:1 2 3 4 5 6 7 8 9
l:1+til 9 / til is a useful shortcut for generating ranges
/ take the first 5 elements
5#l / => 1 2 3 4 5
/ drop the first 5
5_l / => 6 7 8 9
/ take the last 5
-5#l / => 5 6 7 8 9
/ drop the last 5
-5_l / => 1 2 3 4
/ find the first occurrence of 4   *****   NOTICE that the left operator is found in the right list not vice versa
l?4 / => 3
l[3] / => 4
l[l?4] / redundant, => 4
/   *****   can specify all indexes to extract from list
l[2 5 2 2 3] / => 3 6 3 3 4
/ some more examples
l3:6#.Q.a /"abcdef"
l3,:l3
3?l3 /taking out randomly 3 elements
"b"?l3 /taking out randomly 98 elements
(enlist "b")?l3 /finding l3 in b
/   *****   when supplied two lists, '?' finds the second list element by element in the first (i.e. it is atomic in the left operator)
l3 /"abcdefabcdef"
"abd"?l3 /    *****   missing elements go to nth index where n=count ==> 0 1 3 2 3 3 0 1 3 2 3 3
"abg"?l3 / 0 1 3 3 3 3 0 1 3 3 3 3
"dcf"?l3 / 3 3 1 0 3 2 3 3 1 0 3 2
"dcf"?"ab" / 3 3
"dcf"?"a" / 3
"ag"?l3 / 0 2 2 2 2 2 0 2 2 2 2 2
"abcdef"?l3 / 0 1 2 3 4 5 0 1 2 3 4 5
"abcde"?l3 / here the '5' is due to nth index not due to f's position ==> 0 1 2 3 4 5 0 1 2 3 4 5
"abcd"?l3 / 0 1 2 3 4 4 0 1 2 3 4 4
"abc"?l3 / 0 1 2 3 3 3 0 1 2 3 3 3
"ab"?l3 / 0 1 2 2 2 2 0 1 2 2 2 2

/group on lists:
l2:(count l)#.Q.a
l2 /"abcdef"
l group l2
/    a| ,"a"
/    b| ,"b"
/    c| ,"c"
/    d| ,"d"
/    e| ,"e"
/    f| ,"f"
l2,:raze 3#enlist l2 /l2 ==> "abcdefabcdefabcdefabcdef"
l group l2
/    a| "a   "
/    b| "b   "
/    c| "c   "
/    d| "d   "
/    e| "e   "
/    f| "f   "
group l
/    "a"	enlist 0
/    "b"	enlist 1
/    "c"	enlist 2
/    "d"	enlist 3
/    "e"	enlist 4
/    "f"	enlist 5
group l2
/    a| 0 6  12 18
/    b| 1 7  13 19
/    c| 2 8  14 20
/    d| 3 9  15 21
/    e| 4 10 16 22
/    f| 5 11 17 23
l3:(count l)#(floor 0.5*count l)#.Q.a /l3 ==> "abcabc"
group l3
/    a| 0 3
/    b| 1 4
/    c| 2 5
l group l3 /   *****     important ==> "abcdef" group "abcabc" ==> the resulting dict of (group l3) is used to index l
/    a| "ad"
/    b| "be"
/    c| "cf"
l3 group l3
/    a| "aa"
/    b| "bb"
/    c| "cc"

/ Dictionaries in q are a    *****   generalization of lists
/ they map a list to another list (of equal length)
/ the bang (!) symbol is used for defining a dictionary
d:(`a;`b;`c)!(1;2;3)
/ or more simply with concise list syntax
d:`a`b`c!1 2 3
/ the keyword key returns the first list
key d / => `a`b`c
/ and value the second
value d / => 1 2 3

/ Indexing is identical to lists
/ with the first list as a key instead of the position
d[`a] / => 1
d[`b] / => 2

/    *****   As is assignment
d[`c]:4
d
/ => a| 1
/ => b| 2
/ => c| 4

/ Arithmetic and comparison work natively, just like lists
e:(`a;`b;`c)!(2;3;4)
d+e
/ => a| 3
/ => b| 5
/ => c| 8
d-2
/ => a| -1
/ => b| 0
/ => c| 2
d > (1;1;1)
/ => a| 0b
/ => b| 1b
/ => c| 1b

/ And the    *****    take, drop and find operators are remarkably similar too
`a`b#d
/ => a| 1
/ => b| 2
`a`b _ d
/ => c| 4
d?2
/ => `b

/ Tables in q are basically a    *****   subset of dictionaries
/ a table is a dictionary where all values must be lists of the same length
/ as such tables in q are column oriented (unlike most RDBMS)
/ the flip keyword is used to convert a dictionary to a table
/ i.e. flip the indices
dicnew:`c1`c2`c3!(1 2 3;4 5 6;7 8 9)
flip `c1`c2`c3!(1 2 3;4 5 6;7 8 9)
/ => c1 c2 c3
/ => --------
/ => 1  4  7
/ => 2  5  8
/ => 3  6  9
/ we can also define tables using this syntax
t:([]c1:1 2 3;c2:4 5 6;c3:7 8 9)
t
/ => c1 c2 c3
/ => --------
/ => 1  4  7
/ => 2  5  8
/ => 3  6  9
/ a single row table cannot be defined directly:
t2:([]c1:1;c2:4;c3:7) / => rank error
dic2:`c1`c2`c3!(1;4;7)
flip dic2 /still rank error
/   *****   but we use enlist on each column to get a single row table
dic2:`c1`c2`c3!(enlist 1;enlist 4;enlist 7)
flip dic2 /WORKS !!
([]c1:enlist 1;c2:enlist 4;c3:enlist 7) /WORKS !!

/ Tables can be indexed and manipulated in a similar way to dicts and lists
t[`c1]
/ => 1 2 3
/    *****   table rows are returned as dictionaries
t[1]
/ => c1| 2
/ => c2| 5
/ => c3| 8

/ meta returns table type information
meta t
/ => c | t f a
/ => --| -----
/ => c1| j
/ => c2| j
/ => c3| j
/ now we see why type is enforced in lists (to protect column types)
t[1;`c1]:3 /tables are indexed row;col
t[1;`emptycol] /0N; missing value = 0N = null
t[`c1;1] /nope
dicnew[`c1;1] /dictoinaries are indexed col;row
dicnew[1;`c1] /nope
dicnew[`emptykey;1] /0N
dicnew[`emptykey] /`long$()
t[1;`c1]:3.0 /    *****   throws a type error

/ Most traditional databases have primary key columns
/ in q we have    *****   keyed tables, where one table containing key columns is    *****   mapped to another table using bang (!)
k:([]id:1 2 3)
k!t
/ => id| c1 c2 c3
/ => --| --------
/ => 1 | 1  4  7
/ => 2 | 3  5  8
/ => 3 | 3  6  9
k2:([]id:1 2 3;created:2025 2024 2023h)
k2!t
/    id created| c1 c2 c3
/    ----------| --------
/    1  2025   | 1  4  7
/    2  2024   | 3  5  8
/    3  2023   | 3  6  9
t[0]

/ We can also use this    *****   shortcut for defining keyed tables
kt:([id:1 2 3]c1:1 2 3;c2:4 5 6;c3:7 8 9)
kt2:([id:1 2 3;created:2025 2024 2023h]c1:1 2 3;c2:4 5 6;c3:7 8 9)

/    *****   THIRD way to make a keyed table out of a regular one
kt:`c1 xkey ([]c1:1 2 3;c2:4 5 6;c3:7 8 9)

/ Records can then be retrieved based on this key
kt[1]
/ => c1| 1
/ => c2| 4
/ => c3| 7
t[0] / basically same result with default indexing
/`c1	1
/`c2	4
/`c3	7
kt[`id!1] /   *****   better way since we know which keyed col (id) and its value
/ => c1| 1
/ => c2| 4
/ => c3| 7
first dicnew


////////////////////////////////////
////////     Functions      ////////
////////////////////////////////////

/ In q the function is similar to a    *****   mathematical map, mapping inputs to outputs
/ curly braces {} are used for function definition
/ and square brackets [] for calling functions (just like list indexing)
/ a very minimal function
f:{x+x}
f[2] / => 4

/ Functions can be    *****   anonymous and called at point of definition
{x+x}[2] / => 4

/ By default the last expression is returned
/ colon (:) can be used to specify return
{x+x}[2] / => 4
{:x+x}[2] / => 4
/ semi-colon (;) separates expressions
{r:x+x;:r}[2] / => 4
{r:x+x;r}[2] / => 4 /   *****   colon in last expr is optional for returning
{r:x+x;r;}[2] / => not return
{r:x+x;:r;}[2] / =>    *****   return with colon+semicolon

/ Function arguments can be specified explicitly (separated by ;)
{[arg1;arg2] arg1+arg2}[1;2] / => 3
/ or if omitted will default to x, y and z
{x+y+z}[1;2;3] / => 6

/ Built in functions are no different, and
/   *****    built in functions can be called the same way (with [])
+[1;2] / => 3
<[1;2] / => 1b

/ Functions are first class in q, so can be returned, stored in lists etc. just like a float or long value
/   *****   q4m3 defines: a functions is a first class value which means it acquires a name only once it is assigned to a variable
{:{x+y}}[] / => {x+y}
(1;"hi";{x+y}) /can be stored in lists...
/ => 1
/ => "hi"
/ => {x+y}

/ There is    *****   no overloading and no keyword arguments for custom q functions
/ however     *****   using a dictionary as a single argument can overcome this
/ allows for    *****   optional arguments or differing functionality
d:`arg1`arg2`arg3!(1.0;2;"my function argument")
{x[`arg1]+x[`arg2]}[d] / => 3f

/ Functions in q    *****   see the global scope
a:1
{:a}[] / => 1

/ However local scope obscures this
a:1
{a:2;:a}[] / => 2
a / => 1

/ Functions    *****   cannot see nested scopes (only local and global)
{local:1;{:local}[]}[] / throws error as local is not defined in inner function

/ A function can have one or more of its arguments fixed (projection)
/   *****   fixing some arguments of a function
addto4:+[4]
addto4[4] / => 8
addto4[5] / => 9
addto4[6] / => 10
fnew:{x+y-z}
fnew:fnew[;100;] /fixing middle argument
fnew[1;2]
fnew[1;250]


////////////////////////////////////
//////////     q-sql      //////////
////////////////////////////////////

/ q has its own syntax for manipulating tables, similar to standard SQL
/ This contains the usual suspects of select, insert, update etc.
/ and some new functionality not typically available
/ q-sql has two significant differences (other than syntax) to normal SQL:
/ - q tables have    *****   well defined record orders
/ - tables are    *****   stored as a collection of columns  (so vectorized column operations are fast)
/ a full description of q-sql is a little beyond the scope of this intro
/ so we will just cover enough of the basics to get you going

/ First define ourselves a table
t:([]name:`Arthur`Thomas`Polly;age:35 32 52;height:180 175 160;sex:`m`m`f)

/ equivalent of SELECT * FROM t
select from t / (must be lower case, and the wildcard is not necessary)
/ => name   age height sex
/ => ---------------------
/ => Arthur 35  180    m
/ => Thomas 32  175    m
/ => Polly  52  160    f

/ Select specific columns
select name,age from t
/ => name   age
/ => ----------
/ => Arthur 35
/ => Thomas 32
/ => Polly  52

/ And name them (equivalent of using AS in standard SQL)
select charactername:name, currentage:age from t
/ => charactername currentage
/ => ------------------------
/ => Arthur        35
/ => Thomas        32
/ => Polly         52

/ This SQL syntax is integrated with the q language
/ so q can be used seamlessly in SQL statements
height:180 175 160
12*(height*0.032) mod 1
(height*0.032) mod 1
(height*0.032) mod 5
(height*0.032) mod 4

select name, feet:floor height*0.032, inches:12*(height*0.032) mod 1 from t
/ => name   feet inches
/ => ------------------
/ => Arthur 5    9.12
/ => Thomas 5    7.2
/ => Polly  5    1.44

/ Including    *****   custom functions -- do see this example, how multiple columns can be transformed into a 3rd in-line
select name, growth:{[h;a]h%a}[height;age] from t
/ => name   growth
/ => ---------------
/ => Arthur 5.142857
/ => Thomas 5.46875
/ => Polly  3.076923

/ The where clause can contain multiple statements separated by commas
select from t where age>33,height>175
/ => name   age height sex
/ => ---------------------
/ => Arthur 35  180    m

/ The where statements are    *****   executed sequentially (not the same as logical AND) -- i remember i struggled with this once
/    *****   for efficient where query, first statement should be most reducing for optimal data retrieval
/Query optimization: Always filter by partition column first in where clause for best performance
select from t where age<40,height=min height
/ => name   age height sex
/ => ---------------------
/ => Thomas 32  175    m
select from t where (age<40)&(height=min height) /-- here it's just that the minimum height `Polly is >40 age
/ => name age height sex
/ => -------------------

/ The by clause falls between select and from
/ and is equivalent to SQL's GROUP BY
select avg height by sex from t
/ => sex| height
/ => ---| ------
/ => f  | 160
/ => m  | 177.5

/ If    *****   no aggregation function is specified, last is assumed
select by sex from t
/ => sex| name   age height
/ => ---| -----------------
/ => f  | Polly  52  160
/ => m  | Thomas 32  175

/ Update has the same basic form as select
update sex:`male from t where sex=`m
/ => name   age height sex
/ => ----------------------
/ => Arthur 35  180    male
/ => Thomas 32  175    male
/ => Polly  52  160    f

/ As does delete
delete from t where sex=`m
/ => name  age height sex
/ => --------------------
/ => Polly 52  160    f

/ None of these sql operations are carried out in place
t
/ => name   age height sex
/ => ---------------------
/ => Arthur 35  180    m
/ => Thomas 32  175    m
/ => Polly  52  160    f

/    *****   Insert however is in place, it takes a table name, and new data
/   *****   returns row numbers of appended records
`t insert (`John;25;178;`m) / => ,3
t insert (`John;25;178;`m) /error
t upsert (`John;25;178;`m) /this works
t
/ => name   age height sex
/ => ---------------------
/ => Arthur 35  180    m
/ => Thomas 32  175    m
/ => Polly  52  160    f
/ => John   25  178    m

/ Upsert is similar (but doesn't have to be in-place)
t upsert (`Chester;58;179;`m)
/ => name    age height sex
/ => ----------------------
/ => Arthur  35  180    m
/ => Thomas  32  175    m
/ => Polly   52  160    f
/ => John    25  178    m
/ => Chester 58  179    m

/ CAN BE in place:
`t upsert (`Chester;58;179;`m)

/ it will also upsert dicts or tables
t upsert `name`age`height`sex!(`Chester;58;179;`m)
/ => name    age height sex
/ => ----------------------
/ => Arthur  35  180    m
/ => Thomas  32  175    m
/ => Polly   52  160    f
/ => John    25  178    m
/ => Chester 58  179    m
`t upsert ([] name:`Chester`Maximillian;age:58 25;height:179 183;sex:`m`f)
/    name        age height sex
/    --------------------------
/    Arthur      35  180    m
/    Thomas      32  175    m
/    Polly       52  160    f
/    Chester     58  179    m
/    Chester     58  179    m
/    Maximillian 25  183    f

/ lets look at fby
/   *****   fby = "filter by" - applies an aggregate function grouped by a column, returning a result for each row (not collapsed like select ... by).
/Syntax: (aggFunc;col) fby groupCol
/Returns vector same length as table (not aggregated)
/Use in where clause (filtering) vs update/select (adding columns)
/Works with any aggregate: sum, avg, max, min, count, first, last, {user function x} etc
/Advanced patterns to consider: multiple group columns (f;c) fby (g1;g2), chaining fby, and performance considerations
select name, age, height, mxht:max height by sex from t /other columns arent helping us i.e. you lose the information of row-wise arrangement of other columns
select from t where height=(max;height) fby sex /but now you have only one max height per sex
/lets say we want all colleagues whose height is within 2 of max height in each sex
select from t where height>=-2+(max;height) fby sex
/lets say we want only those sex where height>180
select from t where 180<(max;height) fby sex
select from t where height=(max;height) fby sex,age<30 /dont confuse:age is a SEPARATE where query
select from t where height=(max;height) fby ([] sex;age)
select from t where height=(max;height) fby ([] sex;age div 10) /can include complexity in fby sub parts as well ==> here we made differing age only count if they are in buckets of 10
t
/give me all colleagues whose shoesize has maximum 2 ages. So only return those shoesizes  where the number of ages are 2 (like if shoesize 7 has ages 22, 21, 28 -- dont return it, only return if shoesize 8 has 23 and 28 etc)
/lets convert this to 2 members per gender rather than per shoesize given our current table
/so here we are grouping by sex (we dont care which colleagues have them so that column doesnt go in ) and we want to aggregate by (number of distinct ages)<=2
select from t where 2>=(count;age) fby sex
select from t where 2 >= ({count distinct x}; age) fby sex /FINAL ANSWER --    *****   how to apply double aggregator functions is illustrated in this

/ And if our table is keyed
kt:`name xkey t

/ upsert will    *****   replace records where required for a keyed table
kt upsert ([]name:`Thomas`Chester;age:33 58;height:175 179;sex:`f`m)
/ => name   | age height sex
/ => -------| --------------
/ => Arthur | 35  180    m
/ => Thomas | 33  175    f
/ => Polly  | 52  160    f
/ => John   | 25  178    m
/ => Chester| 58  179    m

/ There is no ORDER BY clause in q-sql, instead use    *****   xasc/xdesc
`name xasc t
/ => name   age height sex
/ => ---------------------
/ => Arthur 35  180    m
/ => John   25  178    m
/ => Polly  52  160    f
/ => Thomas 32  175    m

/   *****   functional sql -- provide table and the filtering condition(s) as arguments to the special functional select operator "?"
/ useful for dynamic queries at runtime; metaprogramming to generate queries programmatically; complex logic to build queries conditionally

?[ table; whereConditions; groupBy; selectedColumns ] / `whereConditions` is constraints supplied in a list format, each like (<; column; value) or (=; column; value) , enabling programmatic/dynamic construction of queries - (empty list () for none)
/grouping (groupBy) argument is (0b for no grouping) or a dictionary groupColName!sourceCol if you need grouping
/selectedColumns is the dictionary of output columns mapping column names to either themselves or expressions
/fby structure: (fby;(enlist;aggFunc;col);groupCol)
/ for user-defined functions with 2+ inputs, the parse tree structure is simply: (function; arg1; arg2; arg3; ...)
?[t;enlist (<; `age; 30); 0b; ()]
?[t;enlist (<; `age; 30); 0b; (`name1`age1!`name`age)]
q)?[t; enlist((=; `sym; `AAPL), (>; `price; 100)); (enlist `sym)!enlist `sym; ((enlist `minP)!enlist (min; `price))] /e.g. of multiple conditions
/more examples:
?[t; (); 0b; ()] /select from t ==> ALL
?[t; (); 0b; `sym`price!`sym`price] /select sym, price from t ==> SOME COLS
?[t; (); 0b; `ticker`px!`sym`price] /select ticker:sym, px:price from t ==> RENAME SOME COLS
?[t; enlist (>;`price;200); 0b; ()] /select from t where price > 200 ==> SINGLE WHERE
/   *****   Key insight: Where clause is a list of parse trees. Each condition is (function;arg1;arg2). Use enlist for single condition (otherwise q thinks it's multiple conditions).
?[t; ((>;`price;100);(>=;`size;100)); 0b; ()] /select from t where price > 100, size >= 100 ==> MULTIPLE WHERE
?[t; (); 0b; (enlist `size)!(enlist (sum;`size))] /select sum size from t ==> AGGREGATIONS
?[t; (); (enlist `sym)!(enlist `sym); (enlist `size)!(enlist (sum;`size))]  /select sum size by sym from t ==> GROUP BY
?[t; (); 0b; `sym`notional!(`sym;(*;`price;`size))] /select sym, notional:price*size from t ==> COMPUTED COLUMN
?[t; enlist (>;`price;(fby;(enlist;avg;`price);`sym)); 0b; ()] /select from t where price > (avg;price) fby sym ==> COMPLEX WHERE WITH FBY
?[t; (); 0b; (enlist`result)!enlist({[a;b;c;d] (a*b)+(c%d)};`price;`size;`bid;`ask)] /select result:{[a;b;c;d] (a*b) + (c%d)}[price;size;bid;ask] from t ==> user defined in-line lambda function with 2+ inputs
/   *****   for debugging, use parse to get the functional form of any q-sql query
parse "select sym,price from t where size>100"
/ dynamic column selection
getCols:{[t;c] ?[t;();0b;c!c]}
getCols[t;`sym`price]
/ nested parse tree examples - Every function application becomes (func;arg1;arg2;...), and these nest arbitrarily deep (can use parse to help)
/ conditional expression i.e. (?;condition;trueExpr;falseExpr) where each branch has its own nested operations.
?[t; (); 0b; `sym`adjPrice!(`sym;(?;(>;`price;100);(*;`price;1.1);(*;`price;0.9)))] /select sym, adjPrice:?[price>100;price*1.1;price*0.9] from t
/ Nested function calls -- Three levels: sqrt → sum → *
?[t; (); 0b; `sym`metric!(`sym;(sqrt;(sum;(*;`price;`price))))] /select sym, metric:sqrt sum price*price from t
/ String operations
?[t; (); 0b; (enlist`sym)!enlist(upper;(first;(string;`sym)))] /select upper first string sym from t
/ Complex fby in where
?[t; enlist (>;`price;(*;1.5;(fby;(enlist;avg;`price);`sym))); 0b; ()] /select from t where price > 1.5 * (avg;price) fby sym
/ Multiple nested enlists (typical in complex aggregations). Here we see enlist appearing multiple times:
/ (enlist `sym) for the group-by key |  enlist `sym for the group-by value
/ (enlist `sumSq) for the select key | enlist(sum;...) for the select value
?[t; (); (enlist`sym)!enlist`sym; (enlist`sumSq)!enlist(sum;(*;`price;`price))] /select sumSq:sum price*price by sym from t
/ Where clause with nested logic
?[t; enlist (&;(>;`price;100);(within;`size;50 200)); 0b; ()] /select from t where (price>100) & size within 50 200
/ user defined functions with multiple inputs; position depends on context:
?[t; enlist (myFunc;`price;`size;`bid;`ask); 0b; ()] /In where clause
?[t; (); 0b; (enlist`result)!enlist(sqrt;(myFunc;`price;`size;`bid;`ask))] / In select with nesting
?[t; (); (enlist`sym)!enlist`sym; (enlist`result)!enlist(myFunc;`price;`size;`bid;`ask)] /In group-by aggregation
/   *****   watch out for: if your function returns a vector and you're using it row-wise, you might need each or ':
(myFunc';`price;`size;`bid;`ask)   / apply each row
(';myFunc;`price;`size;`bid;`ask) /in parse tree form


/say we have the query:
update avbsz:avg bsize from select from fbyt where bsize>(avg;bsize) fby sym
?[fbyt; enlist (>;`bsize;(fby;(enlist;avg;`bsize);`sym)); 0b; (cols[fbyt]!cols[fbyt]),(enlist `avbsz)!enlist(avg; `bsize)] /its functional form -- takes lesser time!


/ Most of the standard SQL joins are present in q-sql, plus a few new friends
/ see http://code.kx.com/q4m3/9_Queries_q-sql/#99-joins
/ the two most important (commonly used) are lj and aj

/ lj is basically the same as SQL LEFT JOIN
/ where the    *****   left join is carried out on the key columns of the left table
le:([sex:`m`f]lifeexpectancy:78 85)
t lj le
/ => name   age height sex lifeexpectancy
/ => ------------------------------------
/ => Arthur 35  180    m   78
/ => Thomas 32  175    m   78
/ => Polly  52  160    f   85
/ => John   25  178    m   78

/ aj is an asof join. This is not a standard SQL join, and can be very powerful
/ The canonical example of this is joining financial trades and quotes tables
trades:([]time:10:01:01 10:01:03 10:01:04;sym:`msft`ibm`ge;qty:100 200 150)
quotes:([]time:10:01:00 10:01:01 10:01:01 10:01:03;
          sym:`ibm`msft`msft`ibm; px:100 99 101 98)
aj[`time`sym;trades;quotes]
/ => time     sym  qty px
/ => ---------------------
/ => 10:01:01 msft 100 101
/ => 10:01:03 ibm  200 98
/ => 10:01:04 ge   150
/ for row in the trade table, the last (prevailing) quote (px) for that sym is joined on.
/ see http://code.kx.com/q4m3/9_Queries_q-sql/#998-as-of-joins
aj[`time;trades;quotes]
/    time     sym  qty px
/    ---------------------
/    10:01:01 msft 100 101
/    10:01:03 ibm  200 98
/    10:01:04 ibm  150 98

aj[`sym`time;.sam.trade;.sam.quote]~aj[`sym`time;.sam.trade;`time xasc .sam.quote] /1b ==> i.e. doesnt matter if you do asof join with sorted lists or not....


////////////////////////////////////
/////     Extra/Advanced      //////
////////////////////////////////////

////// Adverbs //////
/ You may have noticed the total lack of loops to this point
/ This is not a mistake!
/ q is a vector language so   *****   explicit loops (for, while etc.) are not encouraged
/ where possible functionality should be vectorized (i.e. operations on lists)
/ adverbs supplement this vector operations on lists
/ they modify the behaviour of functions and provide loop type functionality when required
/ (in q functions are sometimes referred to as verbs, hence adverbs)
/ the    *****   "each" adverb modifies a function to treat a list as individual variables
first each (1 2 3;4 5 6;7 8 9)
/ => 1 4 7

/ each-left (\:) and each-right (/:)    *****   modify a two-argument function
/ to treat one of the arguments as individual variables (atoms) instead of a list
1 2 3 +\: 11 22 33
/ => 12 23 34
/ => 13 24 35
/ => 14 25 36
1 2 3 +/: 11 22 33
/ => 12 13 14
/ => 23 24 25
/ => 34 35 36

/ The     *****   true alternatives to loops in q are the adverbs scan (\) and over (/)
Mnemonic: "\\ Backslash means scan your path or scan special characters using escape sequence———leave footprints behind while walking up a steep hill."
Mnemonic: "\\ Backslash looks like a samurai about to thrust their katana forward———a continuous arc where each differential movement in the air counts."
Mnemonic: "\\ Backslash is Obstuse, open, ALL results."
Mnemonic: "/ Slash is Acute, sharp, ONE result."
Mnemonic: "/ Slash means sweep over the entire list like a broom/a code-comment———just show the last thing swept or the final conclusion of the action."
Mnemonic: "/ Slash looks like a fishing rod———a discrete process. Only the cumulative result of the momement matters, not what happened along the way."
WindshieldWiperMnemonic: "\/The windshield wiper on a car swings anticlock then clockwise. Anticlock/left-to-right we see EVERY STREAK it leaves, the whole trail. Clock/right-to-left is the final pass & we see it cut just once-a final wipe"
/ their     *****   behaviour differs based on the number of arguments the function they are modifying receives.
/Here I'll summarise some of the most useful cases...

/ MONADIC-1: a single argument function modified by scan given TWO args    *****   behaves like "do" -- "do for N times"
{x * 2}\[5;1] / => 1 2 4 8 16 32 (i.e. multiply by 2, 5 times)
{x * 2}/[5;1] / => 32 (using over only the final result is shown)
/   *****   can also be written as:
5 {x * 2}\ 1
5 {x * 2}/ 1
10 {x,sum -2#x}/ 1 1 2  /fibonacci
{x,sum -2#x}/[10;1 1]  /fibonacci -- another way of writing
{x,sum -2#x}\[10;1 1]  /fibonacci -- scan instead of over



/ MONADIC-2: If the first argument is a FUNCTION, we have the   *****    equivalent of "while"
{x * 2}\[{x<100};1] / => 1 2 4 8 16 32 64 128 (iterates until returns 0b)
{x * 2}/[{x<100};1] / => 128 (again returns only the final result)
/   *****   can also be written as:
{x<100} {x*2}/ 1
{x*2}/ 1 /just this raw doesnt work



/ MONADIC-3: a single argument function modified by scan given ONE arg    *****   behaves like "do until result doesnt change any longer"
/ q4m3 defines: "Wouldn't it be nice of q had a higher-order function to apply a function recursively, starting at the base case, until the output
/Just specify the base case without second argument and q iterates until the result converges within the system comparison tolerance (as of this writing – Sep 2015 – that tolerance is 10^-14)"
{[xn] xn-((xn*xn)-2)%2*xn}/ [1] /approximate functoinally, the square of 2, using input as first approximation
{[xn] xn-((xn*xn)-2)%2*xn}/ [(1;5;2)] /3 approximations, one for each input
{[xn] xn-((xn*xn)-2)%2*xn}/ [1;5] /1 approximations, using 5 for input
{[xn] xn-((xn*xn)-2)%2*xn}/ [1;5;2] /rank error, max 2 arguments possible for the DYADIC q-structures {...}/ & {...}\

{x * 2}\[1] / => KEEP DOING WITHOUT ANY STOP
{x * 2}/[1] / => KEEP DOING WITHOUT ANY STOP
{x % 2}/[1] / => will keep dividing by 2 until reaches 1e-14
\P 0



/ DYADIC: to modify a DOUBLE argument function so it will iterate through the list, taking output of last step as input of current step
/ If the function takes two arguments, and we pass a list,   *****    we have "for"
/ where the result of the previous execution is passed back into the next loop
/ along with the next member of the list
{x + y}\[1 2 3 4 5] / => 1 3 6 10 15 (i.e. the running sum)
{x + y}/[1 2 3 4 5] / => 15 (only the final result)
(+/) [1 2 3 4 5]
({x + y}/) 1 2 3 4 5 / =>    *****    another syntax which is clearer
/   *****   can also be written as:
+\ [til 15]
+\ til 15 /doesnt work
(+\) til 15 /DOES work
{x-y}/ [1+til 100]

/ some more higher order functions
/each ' -- {x'y} ==> each-both
/prior \: -- {x':y} ==> each-left
/peach /: -- {x':y} ==> each-right
3 5 #\: "+" /each left
    "+++"
    "+++++"
2 3 5 #\: "+-" /each left also
    "+-"
    "+-+"
    "+-+-+"
5 #/: "+-" /each right
    "+++++"
    "-----"
3 5 #/: "+-" /each right also
    ("+++++";"+++++";"+++++")
    ("-----";"-----";"-----")
3 5 #' "+-" /each both (NOTE cant have length mismatch)
    "+++"
    "-----"
/ BUT each both acts like each left OR each rright if one of the sides is atomic
3 5 #' "+" /each both as each left
    "+++"
    "+++++"
5 #' "+-" /each both as each right
    "+++++"
    "-----"

/ There are other iterators and uses, this is only intended as quick overview
/ http://code.kx.com/q4m3/6_Functions/#67-iterators

// ENUMERATING LISTS
vlist:`apple`orange`apple`mango`apple`orange`orange`mango
ulist:distinct vlist
klist:ulist?vlist /find left operator in the right operator
ulist[klist]~vlist /1b
/if now you were to change an element in ulist, the entire resultant ulist[klist] will get changed without having to do them for all ements in klist
`ulist$vlist /   *****   this enumerates the vlist as per ulist ==> `ulist$`apple`orange`apple`mango`apple`orange`orange`mango
type elist:`ulist$vlist /20h ==> shows that it is an enumeration
-3!elist / "`ulist$`apple`orange`apple`mango`apple`orange`orange`mango"
elist,:`diamonds /'cast error -- we cannot add an illegal type
elist[0]:`diamonds /'cast error -- we cannot overwrite with an illegal type
elist,:`mango /success
elist[0]:`orange /success
ulist,:`diamonds
elist,:`diamonds /   *****   NOW THIS WORKS
-3!last elist /"`ulist$`diamonds"
/Foreign keys:   *****   The ability to restrict the values of a list or column to a domain can be easily extended to restrict one column to link to another table and this is how kdb implements foreign keys

////// Scripts //////
/ q scripts can be loaded from a q session using the "\l" command
/ for example "\l learnkdb.q" will load this script
/ or from the command prompt passing the script as an argument
/ for example "q learnkdb.q"

////// On-disk data //////
/ Tables can be persisted to disk in several formats
/ the two most fundamental are serialized and splayed
t2:([]a:1 2 3;b:1 2 3f)
system "ls"
/    "life.txt"
/    "mocktrades"
/    "mocktrades.csv"
//   *****   alternative to system command is directly using \
\ls
/    "2025.10.29"
/    "2025.10.30"
/    "2025.10.31"
/    "sym"
system "pwd"
/    "/Users/SamarthSoni/Projects/KDB/qkiln/hdb"
`:serialized set t / saves the table as a single serialized file
t
/    name    age height sex
/    ----------------------
/    Arthur  35  180    m
/    Thomas  32  175    m
/    Polly   52  160    f
/    Chester 58  179    m
`:splayed/ set t /    *****   saves the table splayed into a directory
`:splayed/ set t2 /    *****   saves the table splayed into a directory

/ the dir structure will now look something like:
/ db/
/ ├── serialized
/ └── splayed
/     ├── a
/     └── b

/ Loading this directory (as if it was as script, see above)
/ loads these tables into the q session
\l .
/ the serialized table will be loaded into memory
/ however the splayed table will only be mapped, not loaded
/ both tables can be queried using q-sql
select from serialized
/ => a b
/ => ---
/ => 1 1
/ => 2 2
/ => 3 3
select from splayed / (the columns are read from disk on request)
/ => a b
/ => ---
/ => 1 1
/ => 2 2
/ => 3 3
/ see http://code.kx.com/q4m3/14_Introduction_to_Kdb+/ for more
select from mocktrades
/    dt         tm                   sym  vol  px
/    ------------------------------------------------------------
/    2025.10.01 0D00:00:00.185997784 aapl 3390 243.22500000000002
/    2025.10.01 0D00:00:01.338998973 aapl 3640 248.94999999999999
/    2025.10.01 0D00:00:02.205922454 goog 7050 274.77499999999998
/    2025.10.01 0D00:00:11.895731091 goog 7470 238
/    2025.10.01 0D00:00:12.410956621 ibm  4470 272.10699999999997
/    2025.10.01 0D00:00:14.310885965 ibm  2890 285.99799999999999
/    2025.10.01 0D00:00:16.672792285 goog 1780 268.02500000000003
/    2025.10.01 0D00:00:38.512766361 aapl 7230 273.5
/    2025.10.01 0D00:00:42.920024693 goog 1400 251.90000000000001
/    2025.10.01 0D00:00:44.318226724 ibm  2670 281.00999999999999
/    2025.10.01 0D00:00:49.763077497 aapl 4040 250.97499999999999
/    2025.10.01 0D00:00:51.145286858 aapl 6230 246.27500000000001
/    2025.10.01 0D00:00:57.412221282 aapl 2640 248
/    2025.10.01 0D00:00:59.248863905 goog 1520 251.42499999999998
/    2025.10.01 0D00:01:03.052826374 ibm  6630 283.82299999999998
/    2025.10.01 0D00:01:03.363989442 aapl 2660 249.67500000000001
/    2025.10.01 0D00:01:04.478668570 ibm  5020 298.46800000000002
/    2025.10.01 0D00:01:06.496018320 goog 7720 226.82500000000002
/    2025.10.01 0D00:01:07.404784262 aapl 7390 262.875
/    2025.10.01 0D00:01:08.073479086 aapl 3490 261.70000000000005
/    ..

// LISTING ALL JOINS
/1. Left Join (lj)
t1 lj t2   / match t1 rows to keyed t2
/2. Inner Join (ij)
t1 ij t2   / only rows that match in both
/3. Plus Join (pj)
t1 pj t2   / like lj but adds numeric values instead of replacing
/4. Union Join (uj)
t1 uj t2   / all rows from both, fills nulls for missing columns
/5. Equi-join (ej)
ej[`sym;t1;t2]   / join on specified column(s), doesn't require keyed table
/6. As-of Join (aj) - critical for time series
aj[`sym`time;trades;quotes]   / match most recent quote for each trade
/7. Window Join (wj)
wj[windows;`sym`time;trades;(quotes;(avg;`bid))]   / aggregate within time windows
/8. Cross Join (,\\: or cross)
t1 cross t2   / cartesian product

/ JOINING LISTS
L1
L2
L1,'L2 /horizontal join
L1,L2 /vertical join
`$string[L1],'"-",'string[L2] /join cols as strings



// WINDOW JOIN AND LOADING AN HDB

\ls
dir:{x .Q.dd'key x}
dir `:architecture/sym
/wrong ways to load:
\l `:architecture/sym
get `:architecture/sym
\l "`:architecture/sym"
/correct way to load:
\l architecture/sym
/When successful:
/	•	It sets the global variable .Q.par to that path (`:architecture/sym).
/	•	It reads the database definition (the metadata from the sym folder) into memory.
/	•	It does not immediately load all tables from all partitions — because kdb+ is designed for lazy, on-demand loading.
/ then we go back up the two levels to original root
\cd ../..
\pwd

tables[]
select from quote
.q.load[] /to load all tables explicitly
.q.load trade
.sam.quote:select from quote
count .sam.quote
.sam.trade:select from trade
count .sam.trade
/subtract 500ms and add 500ms to each time for WINDOW JOIN
windowls:-0D00:00:00.500 0D00:00:00.500+\:.sam.trade`time /each corresponding elements give us one second span
windowls[1]-windowls[0] /list of 0D00:00:01.000000000 x 5918
count each windowls /5918x5918 -- two legs
/window join syntax: wj[window;list of cols to do the join oin;trades table;(list of values -- quotes table;aggregations on other columns like MBBO i.e. max bid, min ask to get best match)]
wj[windowls;`sym`time;`time xasc .sam.trade;(`time xasc .sam.quote;(max;`bid);(min;`ask))]
wj[windowls;`sym`time;`time xasc .sam.trade;(`time xasc .sam.quote;(::;`bid);(::;`ask))] /to verify, we can replace aggregation with niladic operator '::' -- 147ms
wj[windowls;`sym`time;`time xasc .sam.trade;(`time xasc .sam.quote;(0N!;`bid);(0N!;`ask))] /can also use identity operator '0N!' but slower -- 1079ms



/End-of-Day (EOD) Savedown --- At day's end, the RDB writes data to disk using .Q.dpft or .Q.hdpf
.Q.dpft[`:/path/to/hdb; .z.d; `sym; `tablename]

/d: directory path
/p: partition value (date)
/f: field to apply p# attribute (usually sym)
/t: table name
/This function:
/Enumerates symbols against the sym file using .Q.en
/Writes columns as separate files (splayed)
/Applies the parted attribute to optimize queries
/Notifies HDB to reload with \l .



/Attributes are metadata applied to columns to accelerate queries
Sorted	s#	Column is sorted -- Maintained if appends maintain order
Unique	u#	All values distinct -- Maintained if appends are unique)
Parted	p#	Values grouped in contiguous blocks -- Not maintained: lost on any operation)
Grouped	g#	Creates hash table index -- maintained on appends
Best practices:

RDB: Apply g# to sym for fast lookups during day

HDB: Apply p# to sym after sorting at EOD—data is static, so attribute persists

Multiple g# on HDB: Apply to frequently queried columns (not just sym) since disk space is plentiful


////// Frameworks //////
/ kdb+ is typically used for data capture and analysis.
/ This involves using an architecture with multiple processes working together.
/kdb+ frameworks are available to streamline the setup and configuration of this architecture
/ and add additional functionality such as disaster recovery, logging, access, load balancing etc.
/ https://github.com/DataIntellectTech/TorQ

/// File compression --- https://code.kx.com/q/kb/file-compression/#compression-parameters ///
ttt:1000#enlist asc 1000?10
`:a set ttt  / uncompressed file
(`:../outmisc/za;17;2;9)set ttt          / compressed file
system "pwd"
/logical block size, algorithm, and compression level.
/logical block - power of 2 betw 12 & 20
/algorithm - 0-5
/level - depends on algorithm, 0 is available for all


/// CSV file reading
system "pwd"
system "ls"
/ to get saved table
get `:outmisc/za
t:get `:hdb/mocktrades
//to save down a txt file
`:outmisc/life.txt 0: ("Meaning";"of";"life";"is";"to";"chant";"Hare";"Krishna")
`:outmisc/life.txt
get `:outmisc/life.txt /doesnt work this way
read0 `:outmisc/life.txt
/ to save a table as csv
csv 0: t /first convert table into comma separated list
`:outmisc/mocktrades.csv 0: csv 0: t /now save it down to a text file
get `:outmisc/mocktrades.csv /doesnt work this way
read0 `:outmisc/mocktrades.csv

meta ("DNSJF"; enlist ",") 0: `:outmisc/mocktrades.csv
meta t

/// Temporal operations ==> operations on time-series data, dates, timestamps.
/ q - dates/times are first-class types
dates: 2024.01.01 + til 10
prices: 100 + 10 * sin til 10
trades: ([] time: 09:30:00 09:31:00 09:32:00; price: 100 101 102)
quotes: ([] time: 09:30:30 09:31:30; bid: 99.5 100.5)
/ Time-series joins (asof join) -- Get the most recent quote for each trade
aj[`time; trades; quotes]

/ Window operations
mavg[5; prices]  / 5-period moving average

/ Time bucketing
5 xbar til 15 /pull down all intervals of "leftoperandvalue's width" to leftmost value
select avg price by 2 xbar time.minute from trades


/// Why saving a table creates both filename and filename#
/The # suffix indicates that the data is stored in a two-file format - either because:
/    1. Compound/nested columns
/       colname = offsets/indices
/       colname# = actual nested data
/    2. Compressed files -- When using compression like (:file;17;2;9)set data`:
/       file = metadata/header with compression info
/       file# = the actual compressed data
/    3. Anymap files (V3.6+) -- For mapped vectors and certain nested structures, kdb+ uses # files as part of the anymap storage format.
get `:outmisc/za /gets whole file
-21!`:outmisc/za    / show compression info
/    compressedLength  | 100
/    uncompressedLength| 12096
/    algorithm         | 2i
/    logicalBlockSize  | 17i
/    zipLevel          | 9i
read0 `:outmisc/za#
/When you persist a tablewith compound/nested columns (lists of lists, strings, etc.) or nested list to disk via set/Q.dpft, q produces two objects:
/simplecolName        ← (flat file) -- Simple vectors (int, float, symbol, etc.)
/compoundcolName        ← (indices/offsets) -- Compound lists (nested lists, char vectors/strings)
/compoundcolName#        ← (actual data as hash-file companion) -- contains the actual text found in the column's nested lists/strings.

testtab:([]a:1 2 3;b:("hello";"world";"test"))
`:hdb/secondsplay/ set .Q.en[`:hdb/secondsplay]testtab
\ls -arth hdb/secondsplay
/ You'll get:
/ hdb/secondsplay/a      (simple int vector - one file)
/ hdb/secondsplay/b      (offsets for compound column)
/ hdb/secondsplay/b#     (actual string data)
/ hdb/secondsplay/.d     (column order)

get `:hdb/secondsplay /stops working if now you remove b#
get `:hdb/splayed


/directory hierarchy and HDB on disk layout structure
/ all column flat files can have attributes (p#, g#, s#, u#)
db/                          ← HDB root directory
├── sym                      ← Enumeration file (symbol pool)
├── 2020.10.04/              ← Date partition
│   ├── trade/               ← Splayed table
│   │   ├── .d               ← Column order metadata -- Lists column names in order for table reconstruction
│   │   ├── sym              ← Enumerated symbol column
│   │   ├── time             ← Time column
│   │   ├── price            ← Price column
│   │   └── size             ← Size column
│   └── quote/
│       ├── .d
│       ├── sym
│       ├── time
│       ├── bid
│       └── ask
├── 2020.10.05/              ← Another date partition
│   ├── trade/
│   └── quote/
└── ...

/kdb automatically detects what is the format of partitioned column based on format of directory names
/ Creates virtual column: At query time, kdb+ adds this virtual column to each table—it never exists on disk
.Q.pf /   *****   stores which column is the hdb currently partitioned by -- automatically detected
.Q.pt / returns list of partitioned tables
.Q.pv / returns list of partition values: 2020.10.04 2020.10.05 2020.10.06
.Q.par	/Segmented paths (if par.txt)

/// Symbol File (sym) Management
get `:architecture/sym/sym /`AMZN`MSFT`TSLA`META`B`S`APPL`GOOGL
get `:architecture/sym/2025.10.29/quote/.d /column order ==> `sym`time`bid`ask`bsize`asize
/    Purpose: The sym file is a string pool that enumerates symbol columns to integers, drastically reducing disk space and improving query performance.
/    Absolutely essential—without it, enumerated data is unreadable
/    Techniques:
/        Enumeration during savedown: Use .Q.en[:.;table]` to enumerate symbols before writing
/        Compacting bloated sym files: Over time, unused symbols accumulate. Compact by re-enumerating against a fresh sym file
/        Multiple sym files: For very large systems, enumerate different tables to separate sym files (sym1, sym2, etc.) using .Q.ens or .Q.dpfts
/        Backup sym files: Critical for disaster recovery—losing the sym file makes enumerated data unreadable

/// Other configuration files
par.txt -- Segmented Databases -- For very large HDBs, split across multiple disks/servers
/    db/
/    ├── par.txt          ← Lists segment paths
/    └── sym
/    par.txt contents:
/        /disk0/db
/        /disk1/db
/        /disk2/db
/    Each segment contains its own date partitions:
/        /disk0/db/2020.10.01/
/        /disk1/db/2020.10.02/
/        /disk2/db/2020.10.03/
/    Benefits:
/        Parallel I/O across disks
/        Scales beyond single-disk capacity
/        Map-reduce queries leverage multithreading
/    Considerations:
/        Data must be correctly partitioned (no duplication unless intentional)
/        Requires careful configuration and testing

/// Intraday writedown:
When RAM is limited, write data to disk during the day instead of waiting for EOD:
/    Techniques:
/        Time-based: Write every N minutes
/        Row-based: Write when table exceeds threshold (e.g., 1M rows)
/        Temporary splayed tables: Write to temp location, sort/merge at EOD
/        Integer-partitioned temp dir: Partition by sym enumeration for faster EOD merge
/    Trade-offs:
/        Reduces memory footprint
/        Adds complexity to queries (must check both memory and disk)
/        Slower EOD processing (sorting/merging required)

/// Disaster Recovery strategies:
/    From TP logs: Replay logs into empty HDB (slow but complete)
/    From HDB backups: Fastest—restore files directly
/    Continuous replication: Mirror HDB to DR site