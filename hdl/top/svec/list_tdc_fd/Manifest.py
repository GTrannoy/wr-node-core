files = [ "synthesis_descriptor.vhd", "svec_top.vhd", "svec_top.ucf" ]

fetchto = "../../ip_cores"

modules = {
    "local" : [	"../../../rtl", 
		"../list_node_template", 
		"../../../ip_cores/fine-delay/hdl", 
		"../../../ip_cores/fmc-tdc/hdl" ],

    "git": [ "git://ohwr.org/hdl-core-lib/vme64x-core.git" ]
    }
