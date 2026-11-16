# figure-bar.gp：同一份資料，換成長條圖
# 用法：gnuplot figure-bar.gp    跑完多出 figure-bar.png

set terminal pngcairo size 1000,700 font "Sans,16"
set output "figure-bar.png"

set title "Compile errors per week (demo data)"
set xlabel "Week"
set ylabel "Errors"
set grid ytics
set key top right
set yrange [0:*]
set style data histograms
set style histogram clustered gap 1
set style fill solid 0.8 border -1
set boxwidth 0.9

plot "figure-data.dat" using 2:xtic(1) title "Group A", \
     "figure-data.dat" using 3 title "Group B"

set output
