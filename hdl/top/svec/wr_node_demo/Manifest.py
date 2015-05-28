files = [ "synthesis_descriptor.vhd", "svec_top.vhd", "svec_top.ucf" ]

fetchto = "../../ip_cores"

modules = {
    "local" : [	"../../../rtl/wrnc", 
		"../node_template", 
		"../../../ip_cores/vme64x-core" ],
    }
