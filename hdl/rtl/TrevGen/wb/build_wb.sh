#!/bin/bash

wbgen2 -V TrevGen_wb_slave.vhd --hstyle=record -p TrevGen_wbgen2_pkg.vhd -K TrevGen_wb_slave.vh -s defines -C TrevGen_wb_slave.h -f html -D TrevGen_wb_slave.html TrevGen_wb_slave.wb 
mv -v -s TrevGen_wb_slave.vh ../../../testbench/include/TrevGen_wb_slave.vh
mv -v -s TrevGen_wb_slave.html ../doc/TrevGen_wb_slave.html


