target = "xilinx"
action = "synthesis"

fetchto = "../../../ip_cores"

top_module = "svec_top"

syn_device = "xc6slx150t"
syn_grade = "-3"
syn_package = "fgg900"
syn_project = "svec_gmt_converter.xise"
syn_tool="ise"
syn_top='svec_top'

#files = [ "wrc-release.ram" ]
modules = { "local" : [ "../../../top/svec/gmt-converter" ] }
