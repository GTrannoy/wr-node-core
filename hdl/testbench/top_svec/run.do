vlog -sv main.sv +incdir+. +incdir+../../include/wb +incdir+../include/vme64x_bfm +incdir+../../include +incdir+../include +incdir+../../sim
vsim work.main -voptargs=+acc -t 10fs

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

do wave.do
radix -hexadecimal
run 350us