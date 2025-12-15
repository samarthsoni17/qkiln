/ 1. Pattern-1: Rectangular Star Pattern
size:5
charactername:"*"
rectpattern:{[size;charactername] innerls:size # charactername; size # enlist innerls}
show rectpattern[6;"#"]
string[rectpattern[6;"#"]] /doesnt work
.Q.s[rectpattern[6;"#"]] /doesnt quite work yet since we need to remove inner quotes --.Q.s is for showing a representation (it escapes \n), not for printing nice text.
"\n" sv rectpattern[6;"*"] /FINAL ANSWER
show "\n" sv rectpattern[6;"*"]
"******
******
******
******
******
******"

/ 2. Pattern-2: Right-Angled Triangle Pattern
N:5
til N
(not\) til N /DONT EXECUTE THIS RUNS TO INF (kept here for reference and understanding)
1 2 3 +\: 11 22 33 /each left
1 2 3 #\: "*"
rightpattern:{[size;charactername] (1+til size) #\: charactername}
rightpattern[6;"*"]
"\n" sv rightpattern[6;"*"] /FINAL ANSWER - idiomatic
"*
**
***
****
*****
******"

/ 3. Pattern-3: Right-Angled Number Pyramid
1+til each (1+til 5)
rightpyramid:{[size] 1+til each (1+til size) }
" " sv string[1 2 3]
(string each rightpyramid[5])~string[rightpyramid[5]] /list of list of strings (3D, since each number becomes its own string which is a list of characters)
raze string[rightpyramid[5]] /doesnt work
" " sv'string[rightpyramid[5]] /can also use " " sv/:
(" " sv) each string[rightpyramid[5]] /why are these the same??
sqrt' 1 4 9 /doesnt work - so ' must require a dyadic since it is each both
"-+" sv'string[rightpyramid[5]] /doesnt work either, probably because sv only takes atom on its left
"-+" sv'\:string[rightpyramid[5]] /WORKS! becaue now i am modifying sv to each of the left characters
("-+" sv) each string[rightpyramid[5]] /WORKS! this is if we want both -+ to together join
("-+" sv\:) each string[rightpyramid[5]] /HERE WE SEE THE DIFFERENCE! this applies sv with - and + to each row by row rather than entire list after list

"\n" sv " " sv'string[rightpyramid[5]] /FINAL ANSWER -- roundtrip 22 ms
"\n" sv " " sv/:string[rightpyramid[5]] /FINAL ANSWER -- can also use " " sv/:
"\n" sv raze each string[rightpyramid[5]] /if we wanted to save tiem -- roundtrip 14 ms
"1
1 2
1 2 3
1 2 3 4
1 2 3 4 5"

/ 4. Pattern - 4: Right-Angled Number Pyramid - II (each row same numbers)
N # N
(1+til N) #' (1+til N) /FINALLY WE GET TO KNOW REAL MEANING OF EACH BOTH -- nth element of left gets mapped to nth element of right
rightpyramid2:{[size] (1+til size) #' (1+til size) }
rightpyramid2[10]
"\n" sv " " sv'rightpyramid2[10] /this doesnt work because sv' tries to go inside each list and then that is a list of atoms not a list of strings/lists of chars
/can also use " " sv/: since " " is an atom
"\n" sv " " sv'string[rightpyramid2[10]] /FINAL ANSWER
"1
2 2
3 3 3
4 4 4 4
5 5 5 5 5
6 6 6 6 6 6
7 7 7 7 7 7 7
8 8 8 8 8 8 8 8
9 9 9 9 9 9 9 9 9
10 10 10 10 10 10 10 10 10 10"

/ 5. Pattern-5: Inverted Right Pyramid
1 rotate til N
(N-1) rotate til N
reverse til N
(reverse til N) #\: "*"
invrightpattern:{[size;charactername] reverse (1+til size) #\: charactername}
invrightpattern[5;"*"]
"\n" sv invrightpattern[5;"*"] /FINAL ANSWER
"*****
****
***
**
*"


/ 6. Pattern - 6: Inverted Numbered Right Pyramid
"\n" sv reverse " " sv/:string[rightpyramid[5]] /FINAL ANSWER!! (just reversed at the correct spot)
/can also use " " sv' since " " is an atom so ' converts to each right -- but for clarity this is what we keep
"1 2 3 4 5
1 2 3 4
1 2 3
1 2
1"


/ 7. Pattern - 7: Star Pyramid
/we take height as input, which gives number of rows. Bottom row/base width = height*2-1. Each row width = index*2-1 (we start indexing from 1 not 0)
rowwidths:-1+(1+til N)*2
-1+2*1+til N /same!
rowchars:rowwidths #\: "*"
padlengths:`int$((-1+N*2) + neg rowwidths)%2
rowpaddings:padlengths #\: " "
combiner7:{x,y,x}
rowpaddings combiner7' rowchars
"\n","\n" sv rowpaddings combiner7' rowchars /FINAL ANSWER -- extra newline to counter the leftshift of starting double quote

pyramidpattern:{[size;charactername] rowwidths:-1+2*1+til size; rowchars: rowwidths #\: charactername; rowpads: (`int$0.5*(-1+size*2) + neg rowwidths) #\: " "; rowpads combiner7' rowchars}
/use for debug: ; :(count each rowchars; count each rowpads)
pyramidpattern[6;"*"]
pyramidpattern[5;"*"]

"\n","\n" sv pyramidpattern[6;"*"] /FINAL ANSWER
"
     *
    ***
   *****
  *******
 *********
***********"


/ 8. Pattern - 8: Inverted Star Pyramid
"\n","\n" sv reverse pyramidpattern[6;"*"] /FINAL ANSWER!! (just reversed at the correct spot)
"
*********
 *******
  *****
   ***
    *    "

/ 9. Pattern - 9: Diamond Star Pattern
diamondpattern:{[size;charactername] builderblock:pyramidpattern[size;charactername]; builderblock,reverse builderblock}
"\n","\n" sv diamondpattern[7;"+"]  /FINAL ANSWER!
"
    +
   +++
  +++++
 +++++++
+++++++++
+++++++++
 +++++++
  +++++
   +++
    +    "

/ 10. Pattern - 10: Half Diamond Star Pattern
halfdiampattern:{[size;charactername] rightpattern[size;charactername],invrightpattern[size-1;charactername] }
halfdiampattern[5;"*"]
"\n","\n" sv halfdiampattern[5;"*"] /FINAL ANSWER!
"
*
**
***
****
*****
****
***
**
*"

/ 11. Pattern - 11: Binary Number Triangle Pattern
(1+til N) #\: 01b
binarytriangle:{[size] (1+til size) #\: 01b}
"\n" sv raze each string binarytriangle[6]
"0
01
010
0101
01010
010101"

/ 11.1. Reverse the binary order in pattern 11
binarytriangle2:{[size] (1+til size) #\: 10b}
"\n" sv raze each string binarytriangle2[6]
"1
10
101
1010
10101
101010"

/ 11.2. Make it so that the same number is never adjacent vertically either
{x # $[0=x mod 2;10b;01b]} [31]
{x # $[x mod 2;10b;01b]} [31] /no need to check for 0; looks more clean and q-intensive -- we'll go with this
binarytrianglemain:{[size] {x # $[x mod 2;10b;01b]} each 1+til size}
binarytrianglemain[5]
"\n" sv raze each string binarytrianglemain[5] /FINAL ANSWER
"1
01
101
0101
10101"


/ 12. Pattern - 12: Number Crown Pattern
rowpads:(2*N - 1+til N) #\: " " /each left
5 #/: "+-" /each right
1 5 #' "+-" /each both (cant have length mismatch)
combiner12:{(1+til x),y,reverse 1+til x}
combiner12 [5;"   "] /progress
5 combiner12\: "   " /progress
2 5 combiner12\: "   " /progress
2 5 combiner12\: ("  ";"     ") /doesnt work, so we need each both
2 5 combiner12' ("  ";"     ") /doesnt work, so we need each both
(1+til N) combiner12' rowpads /WORKS!
numbercrownpattern:{[size] rowpads:(2 * size - 1+til size) #\: " "; (1+til size) combiner12' rowpads}
numbercrownpattern[6]
"\n","\n" sv raze each string numbercrownpattern[6]
"
1          1
12        21
123      321
1234    4321
12345  54321
123456654321"
"\n","\n" sv raze each string numbercrownpattern[9] /9 is max, after that next level gymnastics involved in getting the spacing symmetry right for double digit


/ ***** 13. Pattern - 13: Increasing Number Triangle Pattern
FL:til 15 /flat list
#[4;FL]
#[4;]/ FL
5 5#FL /i want 5 rows, 5 columns
/     (0 1 2 3 4;
/     5 6 7 8 9;
/     10 11 12 13 14;
/     0 1 2 3 4;
/     5 6 7 8 9)
3 5 5#FL /i want 5 rows, 5 columns, 3 sets where each set starts where the previous one ended
/    ((0 1 2 3 4;5 6 7 8 9;10 11 12 13 14;0 1 2 3 4;5 6 7 8 9);
/    (10 11 12 13 14;0 1 2 3 4;5 6 7 8 9;10 11 12 13 14;0 1 2 3 4);
/    (5 6 7 8 9;10 11 12 13 14;0 1 2 3 4;5 6 7 8 9;10 11 12 13 14))
2 0N#FL /i want 2 rows, dont care how many columns
/    0 1 2 3 4 5 6
/    7 8 9 10 11 12 13 14
0N 4#FL /i want 4 cols, dont care how many rows
/    0 1 2 3
/    4 5 6 7
/    8 9 10 11
/    12 13 14
/okay none of these help us, we need different approach
(sum til N)+1+til N / 11 12 13 14 15 ==> for each row index, go till all lesser natural numbers; then sum them and add back the sum
{x+:1;(sum til x)+1+til x} each til N / add 1 to indexing; (assume starting from 1 so N=5 means 5th row) + build list by doing so for all rows
increasingtriangle:{[numberofrows] {x+:1;(sum til x)+1+til x} each til numberofrows} /seems makeshift
increasingtriangle[5]
/    enlist 1
/    2 3
/    4 5 6
/    7 8 9 10
/    11 12 13 14 15

/lets make above more efficient and less choppy, less makeshift
til N / 0 1 2 3 4
sums til N / 0 1 3 6 10 ==> this gives us LAST element of each row incl 0th -- not directly helpful but lets build further
sums 1+til N / 1 3 6 10 15 ==> removed 0th row + added 5th row -- not helpful
(sums til N) _' 1+til each sums 1+til N  /ANOTHER EWAY TO REACH FINAL ANSWER BUT STILL NOT SO CLEAN AND SATISFACTORY
/cause above we are saying: take me to last elements, then subtract the first X from each list
/lets improve further
1+sums til N / 1 2 4 7 11 ==> this gives us FIRST of elements in each NEXT row (by actually shifting previous list by 1 ahead)
           / ^^ -- better way to remove the 0th and add the 5th row because now we have the first element of each row rather than last
(sums til N)+til N / 0 2 5 9 14 /not helpful
(1+sums til N)+til each 1+til N /FINAL ANSWER --> generate row counts (same as row indexes here) --> then generate natural numbers for each count --> then add the starting element
/    enlist 1
/    2 3
/    4 5 6
/    7 8 9 10
/    11 12 13 14 15

/okay, now we need a way to extract N i.e. here, number of rows, from the input max number limit lastnum
lastnum:15
ceiling 0.5*-1+sqrt 1+8*lastnum /gives number of rows
ceiling 0.5*-1+sqrt 1+8*14 /gives number of rows
/    LOGIC: Total numbers up to row N: N*(N+1)%2
/    We need: N*(N+1)%2 >= lastnum i.e. Solve for smallest N where triangular number ≥ lastnum
/    N(N+1) = 2*lastnum
/    N² + N - 2*lastnum = 0
/    N = [-1 + sqrt(1 + 8*lastnum)] / 2

// now, cut operator
indices _ list
0 3 6 _ til 10
/    0 1 2
/    3 4 5
/    6 7 8 9
(sums til 5) _ til 14 /exactly what we needed all along

increasingtrianglemain:{[lastnum] rowcount:ceiling 0.5*-1+sqrt 1+8*lastnum; (sums til rowcount) _ (1+til lastnum)} /IDIOMATIC
increasingtrianglemain[17]
/    enlist 1
/    2 3
/    4 5 6
/    7 8 9 10
/    11 12 13 14 15
/    16 17

"\n","\n" sv " " sv'string increasingtrianglemain[17] /FINAL ANSWER
/can also use " " sv/: since " " is an atom
/    "
/    1
/    2 3
/    4 5 6
/    7 8 9 10
/    11 12 13 14 15
/    16 17"


/ 14. Pattern-14: Increasing Letter Triangle Pattern
(1+til N) #\: .Q.A
letterpicker:{(1+til x) #\: .Q.A}
"\n","\n" sv " " sv' string letterpicker[6] /FINAL ANSWER
/can also use " " sv/: since " " is an atom
"
A
A B
A B C
A B C D
A B C D E
A B C D E F"

/ 15. Pattern-15: Reverse Letter Triangle Pattern
"\n","\n" sv " " sv' string reverse (1+til N) #\:  .Q.A /FINAL ANSWER - reverse at the right place
/can also use " " sv/: since " " is an atom
"
A B C D E
A B C D
A B C
A B
A"

/ 16. Pattern - 16: Alpha-Ramp Pattern
N:5
(1+til N) #' N#.Q.A /first make both lists same length, then take each both
"\n","\n" sv " " sv' string (1+til N) #' N#.Q.A /FINAL ANSWER - N=27 will start all over from A
/can also use " " sv/: since " " is an atom
"
A
B B
C C C
D D D D
E E E E E"

/ 17. Pattern - 17: Alpha-Hill Pattern
N:5
letterpicker[N],'reverse each (enlist ""),letterpicker[N-1]
((reverse til N)#\:" "),'letterpicker[N],'reverse each (enlist ""),letterpicker[N-1] /add spaces at front
"\n","\n" sv " " sv/: string ((reverse til N)#\:" "),'letterpicker[N],'reverse each (enlist ""),letterpicker[N-1] /FINAL ANSWER, lots of code golf
