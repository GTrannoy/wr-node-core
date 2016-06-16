#!/bin/bash

wbgen2 -V ../core/TrevGen_wb_slave.vhd -H record -p ../core/TrevGen_wb_slave_pkg.vhd -K ../wb/TrevGen_wb_slave.vh -s defines -C ../wb/TrevGen_wb_slave.h -D ../doc/TrevGen_wb_slave.html TrevGen_wb_slave.wb 


