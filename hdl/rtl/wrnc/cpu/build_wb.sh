#!/bin/bash

mkdir -p doc
wbgen2 -D ./doc/mt_cpu_csr.html -V mt_cpu_csr_wb.vhd -p mt_cpu_csr_wbgen2_pkg.vhd --cstyle defines -C mt_cpu_csr.h --hstyle record --lang vhdl -K mt_cpu_csr_regs.vh mt_cpu_csr.wb 
wbgen2 -D ./doc/mt_cpu_lr.html -V mt_cpu_lr_wb.vhd -p mt_cpu_lr_wbgen2_pkg.vhd --cstyle defines -C mt_cpu_lr.h --hstyle record --lang vhdl mt_cpu_lr.wb 
