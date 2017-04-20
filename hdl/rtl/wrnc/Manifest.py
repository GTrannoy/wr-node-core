files = [	"mock_turtle_core.vhd", 
                "mock_turtle_pkg.vhd",
                "mt_wb_remapper.vhd" ]
modules = { 
    "local" : [ "cpu", "mqueue", "smem",
                "../../ip_cores/general-cores",
                "../../ip_cores/etherbone-core",
                "../../ip_cores/wr-cores",
            ] }
