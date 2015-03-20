files = [	"wr_node_core.vhd", 
		"wr_node_pkg.vhd",
		"wr_node_core_with_etherbone.vhd",
		"wb_remapper.vhd" ]
modules = { 
"local" : [ "cpu", "mqueue", "smem",
        "../../ip_cores/general-cores",
        "../../ip_cores/etherbone-core",
        "../../ip_cores/wr-cores",
        ] }
