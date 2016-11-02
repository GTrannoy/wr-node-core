#!/bin/bash

wbgen2 -V d3s_acq_buffer_wb.vhd -H record -p d3s_acq_buffer_wbgen2_pkg.vhd -K d3s_acq_buffer_wb.vh -s defines -C d3s_acq_buffer_wb.h -D d3s_acq_buffer_wb.html d3s_acq_buffer_wb.wb 
mv -v d3s_acq_buffer_wb.vh ../../../testbench/include/.
mv -v d3s_acq_buffer_wb.html ../doc/.
mv -v d3s_acq_buffer_wb.vhd ../.
mv -v d3s_acq_buffer_wbgen2_pkg.vhd ../.
mv -v d3s_acq_buffer_wb.h /user/ecalvo/repos/d3s_adc/rt/common/hw/.
