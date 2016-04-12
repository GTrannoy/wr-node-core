#!/bin/bash

wbgen2 -V ../hostif/stdc_wb_slave.vhd -H record -p ../hostif/stdc_wbgen2_pkg.vhd -K ../hostif/stdc_wb_slave.vh -s defines -C ../../../../../software/applications/wr_d3s/rt/common/hw/stdc_wb_slave.h -D ../doc/stdc_wb_slave.html stdc_wb_slave.wb 
