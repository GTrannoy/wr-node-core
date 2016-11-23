-------------------------------------------------------------------------------
-- Title      : GMT-WR Converter
-- Project    : 
-------------------------------------------------------------------------------
-- File       : svec_top.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-11-16
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
-- GMT-To-White Rabbit Converter Top Level
-- 
-------------------------------------------------------------------------------
--
-- Copyright (c) 2016 CERN
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
use work.wrn_mqueue_pkg.all;
use work.wr_node_pkg.all;


library unisim;
use unisim.vcomponents.all;

entity svec_top is
  generic (
    g_simulation : boolean := false
    );
  port (
    rst_n_a_i           : in  std_logic;
    ----------------------------------------
    --  Clock controls
    ----------------------------------------
    clk_20m_vcxo_i      : in  std_logic;  -- 20MHz VCXO clock
    clk_125m_pllref_p_i : in  std_logic;  -- 125 MHz PLL reference
    clk_125m_pllref_n_i : in  std_logic;
    clk_125m_gtp_p_i    : in  std_logic;  -- 125 MHz PLL reference
    clk_125m_gtp_n_i    : in  std_logic;
    ----------------------------------------
    -- SVEC Front panel LEDs
    ----------------------------------------
    fp_led_line_oen_o   : out std_logic_vector(1 downto 0);
    fp_led_line_o       : out std_logic_vector(1 downto 0);
    fp_led_column_o     : out std_logic_vector(3 downto 0);

    ----------------------------------------    
    -- SVEC GPIO
    ----------------------------------------  
    fp_gpio1_a2b_o     : out   std_logic;
    fp_gpio2_a2b_o     : out   std_logic;
    fp_gpio34_a2b_o    : out   std_logic;
    fp_gpio1_b         : inout std_logic;
    fp_gpio2_b         : inout std_logic;
    fp_gpio3_b         : inout std_logic;
    fp_gpio4_b         : inout std_logic;
    fp_gpio1_term_en_o : out   std_logic;
    fp_gpio2_term_en_o : out   std_logic;
    fp_gpio3_term_en_o : out   std_logic;
    fp_gpio4_term_en_o : out   std_logic;

    ----------------------------------------
    -- VME Interface pins
    ----------------------------------------
    VME_AS_n_i        : in    std_logic;
    VME_RST_n_i       : in    std_logic;
    VME_WRITE_n_i     : in    std_logic;
    VME_AM_i          : in    std_logic_vector(5 downto 0);
    VME_DS_n_i        : in    std_logic_vector(1 downto 0);
    VME_GA_i          : in    std_logic_vector(5 downto 0);
    VME_BERR_o        : inout std_logic;
    VME_DTACK_n_o     : inout std_logic;
    VME_RETRY_n_o     : out   std_logic;
    VME_RETRY_OE_o    : out   std_logic;
    VME_LWORD_n_b     : inout std_logic;
    VME_ADDR_b        : inout std_logic_vector(31 downto 1);
    VME_DATA_b        : inout std_logic_vector(31 downto 0);
    VME_BBSY_n_i      : in    std_logic;
    VME_IRQ_n_o       : out   std_logic_vector(6 downto 0);
    VME_IACK_n_i      : in    std_logic;
    VME_IACKIN_n_i    : in    std_logic;
    VME_IACKOUT_n_o   : out   std_logic;
    VME_DTACK_OE_o    : inout std_logic;
    VME_DATA_DIR_o    : inout std_logic;
    VME_DATA_OE_N_o   : inout std_logic;
    VME_ADDR_DIR_o    : inout std_logic;
    VME_ADDR_OE_N_o   : inout std_logic;
    ----------------------------------------
    --  SFP pins
    ----------------------------------------
    sfp_txp_o         : out   std_logic;
    sfp_txn_o         : out   std_logic;
    sfp_rxp_i         : in    std_logic := '0';
    sfp_rxn_i         : in    std_logic := '1';
    sfp_mod_def0_b    : in    std_logic;  -- detect 
    sfp_mod_def1_b    : inout std_logic;  -- scl
    sfp_mod_def2_b    : inout std_logic;  -- sda
    sfp_rate_select_b : inout std_logic := '0';
    sfp_tx_fault_i    : in    std_logic := '0';
    sfp_tx_disable_o  : out   std_logic;
    sfp_los_i         : in    std_logic := '0';
    ----------------------------------------
    --  Clock controls
    ----------------------------------------
    pll20dac_din_o    : out   std_logic;
    pll20dac_sclk_o   : out   std_logic;
    pll20dac_sync_n_o : out   std_logic;
    pll25dac_din_o    : out   std_logic;
    pll25dac_sclk_o   : out   std_logic;
    pll25dac_sync_n_o : out   std_logic;
    ----------------------------------------
    -- 1-wire thermometer + unique ID
    ----------------------------------------
    tempid_dq_b       : inout std_logic;
    ----------------------------------------
    --  UART
    ----------------------------------------
    uart_rxd_i        : in    std_logic := '1';
    uart_txd_o        : out   std_logic;
    ----------------------------------------
    --  SVEC carrier EEPROM
    ----------------------------------------
    scl_afpga_b       : inout std_logic;
    sda_afpga_b       : inout std_logic;
    ----------------------------------------   
    -- Fmc Management 
    ----------------------------------------
    fmc0_prsntm2c_n_i : in    std_logic;  -- Mezzanine present (active low)
    fmc1_prsntm2c_n_i : in    std_logic;  -- Mezzanine present (active low)

    ----------------------------------------
    -- Put the FMC I/Os here
    ----------------------------------------

    fmc0_dio_clk_p_i : in std_logic;
    fmc0_dio_clk_n_i : in std_logic;

    fmc0_dio_n_i : in std_logic_vector(4 downto 0);
    fmc0_dio_p_i : in std_logic_vector(4 downto 0);

    fmc0_dio_n_o : out std_logic_vector(4 downto 0);
    fmc0_dio_p_o : out std_logic_vector(4 downto 0);

    fmc0_dio_oe_n_o    : out std_logic_vector(4 downto 0);
    fmc0_dio_term_en_o : out std_logic_vector(4 downto 0);

    fmc0_dio_onewire_b  : inout std_logic;
    fmc0_dio_sdn_n_o    : out   std_logic;
    fmc0_dio_sdn_ck_n_o : out   std_logic;

    fmc0_dio_led_top_o : out std_logic;
    fmc0_dio_led_bot_o : out std_logic;

    fmc1_dio_clk_p_i : in std_logic;
    fmc1_dio_clk_n_i : in std_logic;

    fmc1_dio_n_i : in std_logic_vector(4 downto 0);
    fmc1_dio_p_i : in std_logic_vector(4 downto 0);

    fmc1_dio_n_o : out std_logic_vector(4 downto 0);
    fmc1_dio_p_o : out std_logic_vector(4 downto 0);

    fmc1_dio_oe_n_o    : out std_logic_vector(4 downto 0);
    fmc1_dio_term_en_o : out std_logic_vector(4 downto 0);

    fmc1_dio_onewire_b  : inout std_logic;
    fmc1_dio_sdn_n_o    : out   std_logic;
    fmc1_dio_sdn_ck_n_o : out   std_logic;

    fmc1_dio_led_top_o : out std_logic;
    fmc1_dio_led_bot_o : out std_logic

    );
end svec_top;

architecture rtl of svec_top is

------------------------------------------
--        FUNCTIONS DECLARATION 
------------------------------------------
  function f_int_to_bool (x : integer) return boolean is
  begin
    if (x = 0) then
      return false;
    else
      return true;
    end if;
  end function;

  component gmt_pll_wrapper is
    port (
      clk_wr_i  : in  std_logic;
      clk_gmt_o : out std_logic);
  end component gmt_pll_wrapper;
  
  component gmt_converter is
    port (
      clk_sys_i   : in  std_logic;
      clk_wr_i    : in  std_logic;
      clk_40m_i   : in  std_logic;
      rst_n_sys_i : in  std_logic;
      tm_cycles_i : in  std_logic_vector(27 downto 0);
      tm_tai_i    : in  std_logic_vector(31 downto 0);
      tm_valid_i  : in  std_logic;
      gmt_i       : in  std_logic_vector(4 downto 0);
      gmt_o       : out std_logic_vector(4 downto 0);
      pps_gmt_a_i : in  std_logic;
      slave_i     : in  t_wishbone_slave_in;
      slave_o     : out t_wishbone_slave_out);
  end component gmt_converter;

------------------------------------------
--        CONSTANTS DECLARATION  
------------------------------------------

  -- Number of master port(s) on the wishbone crossbar
  constant c_NUM_WB_MASTERS : integer := 3;

  -- Number of slave port(s) on the wishbone crossbar
  constant c_NUM_WB_SLAVES : integer := 3;

  -- Device SDB description
  constant c_D3S_ADC_SDB_DEVICE : t_sdb_device := (
    abi_class     => x"0000",              -- undocumented device
    abi_ver_major => x"01",
    abi_ver_minor => x"00",
    wbd_endian    => c_sdb_endian_big,
    wbd_width     => x"7",                 -- 8/16/32-bit port granularity
    sdb_component => (
      addr_first  => x"0000000000000000",
      addr_last   => x"0000000000001fff",
      product     => (
        vendor_id => x"000000000000CE42",  -- CERN
        device_id => x"dd334410",
        version   => x"00000001",
        date      => x"20160427",
        name      => "WR-D3S-ADC_Core    ")));

  constant c_hmq_config : t_wrn_mqueue_config :=
    (
      out_slot_count  => 4,
      out_slot_config => (
        0             => (width => 128, entries => 8),  -- control CPU 0 (to host)
        1             => (width => 128, entries => 8),  -- control CPU 1 (to host)
        2             => (width => 16, entries => 128),  -- log CPU 0
        3             => (width => 16, entries => 128),  -- log CPU 1
        others        => (0, 0)),

      in_slot_count  => 2,
      in_slot_config => (
        0            => (width => 32, entries => 8),  -- control CPU 0 (from host)
        1            => (width => 32, entries => 8),  -- control CPU 1 (from host)
        others       => (0, 0)
        )
      );

  constant c_rmq_config : t_wrn_mqueue_config :=
    (
      out_slot_count  => 2,
      out_slot_config => (
        0             => (width => 128, entries => 16),  -- RF stream (CPU0)
        1             => (width => 128, entries => 16),  -- Events (CPU1)
        others        => (0, 0)),

      in_slot_count  => 2,
      in_slot_config => (
        0            => (width => 128, entries => 16),  -- RF stream (CPU0)
        1            => (width => 128, entries => 16),  -- Events (CPU1)
        others       => (0, 0)
        )
      );

  
  constant c_node_config : t_wr_node_config :=
    (
      app_id          => x"337c07e1",
      cpu_count       => 2,
      cpu_memsizes    => (32768, 32768, 0, 0, 0, 0, 0, 0),
      hmq_config      => c_hmq_config,
      rmq_config      => c_rmq_config,
      shared_mem_size => 8192
      );


  -- Wishbone slave(s)

  constant c_d3s0_sdb_record : t_sdb_record       := f_sdb_embed_device(c_D3S_ADC_SDB_DEVICE, x"00010000");
  constant c_d3s1_sdb_record : t_sdb_record       := f_sdb_embed_device(c_D3S_ADC_SDB_DEVICE, x"00012000");
  constant c_d3s_vector      : t_wishbone_address := x"ffffffff";

------------------------------------------
--        SIGNALS DECLARATION  
------------------------------------------

  signal clk_sys : std_logic;
  signal rst_n   : std_logic;

  signal fmc_host_wb_out, fmc_dp_wb_out : t_wishbone_master_out_array(0 to c_NUM_WB_MASTERS-1);
  signal fmc_host_wb_in, fmc_dp_wb_in   : t_wishbone_master_in_array(0 to c_NUM_WB_MASTERS-1);
  signal fmc_host_irq                   : std_logic_vector(c_NUM_WB_MASTERS downto 0);

  signal tm_link_up         : std_logic;
  signal tm_dac_value       : std_logic_vector(23 downto 0);
  signal tm_dac_wr          : std_logic_vector(1 downto 0);
  signal tm_clk_aux_lock_en : std_logic_vector(1 downto 0) := (others => '0');
  signal tm_clk_aux_locked  : std_logic_vector(1 downto 0);
  signal tm_time_valid      : std_logic;
  signal tm_tai             : std_logic_vector(39 downto 0);
  signal tm_cycles          : std_logic_vector(27 downto 0);


  signal fmc0_clk_wr, fmc1_clk_wr : std_logic;

  signal debug : std_logic_vector(3 downto 0);

  signal fmc_wb_muxed_out : t_wishbone_master_out_array(c_NUM_WB_SLAVES-1 downto 0);
  signal fmc_wb_muxed_in  : t_wishbone_master_in_array(c_NUM_WB_SLAVES-1 downto 0);

  signal scl_pad_oen, sda_pad_oen : std_logic;
  signal clk_125m_pllref          : std_logic;

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
  signal CLK     : std_logic;
  signal TRIG0   : std_logic_vector(31 downto 0);
  signal TRIG1   : std_logic_vector(31 downto 0);
  signal TRIG2   : std_logic_vector(31 downto 0);
  signal TRIG3   : std_logic_vector(31 downto 0);

  signal fmc0_dio_in  : std_logic_vector(4 downto 0);
  signal fmc0_dio_out : std_logic_vector(4 downto 0);
  signal fmc1_dio_in  : std_logic_vector(4 downto 0);
  signal fmc1_dio_out : std_logic_vector(4 downto 0);

  signal clk_gmt : std_logic;
  
begin

  --chipscope_icon_1: chipscope_icon
  --  port map (
  --    CONTROL0 => CONTROL);

  --chipscope_ila_1: chipscope_ila
  --  port map (
  --    CONTROL => CONTROL,
  --    CLK     => clk_sys,
  --    TRIG0   => TRIG0,
  --    TRIG1   => TRIG1,
  --    TRIG2   => TRIG2,
  --    TRIG3   => TRIG3);
  
  U_Node_Template : svec_node_template
    generic map (
      g_fmc0_sdb                 => c_d3s0_sdb_record,
      g_fmc0_vic_vector          => c_d3s_vector,
      g_fmc1_sdb                 => c_d3s1_sdb_record,
      g_fmc1_vic_vector          => c_d3s_vector,
      g_simulation               => g_simulation,
      g_with_wr_phy              => true,
      g_double_wrnode_core_clock => false,
      g_wr_node_config           => c_node_config)
    port map (
      rst_n_a_i           => rst_n_a_i,
      rst_n_sys_o         => rst_n,
      clk_sys_o           => clk_sys,  -- system clock output for user design, 62.5 MHz
      clk_20m_vcxo_i      => clk_20m_vcxo_i,
      clk_125m_pllref_p_i => clk_125m_pllref_p_i,
      clk_125m_pllref_n_i => clk_125m_pllref_n_i,
      clk_125m_gtp_p_i    => clk_125m_gtp_p_i,
      clk_125m_gtp_n_i    => clk_125m_gtp_n_i,
      clk_125m_pllref_o   => clk_125m_pllref,
      fp_led_line_oen_o   => fp_led_line_oen_o,
      fp_led_line_o       => fp_led_line_o,
      fp_led_column_o     => fp_led_column_o,


--fp_gpio1_a2b_o      => fp_gpio1_a2b_o,
      --fp_gpio2_a2b_o      => fp_gpio2_a2b_o,
      --fp_gpio34_a2b_o     => fp_gpio34_a2b_o,
      --fp_gpio1_b          => fp_gpio1_b,
      --fp_gpio2_b          => fp_gpio2_b,
      --fp_gpio3_b          => fp_gpio3_b,
      --fp_gpio4_b          => fp_gpio4_b,
      VME_AS_n_i        => VME_AS_n_i,
      VME_RST_n_i       => VME_RST_n_i,
      VME_WRITE_n_i     => VME_WRITE_n_i,
      VME_AM_i          => VME_AM_i,
      VME_DS_n_i        => VME_DS_n_i,
      VME_GA_i          => VME_GA_i,
      VME_BERR_o        => VME_BERR_o,
      VME_DTACK_n_o     => VME_DTACK_n_o,
      VME_RETRY_n_o     => VME_RETRY_n_o,
      VME_RETRY_OE_o    => VME_RETRY_OE_o,
      VME_LWORD_n_b     => VME_LWORD_n_b,
      VME_ADDR_b        => VME_ADDR_b,
      VME_DATA_b        => VME_DATA_b,
      VME_BBSY_n_i      => VME_BBSY_n_i,
      VME_IRQ_n_o       => VME_IRQ_n_o,
      VME_IACK_n_i      => VME_IACK_n_i,
      VME_IACKIN_n_i    => VME_IACKIN_n_i,
      VME_IACKOUT_n_o   => VME_IACKOUT_n_o,
      VME_DTACK_OE_o    => VME_DTACK_OE_o,
      VME_DATA_DIR_o    => VME_DATA_DIR_o,
      VME_DATA_OE_N_o   => VME_DATA_OE_N_o,
      VME_ADDR_DIR_o    => VME_ADDR_DIR_o,
      VME_ADDR_OE_N_o   => VME_ADDR_OE_N_o,
      sfp_txp_o         => sfp_txp_o,
      sfp_txn_o         => sfp_txn_o,
      sfp_rxp_i         => sfp_rxp_i,
      sfp_rxn_i         => sfp_rxn_i,
      sfp_mod_def0_b    => sfp_mod_def0_b,
      sfp_mod_def1_b    => sfp_mod_def1_b,
      sfp_mod_def2_b    => sfp_mod_def2_b,
      sfp_rate_select_b => sfp_rate_select_b,
      sfp_tx_fault_i    => sfp_tx_fault_i,
      sfp_tx_disable_o  => sfp_tx_disable_o,
      sfp_los_i         => sfp_los_i,
      pll20dac_din_o    => pll20dac_din_o,
      pll20dac_sclk_o   => pll20dac_sclk_o,
      pll20dac_sync_n_o => pll20dac_sync_n_o,
      pll25dac_din_o    => pll25dac_din_o,
      pll25dac_sclk_o   => pll25dac_sclk_o,
      pll25dac_sync_n_o => pll25dac_sync_n_o,

      scl_afpga_b => scl_afpga_b,
      sda_afpga_b => sda_afpga_b,

      fmc0_prsntm2c_n_i => fmc0_prsntm2c_n_i,
      fmc1_prsntm2c_n_i => fmc1_prsntm2c_n_i,

      tempid_dq_b => tempid_dq_b,
      uart_rxd_i  => uart_rxd_i,
      uart_txd_o  => uart_txd_o,

      fmc0_clk_aux_i  => fmc0_clk_wr,
      fmc0_host_wb_o  => fmc_host_wb_out(0),
      fmc0_host_wb_i  => fmc_host_wb_in(0),
      fmc0_host_irq_i => fmc_host_irq(0),
      fmc0_dp_wb_o    => fmc_dp_wb_out(0),
      fmc0_dp_wb_i    => fmc_dp_wb_in(0),

      fmc1_clk_aux_i  => fmc1_clk_wr,
      fmc1_host_wb_o  => fmc_host_wb_out(1),
      fmc1_host_wb_i  => fmc_host_wb_in(1),
      fmc1_host_irq_i => fmc_host_irq(1),
      fmc1_dp_wb_o    => fmc_dp_wb_out(1),
      fmc1_dp_wb_i    => fmc_dp_wb_in(1),

      tm_link_up_o         => tm_link_up,
      tm_dac_value_o       => tm_dac_value,
      tm_dac_wr_o          => tm_dac_wr,
      tm_clk_aux_lock_en_i => tm_clk_aux_lock_en,
      tm_clk_aux_locked_o  => tm_clk_aux_locked,
      tm_time_valid_o      => tm_time_valid,
      tm_tai_o             => tm_tai,
      tm_cycles_o          => tm_cycles
      );


  U_GMT_Clock_Gen: gmt_pll_wrapper
    port map (
      clk_wr_i  => clk_125m_pllref,
      clk_gmt_o => clk_gmt);
  
  U_GMT_Converter : gmt_converter
    port map (
      clk_sys_i   => clk_sys,
      clk_wr_i    => clk_125m_pllref,
      clk_40m_i   => clk_gmt,
      rst_n_sys_i => rst_n,
      tm_cycles_i => tm_cycles,
      tm_tai_i    => tm_tai(31 downto 0),
      tm_valid_i  => tm_time_valid,
      gmt_i       => fmc0_dio_in,
      gmt_o       => fmc1_dio_out,
      pps_gmt_a_i => fp_gpio1_b,
      slave_i     => fmc_dp_wb_out(0),
      slave_o     => fmc_dp_wb_in(0));

  fmc_dp_wb_in(1).ack   <= '1';
  fmc_dp_wb_in(1).err   <= '0';
  fmc_dp_wb_in(1).stall <= '0';
  fmc_dp_wb_in(1).rty   <= '0';

  fmc_host_wb_in(0).ack   <= '1';
  fmc_host_wb_in(0).err   <= '0';
  fmc_host_wb_in(0).stall <= '0';
  fmc_host_wb_in(0).rty   <= '0';

  fmc_host_wb_in(1).ack   <= '1';
  fmc_host_wb_in(1).err   <= '0';
  fmc_host_wb_in(1).stall <= '0';
  fmc_host_wb_in(1).rty   <= '0';

  gen_dio0_iobufs : for i in 0 to 4 generate
    U_ibuf : IBUFDS
      generic map (
        DIFF_TERM => true)
      port map (
        O  => fmc0_dio_in(i),
        I  => fmc0_dio_p_i(i),
        IB => fmc0_dio_n_i(i)
        );

    U_obuf : OBUFDS
      port map (
        I  => fmc0_dio_out(i),
        O  => fmc0_dio_p_o(i),
        OB => fmc0_dio_n_o(i)
        );
  end generate gen_dio0_iobufs;

  gen_dio1_iobufs : for i in 0 to 4 generate
    U_ibuf : IBUFDS
      generic map (
        DIFF_TERM => true)
      port map (
        O  => fmc1_dio_in(i),
        I  => fmc1_dio_p_i(i),
        IB => fmc1_dio_n_i(i)
        );

    U_obuf : OBUFDS
      port map (
        I  => fmc1_dio_out(i),
        O  => fmc1_dio_p_o(i),
        OB => fmc1_dio_n_o(i)
        );
  end generate gen_dio1_iobufs;

  U_extclk1_buffer : IBUFGDS
    generic map (
      DIFF_TERM => true)
    port map (
      O  => open,
      I  => fmc0_dio_clk_p_i,
      IB => fmc0_dio_clk_n_i
      );

  U_extclk2_buffer : IBUFGDS
    generic map (
      DIFF_TERM => true)
    port map (
      O  => open,
      I  => fmc1_dio_clk_p_i,
      IB => fmc1_dio_clk_n_i
      );

  fp_gpio1_a2b_o  <= '0';  -- svec front panel LEMO L2 set as input
  fp_gpio2_a2b_o  <= '0';  -- svec front panel LEMO L1 set as input
  fp_gpio34_a2b_o <= '0';  -- svec front panel LEMOs L3 and L4 set as input

  fp_gpio1_term_en_o <= '1';
  fp_gpio2_term_en_o <= '1';
  fp_gpio3_term_en_o <= '1';
  fp_gpio4_term_en_o <= '1';

  fmc0_dio_oe_n_o    <= (others => '1');  -- FMC0: all inputs, all 50 ohm
  fmc0_dio_term_en_o <= (others => '1');

  fmc0_dio_sdn_n_o    <= '1';
  fmc0_dio_sdn_ck_n_o <= '1';

  fmc0_dio_led_top_o <= '0';
  fmc0_dio_led_bot_o <= '0';

  fmc1_dio_oe_n_o    <= (others => '0');  -- FMC1: all outputs, no parallel termination
  fmc1_dio_term_en_o <= (others => '0');

  fmc1_dio_sdn_n_o    <= '1';
  fmc1_dio_sdn_ck_n_o <= '1';

  fmc1_dio_led_top_o <= '0';
  fmc1_dio_led_bot_o <= '0';

end rtl;



