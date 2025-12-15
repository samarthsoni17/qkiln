// to select earliest date:
select from table where date=min date
/ OR
select from table where date=first date
/ to select last date:
select from table where date=max date
// OR
select from table where date=last date
// to find count:
select count i from <rest of query>
// Use keyword 'within' to filter the date; can store intermediate results in variable for ease of use
jan09:select from trips where date within 2009.01.10 2009.01.31


// kxacademy exercises:

/find time and space utilised by a query: (date should always be first)
\ts select col from tab where date = min date, cond2
\ts select col from tab where cond2, date = min date

/ex1 - On the earliest date, how many trips had fewer than two passengers?
select count i from trips where date=min date, passengers<2
/ex1.1 - What about the last date?
select count i from trips where date=max date, passengers<2
/ex2 - Select payment_type and fare from the trips data for the first date.
select payment_type, fare from trips where date=first date