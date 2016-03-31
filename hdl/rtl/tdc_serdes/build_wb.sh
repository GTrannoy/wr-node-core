#!/bin/bash

wbgen2 -V ../../ip_cores/serdes-tdc/hostif/stdc_wb_slave.vhd -H record -p ../../ip_cores/serdes-tdc/hostif/stdc_wbgen2_pkg.vhd -K ../../ip_cores/serdes-tdc/hostif/stdc_wb_slave.vh -s defines -C stdc_wb_slave.h -D ../../ip_cores/serdes-tdc/doc/stdc_wb_slave.html stdc_wb_slave.wb 
