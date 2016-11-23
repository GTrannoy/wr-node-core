#!/bin/bash

wbgen2 -V wr_d3s_adc_slave_wb.vhd -H record -p wr_d3s_adc_slave_wbgen2_pkg.vhd -K wr_d3s_adc_slave.vh -s defines -C wr_d3s_adc_slave.h -D wr_d3s_adc_slave.html wr_d3s_adc_slave.wb 
mv -v wr_d3s_adc_slave.vh ../../../testbench/include/.
mv -v wr_d3s_adc_slave.html ../doc/.
mv -v wr_d3s_adc_slave_wb.vhd ../.
mv -v wr_d3s_adc_slave_wbgen2_pkg.vhd ../.
mv -v wr_d3s_adc_slave.h /user/ecalvo/repos/d3s_adc/rt/common/hw/.
