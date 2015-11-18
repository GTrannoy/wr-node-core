files = [ "synthesis_descriptor.vhd", "spec_top.vhd", "spec_top.ucf" ]

fetchto = "../../ip_cores"

modules = {
    "local" : [	"../../../rtl", 
		"../node_template", 
		"../../../ip_cores/gn4124-core" ],
    }
