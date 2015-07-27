action = "synthesis"
target="xilinx"
fetchto = "../../../ip_cores"

syn_device = "xc6slx45t"
syn_grade = "-3"
syn_package = "fgg484"
syn_top = "spec_top"
syn_project = "spec_wr_node_demo.xise"
top_module = "spec_top" 
syn_tool = "ise" 

modules = { "local" : [ "../../../top/spec/wr_node_demo" ] }
