files = [	"wr_node_core.vhd", 
		"wr_node_pkg.vhd",
		"wr_node_core_with_etherbone.vhd",
		"wb_remapper.vhd" ]
modules = { 
"local" : [ "cpu", "mqueue", "smem" ],
"git" : [ 
        "git@ohwr.org:hdl-core-lib/general-cores.git::tom-lm32-wrnode",
        "git@ohwr.org:hdl-core-lib/etherbone-core.git::tom-wr-node",
        "git@ohwr.org:hdl-core-lib/wr-cores.git::tom-wr-node",

        ] }
