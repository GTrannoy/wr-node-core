files = [ "synthesis_descriptor.vhd", "svec_top.vhd", "svec_top.ucf" ]

fetchto = "../../ip_cores"

modules = {
    "local" : [	"../../../rtl/wrnc", 
		"../node_template", 
		"../../../ip_cores/fine-delay/hdl", 
		"../../../ip_cores/fmc-tdc/hdl/rtl",
		"../../../ip_cores/vme64x-core" ],
    }
