target = "xilinx"
action = "synthesis"

fetchto = "../../../ip_cores"

syn_device = "xc6slx150t"
syn_grade = "-3"
syn_package = "fgg900"
syn_top = "svec_top"
syn_project = "svec_list_tdc_fd.xise"

#files = [ "wrc-release.ram" ]
modules = { "local" : [ "../../../top/svec/list_tdc_fd" ] }
