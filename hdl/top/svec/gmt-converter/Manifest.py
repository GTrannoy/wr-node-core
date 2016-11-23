files = [ "synthesis_descriptor.vhd", "svec_top.vhd", "svec_top.ucf", "gmt_pll_wrapper.vhd" ]

fetchto = "../../ip_cores"

modules = {
    "local" : [	"../../../rtl/wrnc", "../../../rtl/gmt-converter", 
		"../node_template", 
		"../../../ip_cores/vme64x-core" ],
    }
