#!/bin/bash

wbgen2 -V gmt_converter_wb.vhd -H record -p gmt_converter_wbgen2_pkg.vhd -K gmt_converter_wb.vh -s defines -C gmt_converter_wb.h -D gmt_converter_wb.html gmt_converter_wb.wb 
mv -v gmt_converter_wb.vh ../../../testbench/include/.
mv -v gmt_converter_wb.html ../doc/.
mv -v gmt_converter_wb.vhd ../.
mv -v gmt_converter_wbgen2_pkg.vhd ../.
#mv -v gmt_converter.h ../../../../software/applications/gmt_converter/rt/common/hw/.

