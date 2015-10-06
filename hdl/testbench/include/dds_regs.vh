`define ADDR_DDS_CR                    7'h0
`define DDS_CR_SAMP_EN_OFFSET 0
`define DDS_CR_SAMP_EN 32'h00000001
`define DDS_CR_SAMP_DIV_OFFSET 1
`define DDS_CR_SAMP_DIV 32'h0001fffe
`define DDS_CR_RF_CNT_ENABLE_OFFSET 17
`define DDS_CR_RF_CNT_ENABLE 32'h00020000
`define ADDR_DDS_TCR                   7'h4
`define DDS_TCR_WR_LOCK_EN_OFFSET 0
`define DDS_TCR_WR_LOCK_EN 32'h00000001
`define DDS_TCR_WR_LOCKED_OFFSET 1
`define DDS_TCR_WR_LOCKED 32'h00000002
`define DDS_TCR_WR_LINK_OFFSET 2
`define DDS_TCR_WR_LINK 32'h00000004
`define DDS_TCR_WR_TIME_VALID_OFFSET 3
`define DDS_TCR_WR_TIME_VALID 32'h00000008
`define ADDR_DDS_GPIOR                 7'h8
`define DDS_GPIOR_PLL_SYS_CS_N_OFFSET 0
`define DDS_GPIOR_PLL_SYS_CS_N 32'h00000001
`define DDS_GPIOR_PLL_SYS_RESET_N_OFFSET 1
`define DDS_GPIOR_PLL_SYS_RESET_N 32'h00000002
`define DDS_GPIOR_PLL_SCLK_OFFSET 2
`define DDS_GPIOR_PLL_SCLK 32'h00000004
`define DDS_GPIOR_PLL_SDIO_OFFSET 3
`define DDS_GPIOR_PLL_SDIO 32'h00000008
`define DDS_GPIOR_PLL_SDIO_DIR_OFFSET 4
`define DDS_GPIOR_PLL_SDIO_DIR 32'h00000010
`define DDS_GPIOR_PLL_VCXO_RESET_N_OFFSET 5
`define DDS_GPIOR_PLL_VCXO_RESET_N 32'h00000020
`define DDS_GPIOR_PLL_VCXO_CS_N_OFFSET 6
`define DDS_GPIOR_PLL_VCXO_CS_N 32'h00000040
`define DDS_GPIOR_PLL_VCXO_SDO_OFFSET 7
`define DDS_GPIOR_PLL_VCXO_SDO 32'h00000080
`define DDS_GPIOR_ADF_CE_OFFSET 8
`define DDS_GPIOR_ADF_CE 32'h00000100
`define DDS_GPIOR_ADF_CLK_OFFSET 9
`define DDS_GPIOR_ADF_CLK 32'h00000200
`define DDS_GPIOR_ADF_LE_OFFSET 10
`define DDS_GPIOR_ADF_LE 32'h00000400
`define DDS_GPIOR_ADF_DATA_OFFSET 11
`define DDS_GPIOR_ADF_DATA 32'h00000800
`define DDS_GPIOR_SERDES_PLL_LOCKED_OFFSET 12
`define DDS_GPIOR_SERDES_PLL_LOCKED 32'h00001000
`define ADDR_DDS_PD_DATA               7'hc
`define DDS_PD_DATA_DATA_OFFSET 0
`define DDS_PD_DATA_DATA 32'h0000ffff
`define DDS_PD_DATA_VALID_OFFSET 16
`define DDS_PD_DATA_VALID 32'h00010000
`define ADDR_DDS_TUNE_VAL              7'h10
`define DDS_TUNE_VAL_TUNE_OFFSET 0
`define DDS_TUNE_VAL_TUNE 32'h0fffffff
`define DDS_TUNE_VAL_LOAD_ACC_OFFSET 28
`define DDS_TUNE_VAL_LOAD_ACC 32'h10000000
`define ADDR_DDS_FREQ_HI               7'h14
`define ADDR_DDS_FREQ_LO               7'h18
`define ADDR_DDS_ACC_SNAP_HI           7'h1c
`define ADDR_DDS_ACC_SNAP_LO           7'h20
`define ADDR_DDS_ACC_LOAD_HI           7'h24
`define ADDR_DDS_ACC_LOAD_LO           7'h28
`define ADDR_DDS_GAIN                  7'h2c
`define ADDR_DDS_RSTR                  7'h30
`define DDS_RSTR_PLL_RST_OFFSET 0
`define DDS_RSTR_PLL_RST 32'h00000001
`define DDS_RSTR_SW_RST_OFFSET 1
`define DDS_RSTR_SW_RST 32'h00000002
`define ADDR_DDS_I2CR                  7'h34
`define DDS_I2CR_SCL_OUT_OFFSET 0
`define DDS_I2CR_SCL_OUT 32'h00000001
`define DDS_I2CR_SDA_OUT_OFFSET 1
`define DDS_I2CR_SDA_OUT 32'h00000002
`define DDS_I2CR_SCL_IN_OFFSET 2
`define DDS_I2CR_SCL_IN 32'h00000004
`define DDS_I2CR_SDA_IN_OFFSET 3
`define DDS_I2CR_SDA_IN 32'h00000008
`define ADDR_DDS_FREQ_MEAS_RF_IN       7'h38
`define ADDR_DDS_FREQ_MEAS_DDS         7'h3c
`define ADDR_DDS_FREQ_MEAS_GATE        7'h40
`define ADDR_DDS_SAMPLE_IDX            7'h44
`define ADDR_DDS_RF_RST_PHASE          7'h48
`define DDS_RF_RST_PHASE_LO_OFFSET 0
`define DDS_RF_RST_PHASE_LO 32'h000000ff
`define DDS_RF_RST_PHASE_HI_OFFSET 8
`define DDS_RF_RST_PHASE_HI 32'h0000ff00
`define ADDR_DDS_RF_CNT_TRIGGER        7'h4c
`define DDS_RF_CNT_TRIGGER_CYCLES_OFFSET 0
`define DDS_RF_CNT_TRIGGER_CYCLES 32'h0fffffff
`define DDS_RF_CNT_TRIGGER_ARM_LOAD_OFFSET 28
`define DDS_RF_CNT_TRIGGER_ARM_LOAD 32'h10000000
`define DDS_RF_CNT_TRIGGER_DONE_OFFSET 29
`define DDS_RF_CNT_TRIGGER_DONE 32'h20000000
`define ADDR_DDS_RF_CNT_SYNC_VALUE     7'h50
`define ADDR_DDS_RF_CNT_PERIOD         7'h54
`define ADDR_DDS_RF_CNT_RF_SNAPSHOT    7'h58
`define ADDR_DDS_RF_CNT_RAW            7'h5c
`define ADDR_DDS_RF_CNT_CYCLES_SNAPSHOT 7'h60
`define ADDR_DDS_TRIG_IN_SNAPSHOT      7'h64
`define ADDR_DDS_TRIG_IN_CSR           7'h68
`define DDS_TRIG_IN_CSR_ARM_OFFSET 0
`define DDS_TRIG_IN_CSR_ARM 32'h00000001
`define DDS_TRIG_IN_CSR_DONE_OFFSET 1
`define DDS_TRIG_IN_CSR_DONE 32'h00000002
`define ADDR_DDS_PULSE_OUT_CYCLES      7'h6c
`define ADDR_DDS_PULSE_OUT_CSR         7'h70
`define DDS_PULSE_OUT_CSR_ARM_OFFSET 0
`define DDS_PULSE_OUT_CSR_ARM 32'h00000001
`define DDS_PULSE_OUT_CSR_DONE_OFFSET 1
`define DDS_PULSE_OUT_CSR_DONE 32'h00000002
`define DDS_PULSE_OUT_CSR_ADJ_COARSE_OFFSET 2
`define DDS_PULSE_OUT_CSR_ADJ_COARSE 32'h0000001c
`define DDS_PULSE_OUT_CSR_ADJ_FINE_OFFSET 5
`define DDS_PULSE_OUT_CSR_ADJ_FINE 32'h00007fe0
