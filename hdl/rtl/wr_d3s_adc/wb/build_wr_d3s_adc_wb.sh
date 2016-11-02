#!/bin/bash

wbgen2 -V wr_d3s_adc_wb.vhd -H record -p wr_d3s_adc_wbgen2_pkg.vhd -K wr_d3s_adc.vh -s defines -C wr_d3s_adc.h -D wr_d3s_adc.html wr_d3s_adc.wb 
mv -v wr_d3s_adc.vh ../../../testbench/include/.
mv -v wr_d3s_adc.html ../doc/.
mv -v wr_d3s_adc_wb.vhd ../.
mv -v wr_d3s_adc_wbgen2_pkg.vhd ../.
mv -v wr_d3s_adc.h /user/ecalvo/repos/d3s_adc/rt/common/hw/.





