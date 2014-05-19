#!/bin/bash

mkdir -p doc
wbgen2 -D ./doc/wrn_cpu_csr.html -V wrn_cpu_csr_wb.vhd -p wrn_cpu_csr_wbgen2_pkg.vhd --cstyle defines -C wrn_cpu_csr.h --hstyle record --lang vhdl -K wrn_cpu_csr_regs.vh wrn_cpu_csr.wb 
wbgen2 -D ./doc/wrn_cpu_lr.html -V wrn_cpu_lr_wb.vhd -p wrn_cpu_lr_wbgen2_pkg.vhd --cstyle defines -C wrn_cpu_lr.h --hstyle record --lang vhdl wrn_cpu_lr.wb 
