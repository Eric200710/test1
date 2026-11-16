# figure-demo.gp：用純文字腳本畫折線圖
# 用法：這個檔和 figure-data.dat 放同一個資料夾，終端機進到那個資料夾後輸入
#   gnuplot figure-demo.gp
# 跑完會多出 figure-demo.png（放進 LaTeX、Word、簡報都可以）
# 圖內文字用英文：gnuplot 的中文字型每台電腦不同，先求圖出得來。

set terminal pngcairo size 1000,700 font "Sans,16"
set output "figure-demo.png"

set title "Compile errors per week (demo data)"
set xlabel "Week"
set ylabel "Errors"
set grid
set key top right
set xrange [0.5:8.5]
set yrange [0:*]
set style data linespoints

plot "figure-data.dat" using 1:2 title "Group A" lw 3 pt 7 ps 1.5, \
     "figure-data.dat" using 1:3 title "Group B" lw 3 pt 5 ps 1.5

set output
