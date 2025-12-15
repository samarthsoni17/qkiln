The errors in KDB/Q seem to be cryptic at first, but they are actually quite intuitive. For example:
type - you are trying to perform an operation on parameters of different type, say add a symbol to a number.

type:   2+`a --> this would throw a type error
length - 2 3 4+1 2 would throw a length error, you are trying to add two vectors of different length.
rank - whenever you pass too many or too few arguments to a function

til 5
'break
til 10