#!/bin/bash

wbgen2 -V stdc_wb_slave.vhd -H record -p stdc_wbgen2_pkg.vhd -K stdc_wb_slave.vh -s defines -C stdc_wb_slave.h -D stdc_wb_slave.html stdc_wb_slave.wb 
mv -v -s stdc_wb_slave.html ../doc/stdc_wb_slave.html
mv -v -s ../../../testbench/include/stdc_wb_slave.vh stdc_wb_slave.vh
