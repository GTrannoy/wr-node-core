action = "simulation"
target = "xilinx"
fetchto = "../../ip_cores"
vlog_opt="+incdir+../../include/wb +incdir+../../include/vme64x_bfm +incdir+../../include"
vcom_opt="-mixedsvvh l"

files = [ "main.sv" ]

modules = { "local" :  [ "../../rtl" ] }

