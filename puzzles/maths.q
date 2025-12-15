// Euler discretization of geometric brownian motion
/ simulation of 1M end of period values St

/square root
sqrt 2 /1.4142136
sqrt 42.4 /6.5115282
sqrt 1b /1
sqrt -2 /0n (NULL)
/exponent
exp 1 /2.7182818
exp 4.2 /66.686331
exp -12i /0.0000061
/natural log
log exp 1 /1
log exp 1.8 /1.8
log exp -12i /-12i
log 0.5 /-ve value
/ n random numbers between 0 and 1
100000 ? 1.0 /22ms
/how to generate 3.1415927 or π
cos 1.57075 /cos π/2 = 0
cos 3.1415 /cos π = -1
cos 6.283185 / 2π ≈ 6.283185
acos -1 /will give output π = 3.1415927
/generate gaussian sampling function -- Box-Muller Transform
stdgauss:{[n]
  u: n?1.0;             / uniform(0,1)
  v: n?1.0;             / another independent uniform(0,1)
  z: (sqrt -2*log u) * cos 2*(acos -1)*v;  / Box-Muller Transform
  z                     / standard normal samples
 }
stdgauss[100]
avg stdgauss[100000]
var stdgauss[100000]
/ square a number
(*/) 2#sigma
prd 2#sigma
/equation parameters
s0:100
r:0.05
T:1.0 /1f
sigma:0.2
/finally, the equation
sT:s0 * exp (T * r - 0.5 * prd 2#sigma) + sigma * stdgauss[1000000] * sqrt T
/*** only 77ms, compared to 458 ms in python