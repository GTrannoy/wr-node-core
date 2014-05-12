files = [	"wr_node_core.vhd", 
		"wr_node_pkg.vhd",
		"wr_node_core_with_etherbone.vhd" ]
modules = { 
"local" : [ "cpu", "mqueue", "smem" ],
"git" : [ 
        "git@ohwr.org:hdl-core-lib/general-cores.git::master",
        "git@ohwr.org:hdl-core-lib/etherbone-core.git::master",
        "git@ohwr.org:hdl-core-lib/wr-hdl.git::master",

        ] }
