sim_tool = "modelsim"
top_module="main"
action = "simulation"
target = "xilinx"
fetchto = "../../ip_cores"
vlog_opt="+incdir+../../include/wb +incdir+../include/vme64x_bfm +incdir+../include +incdir+../../sim"
vcom_opt="-mixedsvvh l"

syn_device="xc6slx150t"
include_dirs=["../../sim", "../include", "../include/vme64x_bfm", "../../ip_cores/serdes-tdc/core"]

files = [ "main.sv" ]

modules = { "local" :  [ "../../rtl" , "../../top/svec/wr_d3s_test" ] }

