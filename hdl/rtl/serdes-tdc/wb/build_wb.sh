#!/bin/bash

wbgen2 -V ../core/stdc_wb_slave.vhd -H record -p ../core/stdc_wbgen2_pkg.vhd -K ../core/stdc_wb_slave.vh -s defines -C stdc_wb_slave.h -D ../doc/stdc_wb_slave.html stdc_wb_slave.wb 
