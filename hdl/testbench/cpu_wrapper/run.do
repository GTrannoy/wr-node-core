vlog -sv main.sv +incdir+. +incdir+../../include/wb +incdir+../../include/vme64x_bfm +incdir+../../include
vsim -t 1ps work.main -voptargs=+acc

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

do wave.do
radix -hexadecimal
run 100us