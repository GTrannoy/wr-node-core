#!/bin/bash

wbgen2 -V stdc_wb_slave.vhd -H record -p stdc_wbgen2_pkg.vhd -K stdc_wb_slave.vh -s defines -C stdc_wb_slave.h -D stdc_wb_slave.html stdc_wb_slave.wb 
mv -v stdc_wb_slave.vhd ../core/.
mv -v stdc_wbgen2_pkg.vhd ../core/.
mv -v stdc_wb_slave.html ../doc/.
mv -v stdc_wb_slave.vh ../../../testbench/include/stdc_wb_slave.vh
mv -v stdc_wb_slave.h /user/ecalvo/repos/d3s_adc/rt/common/hw/.
