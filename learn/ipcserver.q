//on server
\p 5042
\p
/ => 5042i

fnforclient:{x*y}

echofn:{show x} / on server

rsvp:{[argsrec;callbackfn] show argsrec; (neg .z.w) (callbackfn; 201); show `done;} / on server, we dont return anything because it will go to a black hole; we have already returned colculation to client via CB

