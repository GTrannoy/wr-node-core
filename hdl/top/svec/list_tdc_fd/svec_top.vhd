-------------------------------------------------------------------------------
-- Title      : WR Trigger Distribution Node (SVEC)
-- Project    : LHC Instability Trigger Distribution (LIST)
-------------------------------------------------------------------------------
-- File       : svec_top.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2015-07-30
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Top level design of the SVEC-based LIST WR trigger distribution node, with
-- FMC Fine Delay in slot 2 and FMC TDC in slot 1.
-------------------------------------------------------------------------------
--
-- Copyright (c) 2014 CERN
--
-- This source file is free software; you can redistribute it   
-- and/or modify it under the terms of the GNU Lesser General   
-- Public License as published by the Free Software Foundation; 
-- either version 2.1 of the License, or (at your option) any   
-- later version.                                               
--
-- This source is distributed in the hope that it will be       
-- useful, but WITHOUT ANY WARRANTY; without even the implied   
-- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      
-- PURPOSE.  See the GNU Lesser General Public License for more 
-- details.                                                     
--
-- You should have received a copy of the GNU Lesser General    
-- Public License along with this source; if not, download it   
-- from http://www.gnu.org/licenses/lgpl-2.1.html
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.wishbone_pkg.all;
use work.svec_node_pkg.all;
use work.xvme64x_core_pkg.all;
use work.fine_delay_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_node_pkg.all;
use work.tdc_core_pkg.all;

library unisim;
use unisim.vcomponents.all;

entity svec_top is
  generic (
    g_simulation : boolean := false
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

    fp_gpio1_b : inout std_logic;
    fp_gpio2_b : inout std_logic;
    fp_gpio3_b : inout std_logic;
    fp_gpio4_b : inout std_logic;

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

  function f_int_to_bool (x : integer) return boolean is
  begin
    if (x = 0) then
      return false;
    else
      return true;
    end if;
  end function;

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
        0             => (width => 128, entries => 32),  -- control CPU 0 (to host)
        1             => (width => 128, entries => 32),  -- control CPU 1 (to host)
        2             => (width => 128, entries => 32),  -- log CPU 0
        3             => (width => 128, entries => 32),  -- log CPU 1
        others        => (0, 0)),

      in_slot_count  => 2,
      in_slot_config => (
        0            => (width => 128, entries => 32),  -- control CPU 0 (from host)
        1            => (width => 128, entries => 32),  -- control CPU 1 (from host)
        others       => (0, 0)
        )
      );

  
  constant c_rmq_config : t_wrn_mqueue_config :=
    (
      out_slot_count  => 1,
      out_slot_config => (
        0             => (width => 128, entries => 16),  -- TDC remote out
        others        => (0, 0)),

      in_slot_count  => 1,
      in_slot_config => (
        0            => (width => 128, entries => 16),  -- FD remote in

        others => (0, 0)
        )
      );

  constant c_node_config : t_wr_node_config :=
    (
      app_id       => x"115790de",
      cpu_count    => 2,
      cpu_memsizes => (32768, 32768, 0, 0, 0, 0, 0, 0),
      hmq_config   => c_hmq_config,
      rmq_config   => c_rmq_config,
      shared_mem_size => 8192
      );

  signal clk_sys : std_logic;
  signal rst_n   : std_logic;

  signal fmc_host_wb_out, fmc_dp_wb_out : t_wishbone_master_out_array(0 to 1);
  signal fmc_host_wb_in, fmc_dp_wb_in   : t_wishbone_master_in_array(0 to 1);
  signal fmc_host_irq                   : std_logic_vector(1 downto 0);

  constant c_tdc_bridge_sdb : t_sdb_bridge       := f_xwb_bridge_manual_sdb(x"00007FFF", x"00000000");
  constant c_tdc_sdb_record : t_sdb_record       := f_sdb_embed_bridge(c_tdc_bridge_sdb, x"00010000");
  constant c_tdc_vector     : t_wishbone_address := x"00013000";

  constant c_fd_sdb_record : t_sdb_record       := f_sdb_embed_device(c_FD_SDB_DEVICE, x"00018000");
  constant c_fd_vector     : t_wishbone_address := x"00018000";

  attribute keep : string;

  signal tdc_clk_125m     : std_logic;
  signal dcm1_clk_ref_0   : std_logic;
  signal dcm1_clk_ref_180 : std_logic;

  attribute keep of tdc_clk_125m   : signal is "TRUE";
  attribute keep of dcm1_clk_ref_0 : signal is "TRUE";

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
  signal fmc1_fd_pll_status : std_logic;

  signal fmc1_fd_tdc_data_out, fmc1_fd_tdc_data_in : std_logic_vector(27 downto 0);
  signal fmc1_fd_tdc_data_oe                       : std_logic;

  signal fmc1_fd_owr_en, fmc1_fd_owr_in  : std_logic;
  signal fmc1_fd_scl_out, fmc1_fd_scl_in : std_logic;
  signal fmc1_fd_sda_out, fmc1_fd_sda_in : std_logic;
  signal fmc0_scl_out                    : std_logic;
  signal fmc0_sda_out                    : std_logic;

  signal fmc1_wb_out : t_wishbone_master_out;
  signal fmc1_wb_in  : t_wishbone_master_in;

  component chipscope_ila
    port (
      CONTROL : inout std_logic_vector(35 downto 0);
      CLK     : in    std_logic;
      TRIG0   : in    std_logic_vector(31 downto 0);
      TRIG1   : in    std_logic_vector(31 downto 0);
      TRIG2   : in    std_logic_vector(31 downto 0);
      TRIG3   : in    std_logic_vector(31 downto 0));
  end component;

  component chipscope_icon
    port (
      CONTROL0 : inout std_logic_vector (35 downto 0));
  end component;

  signal CONTROL : std_logic_vector(35 downto 0);
  signal TRIG    : std_logic_vector(127 downto 0);
  
begin


  U_Node_Template : svec_node_template
    generic map (
      g_fmc0_sdb                 => c_tdc_sdb_record,
      g_fmc0_vic_vector          => c_tdc_vector,
      g_fmc1_sdb                 => c_fd_sdb_record,
      g_fmc1_vic_vector          => c_fd_vector,
      g_simulation               => g_simulation,
      g_with_wr_phy              => true,
      g_double_wrnode_core_clock => false,
      g_with_white_rabbit        => true,      
      g_wr_node_config           => c_node_config)
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
      fmc1_clk_aux_i       => dcm1_clk_ref_0,
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
      g_simulation          => g_simulation,
      g_with_direct_readout => true)
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
      mezz_scl_i        => fmc0_scl_b,
      mezz_sda_i        => fmc0_sda_b,
      mezz_scl_o        => fmc0_scl_out,
      mezz_sda_o        => fmc0_sda_out,
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

      slave_i        => fmc_host_wb_out(0),
      slave_o        => fmc_host_wb_in(0),
      irq_o          => fmc_host_irq(0),
      clk_125m_tdc_o => tdc_clk_125m);

  fmc0_scl_b <= '0' when fmc0_scl_out = '0' else 'Z';
  fmc0_sda_b <= '0' when fmc0_sda_out = '0' else 'Z';


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
      g_simulation          => g_simulation,
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
      g_registered  => true,
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

  --chipscope_ila_1 : chipscope_ila
  --  port map (
  --    CONTROL => CONTROL,
  --    CLK     => clk_sys,
  --    TRIG0   => TRIG(31 downto 0),
  --    TRIG1   => TRIG(63 downto 32),
  --    TRIG2   => TRIG(95 downto 64),
  --    TRIG3   => TRIG(127 downto 96));

  --chipscope_icon_1 : chipscope_icon
  --  port map (
  --    CONTROL0 => CONTROL);


  trig(15 downto 0) <= fmc_dp_wb_out(0).adr(15 downto 0);
  trig(0+16)        <= fmc_dp_wb_out(0).we;
  trig(0+17)        <= fmc_dp_wb_out(0).stb;
  trig(0+18)        <= fmc_dp_wb_out(0).cyc;
  trig(0+19)        <= fmc_dp_wb_in(0).ack;
  trig(0+20)        <= fmc_dp_wb_in(0).stall;

  trig(32+15 downto 32) <= fmc_dp_wb_out(1).adr(15 downto 0);
  trig(32+16)           <= fmc_dp_wb_out(1).we;
  trig(32+17)           <= fmc_dp_wb_out(1).stb;
  trig(32+18)           <= fmc_dp_wb_out(1).cyc;
  trig(32+19)           <= fmc_dp_wb_in(1).ack;
  trig(32+20)           <= fmc_dp_wb_in(1).stall;

  trig(64+15 downto 64) <= fmc1_wb_out.adr(15 downto 0);
  trig(64+16)           <= fmc1_wb_out.we;
  trig(64+17)           <= fmc1_wb_out.stb;
  trig(64+18)           <= fmc1_wb_out.cyc;
  trig(64+19)           <= fmc1_wb_in.ack;
  trig(64+20)           <= fmc1_wb_in.stall;

  trig(127 downto 96) <= fmc1_wb_out.dat;


  fmc1_wb_in.err <= '0';
  fmc1_wb_in.rty <= '0';

-- tristate buffer for the TDC data bus:
  fmc1_fd_tdc_d_b     <= fmc1_fd_tdc_data_out when fmc1_fd_tdc_data_oe = '1' else (others => 'Z');
  fmc1_fd_tdc_oe_n_o  <= '1';
  fmc1_fd_tdc_data_in <= fmc1_fd_tdc_d_b;

  fmc1_fd_onewire_b <= '0' when fmc1_fd_owr_en = '1' else 'Z';
  fmc1_fd_owr_in    <= fmc1_fd_onewire_b;

  fmc1_scl_b     <= '0' when (fmc1_fd_scl_out = '0') else 'Z';
  fmc1_sda_b     <= '0' when (fmc1_fd_sda_out = '0') else 'Z';
  fmc1_fd_scl_in <= fmc1_scl_b;
  fmc1_fd_sda_in <= fmc1_sda_b;


end rtl;



