library ieee;
use ieee.std_logic_1164.all;

library work;
use work.wishbone_pkg.all;
use work.list_node_pkg.all;
use work.xvme64x_core_pkg.all;
use work.fine_delay_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_node_pkg.all;
use work.tdc_core_pkg.all;

library unisim;
use unisim.vcomponents.all;

entity svec_top is
  generic (
    g_simulation : integer := 0
    );

  port (
    rst_n_a_i : in std_logic;

    clk_20m_vcxo_i : in std_logic;      -- 20MHz VCXO clock

    clk_125m_pllref_p_i : in std_logic;  -- 125 MHz PLL reference
    clk_125m_pllref_n_i : in std_logic;

    clk_125m_gtp_p_i : in std_logic;    -- 125 MHz PLL reference
    clk_125m_gtp_n_i : in std_logic;

    -- SVEC Front panel LEDs

    fp_led_line_oen_o : out std_logic_vector(1 downto 0);
    fp_led_line_o     : out std_logic_vector(1 downto 0);
    fp_led_column_o   : out std_logic_vector(3 downto 0);

    fp_gpio1_a2b_o  : out std_logic;
    fp_gpio2_a2b_o  : out std_logic;
    fp_gpio34_a2b_o : out std_logic;

    fp_gpio1_b : out std_logic;
    fp_gpio2_b : out std_logic;
    fp_gpio3_b : out std_logic;
    fp_gpio4_b : out std_logic;

    dbg_led0_o : out std_logic;
    dbg_led1_o : out std_logic;
    dbg_led2_o : out std_logic;
    dbg_led3_o : out std_logic;

    carrier_scl_b : inout std_logic;
    carrier_sda_b : inout std_logic;

    -------------------------------------------------------------------------
    -- VME Interface pins
    -------------------------------------------------------------------------

    VME_AS_n_i     : in    std_logic;
    VME_RST_n_i    : in    std_logic;
    VME_WRITE_n_i  : in    std_logic;
    VME_AM_i       : in    std_logic_vector(5 downto 0);
    VME_DS_n_i     : in    std_logic_vector(1 downto 0);
    VME_GA_i       : in    std_logic_vector(5 downto 0);
    VME_BERR_o     : inout std_logic;
    VME_DTACK_n_o  : inout std_logic;
    VME_RETRY_n_o  : out   std_logic;
    VME_RETRY_OE_o : out   std_logic;

    VME_LWORD_n_b   : inout std_logic;
    VME_ADDR_b      : inout std_logic_vector(31 downto 1);
    VME_DATA_b      : inout std_logic_vector(31 downto 0);
    VME_BBSY_n_i    : in    std_logic;
    VME_IRQ_n_o     : out   std_logic_vector(6 downto 0);
    VME_IACK_n_i    : in    std_logic;
    VME_IACKIN_n_i  : in    std_logic;
    VME_IACKOUT_n_o : out   std_logic;
    VME_DTACK_OE_o  : inout std_logic;
    VME_DATA_DIR_o  : inout std_logic;
    VME_DATA_OE_N_o : inout std_logic;
    VME_ADDR_DIR_o  : inout std_logic;
    VME_ADDR_OE_N_o : inout std_logic;

    -------------------------------------------------------------------------
    -- SFP pins
    -------------------------------------------------------------------------

    sfp_txp_o : out std_logic;
    sfp_txn_o : out std_logic;

    sfp_rxp_i : in std_logic := '0';
    sfp_rxn_i : in std_logic := '1';

    sfp_mod_def0_b    : in    std_logic;  -- detect pin
    sfp_mod_def1_b    : inout std_logic;  -- scl
    sfp_mod_def2_b    : inout std_logic;  -- sda
    sfp_rate_select_b : inout std_logic := '0';
    sfp_tx_fault_i    : in    std_logic := '0';
    sfp_tx_disable_o  : out   std_logic;
    sfp_los_i         : in    std_logic := '0';

    pll20dac_din_o    : out std_logic;
    pll20dac_sclk_o   : out std_logic;
    pll20dac_sync_n_o : out std_logic;
    pll25dac_din_o    : out std_logic;
    pll25dac_sclk_o   : out std_logic;
    pll25dac_sync_n_o : out std_logic;

    --- FMC slot 1 pins (TDC mezzanine)
    -- TDC1 PLL AD9516 and DAC AD5662 interface
    fmc0_tdc_pll_sclk_o        : out   std_logic;
    fmc0_tdc_pll_sdi_o         : out   std_logic;
    fmc0_tdc_pll_cs_n_o        : out   std_logic;
    fmc0_tdc_pll_dac_sync_n_o  : out   std_logic;
    fmc0_tdc_pll_sdo_i         : in    std_logic;
    fmc0_tdc_pll_status_i      : in    std_logic;
    fmc0_tdc_125m_clk_p_i      : in    std_logic;
    fmc0_tdc_125m_clk_n_i      : in    std_logic;
    fmc0_tdc_acam_refclk_p_i   : in    std_logic;
    fmc0_tdc_acam_refclk_n_i   : in    std_logic;
    -- TDC1 ACAM timing interface
    fmc0_tdc_start_from_fpga_o : out   std_logic;
    fmc0_tdc_err_flag_i        : in    std_logic;
    fmc0_tdc_int_flag_i        : in    std_logic;
    fmc0_tdc_start_dis_o       : out   std_logic;
    fmc0_tdc_stop_dis_o        : out   std_logic;
    -- TDC1 ACAM data interface
    fmc0_tdc_data_bus_io       : inout std_logic_vector(27 downto 0);
    fmc0_tdc_address_o         : out   std_logic_vector(3 downto 0);
    fmc0_tdc_cs_n_o            : out   std_logic;
    fmc0_tdc_oe_n_o            : out   std_logic;
    fmc0_tdc_rd_n_o            : out   std_logic;
    fmc0_tdc_wr_n_o            : out   std_logic;
    fmc0_tdc_ef1_i             : in    std_logic;
    fmc0_tdc_ef2_i             : in    std_logic;
    -- TDC1 Input Logic
    fmc0_tdc_enable_inputs_o   : out   std_logic;
    fmc0_tdc_term_en_1_o       : out   std_logic;
    fmc0_tdc_term_en_2_o       : out   std_logic;
    fmc0_tdc_term_en_3_o       : out   std_logic;
    fmc0_tdc_term_en_4_o       : out   std_logic;
    fmc0_tdc_term_en_5_o       : out   std_logic;
    -- TDC1 1-wire UniqueID & Thermometer
    fmc0_tdc_one_wire_b        : inout std_logic;
    -- TDC1 EEPROM I2C
    fmc0_tdc_scl_b             : inout std_logic;
    fmc0_tdc_sda_b             : inout std_logic;
    -- TDC1 LEDs
    fmc0_tdc_led_status_o      : out   std_logic;
    fmc0_tdc_led_trig1_o       : out   std_logic;
    fmc0_tdc_led_trig2_o       : out   std_logic;
    fmc0_tdc_led_trig3_o       : out   std_logic;
    fmc0_tdc_led_trig4_o       : out   std_logic;
    fmc0_tdc_led_trig5_o       : out   std_logic;
    -- TDC1 Input channels, also arriving to the FPGA (not used for the moment)
    fmc0_tdc_in_fpga_1_i       : in    std_logic;
    fmc0_tdc_in_fpga_2_i       : in    std_logic;
    fmc0_tdc_in_fpga_3_i       : in    std_logic;
    fmc0_tdc_in_fpga_4_i       : in    std_logic;
    fmc0_tdc_in_fpga_5_i       : in    std_logic;


    fmc1_fd_tdc_start_p_i : in std_logic;
    fmc1_fd_tdc_start_n_i : in std_logic;

    fmc1_fd_clk_ref_p_i : in std_logic;
    fmc1_fd_clk_ref_n_i : in std_logic;

    fmc1_fd_trig_a_i         : in    std_logic;
    fmc1_fd_tdc_cal_pulse_o  : out   std_logic;
    fmc1_fd_tdc_d_b          : inout std_logic_vector(27 downto 0);
    fmc1_fd_tdc_emptyf_i     : in    std_logic;
    fmc1_fd_tdc_alutrigger_o : out   std_logic;
    fmc1_fd_tdc_wr_n_o       : out   std_logic;
    fmc1_fd_tdc_rd_n_o       : out   std_logic;
    fmc1_fd_tdc_oe_n_o       : out   std_logic;
    fmc1_fd_led_trig_o       : out   std_logic;
    fmc1_fd_tdc_start_dis_o  : out   std_logic;
    fmc1_fd_tdc_stop_dis_o   : out   std_logic;
    fmc1_fd_spi_cs_dac_n_o   : out   std_logic;
    fmc1_fd_spi_cs_pll_n_o   : out   std_logic;
    fmc1_fd_spi_cs_gpio_n_o  : out   std_logic;
    fmc1_fd_spi_sclk_o       : out   std_logic;
    fmc1_fd_spi_mosi_o       : out   std_logic;
    fmc1_fd_spi_miso_i       : in    std_logic;
    fmc1_fd_delay_len_o      : out   std_logic_vector(3 downto 0);
    fmc1_fd_delay_val_o      : out   std_logic_vector(9 downto 0);
    fmc1_fd_delay_pulse_o    : out   std_logic_vector(3 downto 0);

    fmc1_fd_dmtd_clk_o    : out std_logic;
    fmc1_fd_dmtd_fb_in_i  : in  std_logic;
    fmc1_fd_dmtd_fb_out_i : in  std_logic;

    fmc1_fd_pll_status_i : in  std_logic;
    fmc1_fd_ext_rst_n_o  : out std_logic;

    fmc1_fd_onewire_b : inout std_logic;

    fmc0_prsntm2c_n_i : in    std_logic;
    fmc0_scl_b        : inout std_logic;
    fmc0_sda_b        : inout std_logic;

    fmc1_prsntm2c_n_i : in    std_logic;
    fmc1_scl_b        : inout std_logic;
    fmc1_sda_b        : inout std_logic;

    tempid_dq_b : inout std_logic;

    uart_rxd_i : in  std_logic := '1';
    uart_txd_o : out std_logic
   -- put the FMC I/Os here
    );
end svec_top;

architecture rtl of svec_top is
  component fd_ddr_pll
    port (
      RST       : in  std_logic;
      LOCKED    : out std_logic;
      CLK_IN1_P : in  std_logic;
      CLK_IN1_N : in  std_logic;
      CLK_OUT1  : out std_logic;
      CLK_OUT2  : out std_logic);
  end component;
  constant c_FMC_MUX_ADDR : t_wishbone_address_array(0 downto 0) :=
    (0 => x"00000000");
  constant c_FMC_MUX_MASK : t_wishbone_address_array(0 downto 0) :=
    (0 => x"10000000");
  
  constant c_hmq_config : t_wrn_mqueue_config :=
    (
      out_slot_count  => 4,
      out_slot_config => (
        0             => (16, 128),
        1             => (128, 16),
        2             => (16, 128),
        3             => (128, 16),
        others        => (0, 0)),

      in_slot_count  => 2,
      in_slot_config => (
        0            => (16, 128),
        1            => (16, 128),
        others       => (0, 0)
        )
      );

  
  constant c_rmq_config : t_wrn_mqueue_config :=
    (
      out_slot_count  => 1,
      out_slot_config => (
        0             => (16, 128),
        others        => (0, 0)),

      in_slot_count  => 1,
      in_slot_config => (
        0            => (16, 128),
        others       => (0, 0)
        )
      );

  constant c_node_config : t_wr_node_config :=
    (
      app_id       => x"115790de",
      cpu_count    => 2,
      cpu_memsizes => (32768, 32768, 0, 0, 0, 0, 0, 0),
      hmq_config   => c_hmq_config,
      rmq_config   => c_rmq_config
      );

  signal clk_sys : std_logic;
  signal rst_n   : std_logic;

  signal fmc_host_wb_out, fmc_dp_wb_out : t_wishbone_master_out_array(0 to 1);
  signal fmc_host_wb_in, fmc_dp_wb_in   : t_wishbone_master_in_array(0 to 1);
  signal fmc_host_irq                   : std_logic_vector(1 downto 0);

  constant c_tdc_bridge_sdb : t_sdb_bridge       := f_xwb_bridge_manual_sdb(x"0001FFFF", x"00000000");
  constant c_tdc_sdb_record : t_sdb_record       := f_sdb_embed_bridge(c_tdc_bridge_sdb, x"00020000");
  constant c_tdc_vector     : t_wishbone_address := x"00032000";

  constant c_fd_sdb_record : t_sdb_record       := f_sdb_embed_device(c_FD_SDB_DEVICE, x"00040000");
  constant c_fd_vector     : t_wishbone_address := x"00040000";

  signal tdc_clk_125m : std_logic;

  signal tm_link_up         : std_logic;
  signal tm_dac_value       : std_logic_vector(23 downto 0);
  signal tm_dac_wr          : std_logic_vector(1 downto 0);
  signal tm_clk_aux_lock_en : std_logic_vector(1 downto 0) := (others => '0');
  signal tm_clk_aux_locked  : std_logic_vector(1 downto 0);
  signal tm_time_valid      : std_logic;
  signal tm_tai             : std_logic_vector(39 downto 0);
  signal tm_cycles          : std_logic_vector(27 downto 0);

  signal fmc1_fd_tdc_start  : std_logic;
  signal ddr1_pll_reset     : std_logic;
  signal ddr1_pll_locked    : std_logic;
  signal dcm1_clk_ref_0     : std_logic;
  signal dcm1_clk_ref_180   : std_logic;
  signal fmc1_fd_pll_status : std_logic;

  signal fmc1_fd_tdc_data_out, fmc1_fd_tdc_data_in : std_logic_vector(27 downto 0);
  signal fmc1_fd_tdc_data_oe                       : std_logic;

  signal fmc1_fd_owr_en, fmc1_fd_owr_in  : std_logic;
  signal fmc1_fd_scl_out, fmc1_fd_scl_in : std_logic;
  signal fmc1_fd_sda_out, fmc1_fd_sda_in : std_logic;

  signal fmc1_wb_out : t_wishbone_master_out;
  signal fmc1_wb_in  : t_wishbone_master_in;

  component dummy_chipscope is
    port (
      clk_i : in std_logic);
  end component dummy_chipscope;
  
begin

  dummy_chipscope_1: dummy_chipscope
    port map (
      clk_i => clk_sys);

  U_Node_Template : svec_list_node_template
    generic map (
      g_fmc0_sdb        => c_tdc_sdb_record,
      g_fmc0_vic_vector => c_tdc_vector,
      g_fmc1_sdb        => c_fd_sdb_record,
      g_fmc1_vic_vector => c_fd_vector,
      g_simulation      => g_simulation,
      g_with_wr_phy     => 1,
      g_wr_node_config  => c_node_config)
    port map (
      rst_n_a_i           => rst_n_a_i,
      rst_n_sys_o         => rst_n,
      clk_sys_o           => clk_sys,
      clk_20m_vcxo_i      => clk_20m_vcxo_i,
      clk_125m_pllref_p_i => clk_125m_pllref_p_i,
      clk_125m_pllref_n_i => clk_125m_pllref_n_i,
      clk_125m_gtp_p_i    => clk_125m_gtp_p_i,
      clk_125m_gtp_n_i    => clk_125m_gtp_n_i,
      fp_led_line_oen_o   => fp_led_line_oen_o,
      fp_led_line_o       => fp_led_line_o,
      fp_led_column_o     => fp_led_column_o,
      fp_gpio1_a2b_o      => fp_gpio1_a2b_o,
      fp_gpio2_a2b_o      => fp_gpio2_a2b_o,
      fp_gpio34_a2b_o     => fp_gpio34_a2b_o,
      fp_gpio1_b          => fp_gpio1_b,
      fp_gpio2_b          => fp_gpio2_b,
      fp_gpio3_b          => fp_gpio3_b,
      fp_gpio4_b          => fp_gpio4_b,
      VME_AS_n_i          => VME_AS_n_i,
      VME_RST_n_i         => VME_RST_n_i,
      VME_WRITE_n_i       => VME_WRITE_n_i,
      VME_AM_i            => VME_AM_i,
      VME_DS_n_i          => VME_DS_n_i,
      VME_GA_i            => VME_GA_i,
      VME_BERR_o          => VME_BERR_o,
      VME_DTACK_n_o       => VME_DTACK_n_o,
      VME_RETRY_n_o       => VME_RETRY_n_o,
      VME_RETRY_OE_o      => VME_RETRY_OE_o,
      VME_LWORD_n_b       => VME_LWORD_n_b,
      VME_ADDR_b          => VME_ADDR_b,
      VME_DATA_b          => VME_DATA_b,
      VME_BBSY_n_i        => VME_BBSY_n_i,
      VME_IRQ_n_o         => VME_IRQ_n_o,
      VME_IACK_n_i        => VME_IACK_n_i,
      VME_IACKIN_n_i      => VME_IACKIN_n_i,
      VME_IACKOUT_n_o     => VME_IACKOUT_n_o,
      VME_DTACK_OE_o      => VME_DTACK_OE_o,
      VME_DATA_DIR_o      => VME_DATA_DIR_o,
      VME_DATA_OE_N_o     => VME_DATA_OE_N_o,
      VME_ADDR_DIR_o      => VME_ADDR_DIR_o,
      VME_ADDR_OE_N_o     => VME_ADDR_OE_N_o,
      sfp_txp_o           => sfp_txp_o,
      sfp_txn_o           => sfp_txn_o,
      sfp_rxp_i           => sfp_rxp_i,
      sfp_rxn_i           => sfp_rxn_i,
      sfp_mod_def0_b      => sfp_mod_def0_b,
      sfp_mod_def1_b      => sfp_mod_def1_b,
      sfp_mod_def2_b      => sfp_mod_def2_b,
      sfp_rate_select_b   => sfp_rate_select_b,
      sfp_tx_fault_i      => sfp_tx_fault_i,
      sfp_tx_disable_o    => sfp_tx_disable_o,
      sfp_los_i           => sfp_los_i,
      pll20dac_din_o      => pll20dac_din_o,
      pll20dac_sclk_o     => pll20dac_sclk_o,
      pll20dac_sync_n_o   => pll20dac_sync_n_o,
      pll25dac_din_o      => pll25dac_din_o,
      pll25dac_sclk_o     => pll25dac_sclk_o,
      pll25dac_sync_n_o   => pll25dac_sync_n_o,

      fmc0_prsntm2c_n_i => fmc0_prsntm2c_n_i,
      fmc1_prsntm2c_n_i => fmc1_prsntm2c_n_i,

      tempid_dq_b          => tempid_dq_b,
      uart_rxd_i           => uart_rxd_i,
      uart_txd_o           => uart_txd_o,
      fmc0_clk_aux_i       => tdc_clk_125m,
      fmc0_host_wb_o       => fmc_host_wb_out(0),
      fmc0_host_wb_i       => fmc_host_wb_in(0),
      fmc0_host_irq_i      => fmc_host_irq(0),
      fmc0_dp_wb_o         => fmc_dp_wb_out(0),
      fmc0_dp_wb_i         => fmc_dp_wb_in(0),
      fmc1_clk_aux_i       => '0',
      fmc1_host_wb_o       => fmc_host_wb_out(1),
      fmc1_host_wb_i       => fmc_host_wb_in(1),
      fmc1_host_irq_i      => fmc_host_irq(1),
      fmc1_dp_wb_o         => fmc_dp_wb_out(1),
      fmc1_dp_wb_i         => fmc_dp_wb_in(1),
      tm_link_up_o         => tm_link_up,
      tm_dac_value_o       => tm_dac_value,
      tm_dac_wr_o          => tm_dac_wr,
      tm_clk_aux_lock_en_i => tm_clk_aux_lock_en,
      tm_clk_aux_locked_o  => tm_clk_aux_locked,
      tm_time_valid_o      => tm_time_valid,
      tm_tai_o             => tm_tai,
      tm_cycles_o          => tm_cycles,
      carrier_scl_b        => carrier_scl_b,
      carrier_sda_b        => carrier_sda_b);


  U_TDC_Core : fmc_tdc_wrapper
    generic map (
      g_simulation => false)
    port map (
      clk_sys_i         => clk_sys,
      rst_sys_n_i       => rst_n,
      rst_n_a_i         => rst_n,
      pll_sclk_o        => fmc0_tdc_pll_sclk_o,
      pll_sdi_o         => fmc0_tdc_pll_sdi_o,
      pll_cs_o          => fmc0_tdc_pll_cs_n_o,
      pll_dac_sync_o    => fmc0_tdc_pll_dac_sync_n_o,
      pll_sdo_i         => fmc0_tdc_pll_sdo_i,
      pll_status_i      => fmc0_tdc_pll_status_i,
      tdc_clk_125m_p_i  => fmc0_tdc_125m_clk_p_i,
      tdc_clk_125m_n_i  => fmc0_tdc_125m_clk_n_i,
      acam_refclk_p_i   => fmc0_tdc_acam_refclk_p_i,
      acam_refclk_n_i   => fmc0_tdc_acam_refclk_n_i,
      start_from_fpga_o => fmc0_tdc_start_from_fpga_o,
      err_flag_i        => fmc0_tdc_err_flag_i,
      int_flag_i        => fmc0_tdc_int_flag_i,
      start_dis_o       => fmc0_tdc_start_dis_o,
      stop_dis_o        => fmc0_tdc_stop_dis_o,
      data_bus_io       => fmc0_tdc_data_bus_io,
      address_o         => fmc0_tdc_address_o,
      cs_n_o            => fmc0_tdc_cs_n_o,
      oe_n_o            => fmc0_tdc_oe_n_o,
      rd_n_o            => fmc0_tdc_rd_n_o,
      wr_n_o            => fmc0_tdc_wr_n_o,
      ef1_i             => fmc0_tdc_ef1_i,
      ef2_i             => fmc0_tdc_ef2_i,
      enable_inputs_o   => fmc0_tdc_enable_inputs_o,
      term_en_1_o       => fmc0_tdc_term_en_1_o,
      term_en_2_o       => fmc0_tdc_term_en_2_o,
      term_en_3_o       => fmc0_tdc_term_en_3_o,
      term_en_4_o       => fmc0_tdc_term_en_4_o,
      term_en_5_o       => fmc0_tdc_term_en_5_o,
      tdc_led_status_o  => fmc0_tdc_led_status_o,
      tdc_led_trig1_o   => fmc0_tdc_led_trig1_o,
      tdc_led_trig2_o   => fmc0_tdc_led_trig2_o,
      tdc_led_trig3_o   => fmc0_tdc_led_trig3_o,
      tdc_led_trig4_o   => fmc0_tdc_led_trig4_o,
      tdc_led_trig5_o   => fmc0_tdc_led_trig5_o,
      tdc_in_fpga_1_i   => fmc0_tdc_in_fpga_1_i,
      tdc_in_fpga_2_i   => fmc0_tdc_in_fpga_2_i,
      tdc_in_fpga_3_i   => fmc0_tdc_in_fpga_3_i,
      tdc_in_fpga_4_i   => fmc0_tdc_in_fpga_4_i,
      tdc_in_fpga_5_i   => fmc0_tdc_in_fpga_5_i,
      mezz_scl_b        => fmc0_scl_b,
      mezz_sda_b        => fmc0_sda_b,
      mezz_one_wire_b   => fmc0_tdc_one_wire_b,

      tm_link_up_i         => tm_link_up,
      tm_time_valid_i      => tm_time_valid,
      tm_cycles_i          => tm_cycles,
      tm_tai_i             => tm_tai,
      tm_clk_aux_lock_en_o => tm_clk_aux_lock_en(0),
      tm_clk_aux_locked_i  => tm_clk_aux_locked(0),
      tm_clk_dmtd_locked_i => '1',
      tm_dac_value_i       => tm_dac_value,
      tm_dac_wr_i          => tm_dac_wr(0),

      direct_slave_i => fmc_dp_wb_out(0),
      direct_slave_o => fmc_dp_wb_in(0),

      slave_i => fmc_host_wb_out(0),
      slave_o => fmc_host_wb_in(0),
      irq_o   => fmc_host_irq(0));



  -------------------------------------------------------------------------------
-- FINE DELAY 1 INSTANTIATION
-------------------------------------------------------------------------------

  cmp_fd_tdc_start1 : IBUFDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => fmc1_fd_tdc_start,          -- Buffer output
      I  => fmc1_fd_tdc_start_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => fmc1_fd_tdc_start_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

  U_DDR_PLL1 : fd_ddr_pll
    port map (
      RST       => ddr1_pll_reset,
      LOCKED    => ddr1_pll_locked,
      CLK_IN1_P => fmc1_fd_clk_ref_p_i,
      CLK_IN1_N => fmc1_fd_clk_ref_n_i,
      CLK_OUT1  => dcm1_clk_ref_0,
      CLK_OUT2  => dcm1_clk_ref_180);

  ddr1_pll_reset     <= not fmc1_fd_pll_status_i;
  fmc1_fd_pll_status <= fmc1_fd_pll_status_i and ddr1_pll_locked;

  U_FineDelay_Core : fine_delay_core
    generic map (
      g_with_wr_core        => true,
      g_simulation          => false,
      g_interface_mode      => PIPELINED,
      g_address_granularity => BYTE)
    port map (
      clk_ref_0_i   => dcm1_clk_ref_0,
      clk_ref_180_i => dcm1_clk_ref_180,
      clk_sys_i     => clk_sys,
      clk_dmtd_i    => '0',
      rst_n_i       => rst_n,
      dcm_reset_o   => open,
      dcm_locked_i  => ddr1_pll_locked,

      trig_a_i          => fmc1_fd_trig_a_i,
      tdc_cal_pulse_o   => fmc1_fd_tdc_cal_pulse_o,
      tdc_start_i       => fmc1_fd_tdc_start,
      dmtd_fb_in_i      => fmc1_fd_dmtd_fb_in_i,
      dmtd_fb_out_i     => fmc1_fd_dmtd_fb_out_i,
      dmtd_samp_o       => fmc1_fd_dmtd_clk_o,
      led_trig_o        => fmc1_fd_led_trig_o,
      ext_rst_n_o       => fmc1_fd_ext_rst_n_o,
      pll_status_i      => fmc1_fd_pll_status,
      acam_d_o          => fmc1_fd_tdc_data_out,
      acam_d_i          => fmc1_fd_tdc_data_in,
      acam_d_oen_o      => fmc1_fd_tdc_data_oe,
      acam_emptyf_i     => fmc1_fd_tdc_emptyf_i,
      acam_alutrigger_o => fmc1_fd_tdc_alutrigger_o,
      acam_wr_n_o       => fmc1_fd_tdc_wr_n_o,
      acam_rd_n_o       => fmc1_fd_tdc_rd_n_o,
      acam_start_dis_o  => fmc1_fd_tdc_start_dis_o,
      acam_stop_dis_o   => fmc1_fd_tdc_stop_dis_o,
      spi_cs_dac_n_o    => fmc1_fd_spi_cs_dac_n_o,
      spi_cs_pll_n_o    => fmc1_fd_spi_cs_pll_n_o,
      spi_cs_gpio_n_o   => fmc1_fd_spi_cs_gpio_n_o,
      spi_sclk_o        => fmc1_fd_spi_sclk_o,
      spi_mosi_o        => fmc1_fd_spi_mosi_o,
      spi_miso_i        => fmc1_fd_spi_miso_i,

      delay_len_o   => fmc1_fd_delay_len_o,
      delay_val_o   => fmc1_fd_delay_val_o,
      delay_pulse_o => fmc1_fd_delay_pulse_o,

      tm_link_up_i         => tm_link_up,
      tm_time_valid_i      => tm_time_valid,
      tm_cycles_i          => tm_cycles,
      tm_utc_i             => tm_tai,
      tm_clk_aux_lock_en_o => tm_clk_aux_lock_en(1),
      tm_clk_aux_locked_i  => tm_clk_aux_locked(1),
      tm_clk_dmtd_locked_i => '1',  --    FIXME: fan out real signal from the
      --    --    WRCore
      tm_dac_value_i       => tm_dac_value,
      tm_dac_wr_i          => tm_dac_wr(1),

      owr_en_o        => fmc1_fd_owr_en,
      owr_i           => fmc1_fd_owr_in,
      i2c_scl_oen_o   => fmc1_fd_scl_out,
      i2c_scl_i       => fmc1_fd_scl_in,
      i2c_sda_oen_o   => fmc1_fd_sda_out,
      i2c_sda_i       => fmc1_fd_sda_in,
      fmc_present_n_i => fmc1_prsntm2c_n_i,

      wb_adr_i   => fmc1_wb_out.adr,
      wb_dat_i   => fmc1_wb_out.dat,
      wb_dat_o   => fmc1_wb_in.dat,
      wb_sel_i   => fmc1_wb_out.sel,
      wb_cyc_i   => fmc1_wb_out.cyc,
      wb_stb_i   => fmc1_wb_out.stb,
      wb_we_i    => fmc1_wb_out.we,
      wb_ack_o   => fmc1_wb_in.ack,
      wb_stall_o => fmc1_wb_in.stall,
      wb_irq_o   => fmc_host_irq(1));

  U_FMC1_WB_Mux : xwb_crossbar
    generic map (
      g_num_masters => 2,
      g_num_slaves  => 1,
      g_registered  => false,
      g_address     => c_FMC_MUX_ADDR,
      g_mask        => c_FMC_MUX_MASK)
    port map (
      clk_sys_i   => clk_sys,
      rst_n_i     => rst_n,
      slave_i(0)  => fmc_dp_wb_out(1),
      slave_i(1)  => fmc_host_wb_out(1),
      slave_o(0)  => fmc_dp_wb_in(1),
      slave_o(1)  => fmc_host_wb_in(1),
      master_i(0) => fmc1_wb_in,
      master_o(0) => fmc1_wb_out);

  fmc1_wb_in.err <= '0';
  fmc1_wb_in.rty <= '0';

-- tristate buffer for the TDC data bus:
  fmc1_fd_tdc_d_b     <= fmc1_fd_tdc_data_out when fmc1_fd_tdc_data_oe = '1' else (others => 'Z');
  fmc1_fd_tdc_oe_n_o  <= '1';
  fmc1_fd_tdc_data_in <= fmc1_fd_tdc_d_b;

  fmc1_fd_onewire_b <= '0' when fmc1_fd_owr_en = '1' else 'Z';
  fmc1_fd_owr_in    <= fmc1_fd_onewire_b;

  fmc1_scl_b <= '0' when (fmc1_fd_scl_out  = '0') else 'Z';
  fmc1_sda_b <= '0' when (fmc1_fd_sda_out = '0') else 'Z';
  fmc1_fd_scl_in <= fmc1_scl_b;
  fmc1_fd_sda_in <= fmc1_sda_b;


end rtl;



