filter:{y where x y}; /x: function; y:data, list generally... return elements of the list where function is true on the list
filter:{w:where x y;$[99=type y;w#y;y w]}; /more advanced, works on both list and dict
kfilter:{filter[x;key y]#y}; /filter on key side of a dictionary
map:{y!x y}; /getting a dictionary key starting with 1; primarily for debugging; something on a list that you want to make visible for future use
mapt:{(first x)xcol([y] (last x)y,:())}; / fancy version, turn to table instead of a dictionary
{((first x)y)!(last x)y} /when we need to modify both the key and value side -- pass in 2 functions -- or one function to modify both the key and the value
/when we need to pass the key to the function
{(!). flip raze x .'flip(key y;get y)} /when we need to be able to add new key/value pairs to the output -- like encoded key (foo_bar convert to foo and bar)
/^^ 1. decompose dict 2. flip it 3. run "." on each of those 4. raze it 5. flip it again 6. make that back into a dictionary
{(key y)!x get y} / when we need to pretend there aren't any keys for a bit
(cf. .Q.ft)
/merging with other utils:
dir:{x .Q.dd'key x} /lists either for a namespace or dictionary or directory on disk, the contents with their full path
dirf:{y .Q.dd'filter[x]key y} /when we dont want ALL files and wish to filter it further

/e.g.s
filter[5<]til 10
map[(count get@)']tables[] /count of all tables in current namespace
mapt[(`table`rows;(count get@)')]tables[] /return the above as a table
dir `.
dir `:hdb
dir `:outmisc
dirf[like[;"*.csv"]] `:outmisc /   *****   !!
.sam.dic:flip quotes
dir `.sam
dir `.q
dirf[like[;"*asc"]] `.q /   *****   !!

/function to convert all symbols in a table to strings -- useful for creating attributes for functional update or query
/get column names from table meta where type=string;
/then map:create dictionary of column names on one side and on other side, functional form to convert each into a string
mocktrades:get `:hdb/mocktrades
meta mocktrades
{![x;();0b;map[(string;)']exec c from meta x where t="s"]} 1000#mocktrades

/first function applies the second function to all columns of a table -- use that to rename the columns
/special example -- this is to deal with a custom situation you might find yourself dealing with regularly
/when you are left joining 2 tables together that have same column names on value side, and you wish to retain both versions (for comparision) you can use this
{(x cols y)xcol y}[{`$"foo_",/:string x};1000#mocktrades]

