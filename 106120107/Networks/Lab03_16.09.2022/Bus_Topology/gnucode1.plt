set autoscale
set xtic auto
set ytic auto
set title "plr"
set xlabel "Time"
set ylabel "BPS"

plot "test1.dat" using 1:2 with linespoints
