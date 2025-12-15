1. Using \t Command (Standard Timing)
text
q)\t select from your_table where condition
\t 1000?1
45  // milliseconds
2. Using \ts Command (Time + Space)
text
q)\ts select from your_table where condition
45 2048  // milliseconds and bytes