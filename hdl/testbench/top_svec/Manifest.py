action = "simulation"
target = "xilinx"
fetchto = "../../ip_cores"
vlog_opt="+incdir+../../include/wb +incdir+../include/vme64x_bfm +incdir+../include +incdir+../../sim"
vcom_opt="-mixedsvvh l"
sim_tool = "modelsim"
top_module="main"
syn_device="xc6slx150t"
files = [ "main.sv" ]
include_dirs=["../include", "../include/vme64x_bfm", "../../sim"]
modules = { "local" :  [ "../../rtl" , "../../top/svec/list_tdc_fd" ] }

