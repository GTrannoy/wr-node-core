sim_tool = "modelsim"
sim_top="main"
top_module="main"
syn_device="xc6slx150t"

action = "simulation"
target = "xilinx"
fetchto = "../../ip_cores"
include_dirs=["../../sim", "../include", "../include/vme64x_bfm"]

vcom_opt="-mixedsvvh l -2008"

files = [ "main.sv" ]

modules = { "local" :  [ "../../rtl" ] }

