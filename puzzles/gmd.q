tab:read0`:/Users/SamarthSoni/Downloads/GMD.csv
" " vs/:tab /doesnt work if no whitespace in any row, output becomes a list of single value lists for each row
"\n" vs/:tab /doesnt work if no newline in any row, output becomes a list of single value lists for each row
"," vs/:tab /convert each row into a list of strings separated by the comma between them

"," vs tab 0 /convert comma separation into list for first row
count "," vs tab 0 /count of first row = how many columns in the csv
(count "," vs tab 0)#"*" /read all these as strings...

/read  all columns as strings
((count "," vs tab 0)#"*"; enlist ",") 0: `:/Users/SamarthSoni/Downloads/GMD.csv
/1st 3: symbols | 4th: short | next 63: float | next 3 boolean | last one is float
((3#"S"),"H",(63#"F"),(3#"B"),"F"; enlist ",") 0: `:/Users/SamarthSoni/Downloads/GMD.csv
