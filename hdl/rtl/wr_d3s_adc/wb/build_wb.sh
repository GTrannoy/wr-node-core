#!/bin/bash

wbgen2 -V wr_d3s_adc_wb.vhd -H record -p wr_d3s_adc_wbgen2_pkg.vhd -K wr_d3s_adc.vh -s defines -C wr_d3s_adc.h -D wr_d3s_adc.html wr_d3s_adc.wb 
mv -v wr_d3s_adc.vh ../../../testbench/include/.
mv -v wr_d3s_adc.html ../doc/.
mv -v wr_d3s_adc_wb.vhd ../.
mv -v wr_d3s_adc_wbgen2_pkg.vhd ../.
mv -v wr_d3s_adc.h ../../../../software/applications/wr_d3s_adc/rt/common/hw/.

wbgen2 -V wr_d3s_adc_slave_wb.vhd -H record -p wr_d3s_adc_slave_wbgen2_pkg.vhd -K wr_d3s_adc_slave.vh -s defines -C wr_d3s_adc_slave.h -D wr_d3s_adc_slave.html wr_d3s_adc_slave.wb 
mv -v wr_d3s_adc_slave.vh ../../../testbench/include/.
mv -v wr_d3s_adc_slave.html ../doc/.
mv -v wr_d3s_adc_slave_wb.vhd ../.
mv -v wr_d3s_adc_slave_wbgen2_pkg.vhd ../.
mv -v wr_d3s_adc_slave.h ../../../../software/applications/wr_d3s_adc/rt/common/hw/.

wbgen2 -V d3s_acq_buffer_wb.vhd -H record -p d3s_acq_buffer_wbgen2_pkg.vhd -K d3s_acq_buffer_wb.vh -s defines -C d3s_acq_buffer_wb.h -D d3s_acq_buffer_wb.html d3s_acq_buffer_wb.wb 
mv -v d3s_acq_buffer_wb.vh ../../testbench/include/.
mv -v d3s_acq_buffer_wb.html ../doc/.
mv -v d3s_acq_buffer_wb.vhd ../.
mv -v d3s_acq_buffer_wbgen2_pkg.vhd ../.
mv -v d3s_acq_buffer_wb.h ../../../../software/applications/wr_d3s_adc/rt/common/hw/.

