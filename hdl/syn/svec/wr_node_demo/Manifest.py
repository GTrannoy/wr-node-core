action = "synthesis"
target="xilinx"
fetchto = "../../../ip_cores"

syn_device = "xc6slx150t"
syn_grade = "-3"
syn_package = "fgg900"
syn_top = "svec_top"
syn_project = "svec_wr_node_demo.xise"
top_module = "svec_top" 
syn_tool = "ise" 

modules = { "local" : [ "../../../top/svec/wr_node_demo" ] }
