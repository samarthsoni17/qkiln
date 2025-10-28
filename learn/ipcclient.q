til 10

h:hopen `:localhost:57108 / on client, to server

h

h"6*7"

h"show 6*7"

h (`fnforclient; 6; 7)

({x+y}; 6; 7)

hclose h

h "echofn"

h "echofn \"HareKrishna\""


/ASYNCHRONOUS
(neg h)

(neg h) (`echo; 42) / on client
(neg h) "echofn \"HareKrishna\""
(neg h) (`echofn; "Hare Krishna")

myechofn:{show x} /on client

(neg h) (`rsvp; "my input load"; `myechofn) /calls the rsvp func it knows is present on server and sends input load

(neg h) (`rsvp; (1 2 3); `myechofn)

(1 2 3)

