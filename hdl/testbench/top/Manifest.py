action = "simulation"
target = "xilinx"
fetchto = "../../ip_cores"
vlog_opt="+incdir+../../sim +incdir+../include"
vcom_opt="-mixedsvvh l"

files = [ "main.sv" ]

modules = { "local" :  [ "../../rtl" ] }

