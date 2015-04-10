`define ADDR_WRN_CPU_CSR_APP_ID        6'h0
`define ADDR_WRN_CPU_CSR_RESET         6'h4
`define ADDR_WRN_CPU_CSR_ENABLE        6'h8
`define ADDR_WRN_CPU_CSR_UADDR         6'hc
`define WRN_CPU_CSR_UADDR_ADDR_OFFSET 0
`define WRN_CPU_CSR_UADDR_ADDR 32'h000fffff
`define ADDR_WRN_CPU_CSR_CORE_SEL      6'h10
`define ADDR_WRN_CPU_CSR_CORE_COUNT    6'h14
`define ADDR_WRN_CPU_CSR_CORE_MEMSIZE  6'h18
`define ADDR_WRN_CPU_CSR_UDATA         6'h1c
`define ADDR_WRN_CPU_CSR_DBG_JTAG      6'h20
`define WRN_CPU_CSR_DBG_JTAG_JDATA_OFFSET 0
`define WRN_CPU_CSR_DBG_JTAG_JDATA 32'h000000ff
`define WRN_CPU_CSR_DBG_JTAG_JADDR_OFFSET 8
`define WRN_CPU_CSR_DBG_JTAG_JADDR 32'h00000700
`define WRN_CPU_CSR_DBG_JTAG_RSTN_OFFSET 16
`define WRN_CPU_CSR_DBG_JTAG_RSTN 32'h00010000
`define WRN_CPU_CSR_DBG_JTAG_TCK_OFFSET 17
`define WRN_CPU_CSR_DBG_JTAG_TCK 32'h00020000
`define WRN_CPU_CSR_DBG_JTAG_UPDATE_OFFSET 18
`define WRN_CPU_CSR_DBG_JTAG_UPDATE 32'h00040000
`define ADDR_WRN_CPU_CSR_DBG_MSG       6'h24
`define WRN_CPU_CSR_DBG_MSG_DATA_OFFSET 0
`define WRN_CPU_CSR_DBG_MSG_DATA 32'h000000ff
`define ADDR_WRN_CPU_CSR_DBG_POLL      6'h28
`define WRN_CPU_CSR_DBG_POLL_READY_OFFSET 0
`define WRN_CPU_CSR_DBG_POLL_READY 32'h000000ff
`define ADDR_WRN_CPU_CSR_DBG_IMSK      6'h2c
`define WRN_CPU_CSR_DBG_IMSK_ENABLE_OFFSET 0
`define WRN_CPU_CSR_DBG_IMSK_ENABLE 32'h000000ff