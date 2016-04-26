#!/bin/bash

wbgen2 -V wr_d3s_adc_wb.vhd -H record -p wr_d3s_adc_wbgen2_pkg.vhd -K ../../testbench/include/regs/wr_d3s_adc.vh -s defines -C wr_d3s_adc.h wr_d3s_adc.wb 
wbgen2 -V d3s_acq_buffer_wb.vhd -H record -p d3s_acq_buffer_wbgen2_pkg.vhd -K ../../testbench/include/d3s_acq_buffer_wb.vh -s defines -C d3s_acq_buffer_wb.h d3s_acq_buffer_wb.wb 
