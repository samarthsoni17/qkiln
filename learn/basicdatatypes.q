/timestamp
/timespan
/https://code.kx.com/q4m3/2_Basic_Data_Types_Atoms/
boolean -- 0b
byte -- 0x00
short -- 0Nh
int -- 0Ni
long -- 0Nj
real -- 0Ne
float -- 0n
char -- " "
symbol -- `
timestamp -- 0Np -- type 2015.01.01D00:00:00.000000000
month -- 0Nm -- 2006.07m
date -- 0Nd -- 2006.07.21
(datetime) -- 0Nz -- 2006.07.21T09:13:39
timespan -- 0Nn -- 12:00:00.000000000
minute -- 0Nu -- 23:59
second -- 0Nv -- type 23:59:59
time -- 0Nt -- 09:01:02.042
nil -- ::

/for a homogenous list of atoms of "wide" type, should a narrower type be presented for update or append in place, the narrow type will not be automatically promoted and an error will result
longlist:5 4 6
type longlist /7h
type longlist,6i /0h

/float
3.14159265
1f
1.0 /1f -- console shortens
/sceintific notation
1.234e07 /1.234e+07
1.234e7 /1.234e+07
\P 9
1.234e-7 /1.234e-07
/real
12.34e
1.234e7e /1.234e+07e -- awkward!
\P 18 //max goes till 17
1%3 /0.33333333333333331 -- last digit is unreliable

/boolean in arithmetic
42+1b /43
3.1415+0b /3.1415
/use for eliminating conditionals
ismonday:2 = .z.d mod 7
iswedflag:4 = .z.d mod 7
base:100
base+(ismonday*42)+iswedflag*64 /164 for wednesday; 142 for monday

/byte
0x2a
0x2A
`int$0x29 /41
1+0x29

/guid
1?0Ng /each time different, but same initial seed so same order of generation across q sessions on the same machine
2?0Ng /each time different
/basically, you will always get same order of results as long as you do it on this same macbook: (try with 12?0Ng)
1?0Ng /,8c6b8b64-6815-6084-0a3e-178401251b68
1?0Ng /,5ae7962d-49f2-404d-5aec-f7c8abbae288
1?0Ng /,5a580fb6-656b-5e69-d445-417ebfe71994
1?0Ng /,ddb87915-b672-2c32-a6cf-296061671e9d
1?0Ng /,580d8c87-e557-0db1-3a19-cb3a44d623b1
3?0Ng /2d948578-e9d6-79a2-8207-9df7a71f0b3b 409031f3-b19c-6770-ee84-6e9369c98697 52cb20d9-f12c-9963-2829-3c64d8d8cb14
\c 20000 20000
4?0Ng /cddeceef-9ee9-3847-9172-3e3d7ab39b26 97911f28-7bfa-7efa-6c10-4fb48ceeb4f1 42d88ac8-24e2-f268-a5be-629cacef657f 1c22a468-9492-2173-9e4f-9003a23d02b7
-1?0Ng /each time different, but seed is random for different across q sessions
-2?0Ng /each time different

/Import guid....parsing a string of 16 hex digits.
type "G"$"61f35174-90bc-a48a-d88f-e15e4a377ec8" /-2h for atom guid
type -2?0Ng /2h for list guid
/   *****   convert from a list of 16 bytes using an overload of sv.
16?0xff /0x5E8872E1344298F0BCC588F5BE5FBBD2
0x0 sv 16?0xff /7e4d3df7-78f5-c6fa-240c-e1dce32d53e7
0x0 sv 8?0xff / -3555110582864678020

/chars with escapes
"q"
"\""
"\\"
"\n"
"\r" /return
"\t" /tab
/escape any ASCII character using underlying 3 octal digits
"\142" / b
`int$"b" /==> 98 in decimal ==> 142 in octal
/98 ÷ 8 = 12 R 2 ==> 2
/12 ÷ 8 = 1 R 4 ==> 4
/1 ÷ 8 = 0 R 1 ==> 1
`int$"A" /==> 65 in decimal ==> 101 in octal
/65 ÷ 8 = 8 R 1
/8 ÷ 8 = 1 R 0
/1 ÷ 8 = 0 R 1
"\101" / A
`int$"5" /==> 53 in decimal ==> 065 in octal
/        Steps to Convert DECIMAL to Octal
/        53 ÷ 8 = 6 R 5
/        6 ÷ 8 = 0 R 6
/        Reading the remainders from the bottom up:
/        65 (then append 0 at front to make 3-digit)
"\065" / 5

/        Steps to Convert Octal to Decimal
/           (6 × 8^1)
/        +	(5 × 8^0)
/            _________
/            53
/
/           (1 × 8^2)
/        +	(4 × 8^1)
/        +	(2 × 8^0)
/            _________
/            98
\

`$"A symbol with blanks and `"
`$"A symbol with escape \" and \n new line \t and tab"

2015.01.01 /just the date
2000.01.01=0 /1b
2000.01.02=1 /1b
1999.12.31=-1 /1b
`int$2000.02.01 /underlying day count by casting

/time - milliseconds since midnight, lower resolution
.z.t /current in utc
12:34:56.789
05:29:13.581
12:00:00.000=12*60*60*1000 /1b
`int$12:00:00.000 /underlying milliscond value
`int$.z.t /millisecs past since midnight until now

/timespan
12:34:56.123456789 /0D12:34:56.123456789
12:34:56.123456 / microseconds become nanos -- 0D12:34:56.123456000
`long$12:34:56.123456789 /underlying nanosec value


.z.p /timestamp -- PREFERRED
2025.11.12D05:38:37.658256000
2014.11.22D17:43:40.123456789
`long$2014.11.22D17:43:40.123456789 /underlying nanosecond count since the millenium
`long$1914.11.22D17:43:40.123456789 /pre millenium is negative
`date$.z.p  /extract date portion -- 2025.11.12
`time$.z.p  /extract time portion -- 05:40:03.942
`timespan$.z.p  /extract timespan portion -- 0D05:40:04.753965000
`month$.z.p  /extract month portion -- 2025.11m


.z.z /datetime -- DEPRECATED (underlying float value can be fuzzy)
2025.11.12T05:35:25.224
2000.01.02T12:00:00.000=1.5 /datetime value stores in a float the fractional day count from midnight Jan 1, 2000.
`float$2000.01.02T12:00:00.000 /underlying fractional day count
`float$.z.z /fractional day count of now
`date$2000.01.02T12:00:00.000 /extract date portion
`time$2000.01.02T12:00:00.000 /extract time portion
`timespan$2000.01.02T12:00:00.000 /extract timespan portion
`month$2000.01.02T12:00:00.000 /extract month portion


/month - count of months since the beginning of the millennium. Post-milieu is positive and pre is negative.
2025.11m
2025.11 /  **  Leaving off the type indicator m yields a float
2001.01m=12
`int$2015.01m /underlying month count
2015.07m=2015.07.01 /the first day of the month is equal to the month

/minute -- number of minutes from midnight
12:00=12*60 /1b
type 12:30 /-17h
`int$12:00 /underlying min count
`minute$.z.t /current minute value
`int$`minute$.z.t /current minute count since midnight
/minute equals its equivalent time and timestamp counterparts
12:00=12:00:00.000 /1b
12:00=12:00:00.000000000 /1b

/second -- number of seconds from midnight
23:59:59=-1+24*60*60 /1b
`int$12:34:56 /45296i
`int$12:34:56.000 /45296000i
`long$12:34:56.000000000 /45296000000000
/but these are all equal for q -- kind of like how 1 km = 100,000 cm
12:34:56=12:34:56.000000000 /1b

.z.u /prints the user

/constituents using dot notation
dt:.z.d /2025.11.12
dt.year /2025i
dt.mm /11i
dt.dd /12i
ti:12:34:56.789
ti.hh /12i
ti.mm /34i
ti.ss /56
/recommended to use type casting instead
`dd$2001.01.01 /1i
`mm$dt /11i
`dd$dt /12i
/higher order constituents
`month$dt /2025.11m
`year$dt /2025i
/   *****   extract milliseconds or nanoseconds
(`int$12:34:56.789) mod 1000 /789 -- extract milliseconds from time type, use 10^3
(`long$12:34:56.123456789) mod 1000000000 /123456789 -- extract nanoseconds from time type, use 10^9


`$string(dt) /to convert to symbol you first need to convert to string

/infinity values
1%0 /0w - float infinity
0%0 /0n - undefined float
/for integer ones:
-9223372036854775809 /0N /-9223372036854775807 = MIN_INT
`long$-0W /-9223372036854775807 = MIN_INT+1
`long$0W /9223372036854775807 = MAX_INT
-0W-1 /0N = MIN_INT
-0W+1 /-9223372036854775806
-0W+1 /-9223372036854775806
0W=-0W-2 /1b
0W+1 /0N
0W+2 /-0W
0W+3 /-9223372036854775806
(-0W)=0W+2 /1b

/null checks -- better use "null" monadic function rather than use '=' which you can also do
null 42 /0b
null ` /1b
null 0b /0b
null "" /empty boolean list
null " " /1b
null 0n /1b
null (0%0) /1b
0n=0%0 /1b -- can also use '=' but then need to remember the null literal of the type

