#!/bin/bash

wbgen2 -V TrevGen_wb_slave.vhd --hstyle=record -p TrevGen_wbgen2_pkg.vhd -K TrevGen_wb_slave.vh -s defines -C TrevGen_wb_slave.h -f html -D TrevGen_wb_slave.html TrevGen_wb_slave.wb 
mv -v TrevGen_wb_slave.vhd ../core/.
mv -v TrevGen_wbgen2_pkg.vhd ../core/.
mv -v TrevGen_wb_slave.vh ../../../testbench/include/.
mv -v TrevGen_wb_slave.html ../doc/.
mv -v TrevGen_wb_slave.h /user/ecalvo/repos/d3s_adc/rt/common/hw/.

