-------------------------------------------------------------------------------
-- Title      : Mock Turtle Core template design for the SVEC carrier
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : svec_node_template.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-04-26
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Shared part of a typical WR node for the SVEC carrier. Contains pre-configured:
-- - WR PTP Core
-- - Mock Turtle Core
-- - Wishbone interfaces for two mezzanines. This is indented for connecting
--   FmcTdc/FmcDelay in various combinations, but not limited to these cards.
-- Just instantiate this in the top level of your SVEC (see list_tdc_fd
-- project), replacing the FineDelay/TDC mezzanines with any cores you want,
-- synthesize and play!
-------------------------------------------------------------------------------
--
-- Copyright (c) 2014-2015 CERN
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
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

use work.svec_node_pkg.all;
use work.wishbone_pkg.all;
use work.wr_fabric_pkg.all;
use work.xvme64x_core_pkg.all;
use work.mock_turtle_pkg.all;
use work.gencores_pkg.all;
use work.wrcore_pkg.all;
use work.wr_xilinx_pkg.all;

library unisim;
use unisim.vcomponents.all;

entity svec_node_template is
  generic (
-- SDB record of the mezzanine connected to slot 0
    g_fmc0_sdb        : t_sdb_record;
-- VIC interrupt vector address of the mezzanine in slot 0
    g_fmc0_vic_vector : t_wishbone_address;
-- SDB record of the mezzanine connected to slot 1
    g_fmc1_sdb        : t_sdb_record;
-- VIC interrupt vector address of the mezzanine in slot 1
    g_fmc1_vic_vector : t_wishbone_address;

-- Enables/disable White Rabbit support
    g_with_white_rabbit : boolean := true;

-- Reduces some timeouts to speed up simulations.
    g_simulation : boolean := false;

-- Enable/disable instantiation of the gigabit transceiver core.
-- Speeds up the simulations a lot.
    g_with_wr_phy : boolean := false;

-- When true, the CPUs in the WR node run at 125 MHz (twice the
-- 62.5 MHz system clock). May not meet the timing for heavily
-- congested designs.
    g_double_mt_core_clock : boolean := false;

-- Configuration of the Mock Turtle Core. Fill in according to your needs.
    g_mock_turtle_config : t_mock_turtle_config;

-- Use external LEDs. When true, the front panel LEDs on the SVEC are
-- driven by the "led_state_i" signal. Otherwise, they display the default
-- board status (WR Link, timing, etc.)
    g_use_external_fp_leds : boolean := false;
    g_bypass_vme_core : boolean := false
    );

  port (
    rst_n_a_i   : in  std_logic;
    rst_n_sys_o : out std_logic;
    clk_sys_o   : out std_logic;

    -------------------------------------------------------------------------
    -- Standard SVEC ports (Gennum bridge, LEDS, Etc. Do not modify
    -------------------------------------------------------------------------

    clk_20m_vcxo_i : in std_logic;      -- 20MHz VCXO clock

    clk_125m_pllref_p_i : in std_logic;  -- 125 MHz PLL reference
    clk_125m_pllref_n_i : in std_logic;

    clk_125m_gtp_p_i : in std_logic;    -- 125 MHz PLL reference
    clk_125m_gtp_n_i : in std_logic;

    clk_125m_pllref_o : out std_logic;

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

    scl_afpga_b : inout std_logic;
    sda_afpga_b : inout std_logic;

    fmc0_prsntm2c_n_i : in std_logic;
    fmc1_prsntm2c_n_i : in std_logic;

    tempid_dq_b : inout std_logic;

    uart_rxd_i : in  std_logic := '1';
    uart_txd_o : out std_logic;

    -------------------------------------------------------------------------
    -- FMC <> WRNode interface (FMC slot 1)
    -------------------------------------------------------------------------

    -- aux clock for WR core to lock-
    fmc0_clk_aux_i  : in  std_logic;
    -- host Wishbone bus (i.e. for the device driver to access the mezzanine regs)
    fmc0_host_wb_o  : out t_wishbone_master_out;
    fmc0_host_wb_i  : in  t_wishbone_master_in;
    -- DP0 port of WR Node CPU 0
    fmc0_dp_wb_o    : out t_wishbone_master_out;
    fmc0_dp_wb_i    : in  t_wishbone_master_in;
    -- host interrupt line
    fmc0_host_irq_i : in  std_logic;

    -------------------------------------------------------------------------
    -- FMC <> WRNode interface (FMC slot 2)
    -------------------------------------------------------------------------

    fmc1_clk_aux_i  : in  std_logic;
    fmc1_host_wb_o  : out t_wishbone_master_out;
    fmc1_host_wb_i  : in  t_wishbone_master_in;
    fmc1_dp_wb_o    : out t_wishbone_master_out;
    fmc1_dp_wb_i    : in  t_wishbone_master_in;
    fmc1_host_irq_i : in  std_logic;

    -------------------------------------------------------------------------
    -- Misc WRNode signals
    -------------------------------------------------------------------------

    -- Shared Peripheral port
    sp_master_o : out t_wishbone_master_out;
    sp_master_i : in  t_wishbone_master_in := cc_dummy_master_in;

    -------------------------------------------------------------------------
    -- WR Core timing interface.
    -------------------------------------------------------------------------

    tm_link_up_o         : out std_logic;
    tm_dac_value_o       : out std_logic_vector(23 downto 0);
    tm_dac_wr_o          : out std_logic_vector(1 downto 0);
    tm_clk_aux_lock_en_i : in  std_logic_vector(1 downto 0) := (others => '0');
    tm_clk_aux_locked_o  : out std_logic_vector(1 downto 0);
    tm_time_valid_o      : out std_logic;
    tm_tai_o             : out std_logic_vector(39 downto 0);
    tm_cycles_o          : out std_logic_vector(27 downto 0);

    pps_o       : out std_logic;
    led_state_i : in  std_logic_vector(15 downto 0)
    -- synthesis translate_off
    ;
    sim_wb_i : in t_wishbone_slave_in;
    sim_wb_o : out t_wishbone_slave_out
    -- synthesis translate_on
    );

end svec_node_template;

architecture rtl of svec_node_template is

  component spec_serial_dac
    generic (
      g_num_data_bits  : integer;
      g_num_extra_bits : integer;
      g_num_cs_select  : integer);
    port (
      clk_i         : in  std_logic;
      rst_n_i       : in  std_logic;
      value_i       : in  std_logic_vector(g_num_data_bits-1 downto 0);
      cs_sel_i      : in  std_logic_vector(g_num_cs_select-1 downto 0);
      load_i        : in  std_logic;
      sclk_divsel_i : in  std_logic_vector(2 downto 0);
      dac_cs_n_o    : out std_logic_vector(g_num_cs_select-1 downto 0);
      dac_sclk_o    : out std_logic;
      dac_sdata_o   : out std_logic;
      xdone_o       : out std_logic);
  end component;

  component bicolor_led_ctrl
    generic (
      g_NB_COLUMN    : natural;
      g_NB_LINE      : natural;
      g_CLK_FREQ     : natural;
      g_REFRESH_RATE : natural);
    port (
      rst_n_i         : in  std_logic;
      clk_i           : in  std_logic;
      led_intensity_i : in  std_logic_vector(6 downto 0);
      led_state_i     : in  std_logic_vector((g_NB_LINE * g_NB_COLUMN * 2) - 1 downto 0);
      column_o        : out std_logic_vector(g_NB_COLUMN - 1 downto 0);
      line_o          : out std_logic_vector(g_NB_LINE - 1 downto 0);
      line_oen_o      : out std_logic_vector(g_NB_LINE - 1 downto 0));
  end component;

  signal VME_DATA_b_out                                        : std_logic_vector(31 downto 0);
  signal VME_ADDR_b_out                                        : std_logic_vector(31 downto 1);
  signal VME_LWORD_n_b_out, VME_DATA_DIR_int, VME_ADDR_DIR_int : std_logic;

  signal dac_hpll_load_p1 : std_logic;
  signal dac_dpll_load_p1 : std_logic;
  signal dac_hpll_data    : std_logic_vector(15 downto 0);
  signal dac_dpll_data    : std_logic_vector(15 downto 0);

  signal phy_tx_data      : std_logic_vector(7 downto 0);
  signal phy_tx_k         : std_logic_vector(0 downto 0);
  signal phy_tx_disparity : std_logic;
  signal phy_tx_enc_err   : std_logic;
  signal phy_rx_data      : std_logic_vector(7 downto 0);
  signal phy_rx_rbclk     : std_logic;
  signal phy_rx_k         : std_logic_vector(0 downto 0);
  signal phy_rx_enc_err   : std_logic;
  signal phy_rx_bitslide  : std_logic_vector(3 downto 0);
  signal phy_rst          : std_logic;
  signal phy_loopen       : std_logic;

  constant c_WRCORE_BRIDGE_SDB : t_sdb_bridge := f_xwb_bridge_manual_sdb(x"0003ffff", x"00030000");

  impure function f_pick_wr_core_sdb return t_sdb_record is
  begin
    if g_with_white_rabbit then
      return f_sdb_embed_bridge (c_WRCORE_BRIDGE_SDB, x"00040000");
    else
      return f_sdb_embed_device (cc_dummy_sdb_device, x"00040000");
    end if;
  end function;

  constant c_NUM_WB_MASTERS : integer := 5;
  constant c_NUM_WB_SLAVES  : integer := 1;

  constant c_MASTER_VME : integer := 0;

  constant c_SLAVE_FMC0     : integer := 0;
  constant c_SLAVE_FMC1     : integer := 1;
  constant c_SLAVE_WR_CORE  : integer := 3;
  constant c_SLAVE_WR_NODE  : integer := 4;
  constant c_SLAVE_VIC      : integer := 2;
  constant c_DESC_SYNTHESIS : integer := 5;
  constant c_DESC_REPO_URL  : integer := 6;


  constant c_INTERCONNECT_LAYOUT : t_sdb_record_array(c_NUM_WB_MASTERS - 1 downto 0) :=
    (
      c_SLAVE_FMC0    => g_fmc0_sdb,
      c_SLAVE_FMC1    => g_fmc1_sdb,
      c_SLAVE_VIC     => f_sdb_embed_device(c_xwb_vic_sdb, x"00002000"),
      c_SLAVE_WR_CORE => f_pick_wr_core_sdb,
      c_SLAVE_WR_NODE => f_sdb_embed_device(c_mock_turtle_sdb, x"00020000")
--      c_DESC_SYNTHESIS => f_sdb_embed_synthesis(c_sdb_synthesis_info),
--      c_DESC_REPO_URL  => f_sdb_embed_repo_url(c_sdb_repo_url)
      );

  constant c_SDB_ADDRESS      : t_wishbone_address := x"00000000";
  constant c_VIC_VECTOR_TABLE : t_wishbone_address_array(0 to 3) :=
    (0 => g_fmc0_vic_vector,
     1 => g_fmc1_vic_vector,
     2 => x"00020000",                  -- WRNC Mqueue interrupt
     3 => x"00020001"                   -- WRNC Debug Msg interrupt
     );

  signal cnx_master_out : t_wishbone_master_out_array(c_NUM_WB_MASTERS-1 downto 0);
  signal cnx_master_in  : t_wishbone_master_in_array(c_NUM_WB_MASTERS-1 downto 0);

  signal cnx_slave_out : t_wishbone_slave_out_array(c_NUM_WB_SLAVES-1 downto 0);
  signal cnx_slave_in  : t_wishbone_slave_in_array(c_NUM_WB_SLAVES-1 downto 0);

  signal wrn_fmc0_wb_out, wrn_fmc1_wb_out, wrc_aux_master_out : t_wishbone_master_out;
  signal wrn_fmc0_wb_in, wrn_fmc1_wb_in, wrc_aux_master_in    : t_wishbone_master_in;

  signal tm_link_up         : std_logic;
  signal tm_tai             : std_logic_vector(39 downto 0);
  signal tm_cycles          : std_logic_vector(27 downto 0);
  signal tm_time_valid      : std_logic;
  signal tm_clk_aux_lock_en : std_logic_vector(1 downto 0);
  signal tm_clk_aux_locked  : std_logic_vector(1 downto 0);
  signal tm_dac_value       : std_logic_vector(23 downto 0);
  signal tm_dac_wr          : std_logic_vector(1 downto 0);


  signal wrc_scl_out, wrc_scl_in, wrc_sda_out, wrc_sda_in : std_logic;
  signal sfp_scl_out, sfp_scl_in, sfp_sda_out, sfp_sda_in : std_logic;
  signal wrc_owr_en, wrc_owr_in                           : std_logic_vector(1 downto 0);

  signal pllout_clk_sys       : std_logic;
  signal pllout_clk_cpu       : std_logic;
  signal pllout_clk_dmtd      : std_logic;
  signal pllout_clk_fb_pllref : std_logic;
  signal pllout_clk_fb_dmtd   : std_logic;

  signal clk_20m_vcxo_buf : std_logic;
  signal clk_125m_pllref  : std_logic;
  signal clk_125m_gtp     : std_logic;
  signal clk_sys          : std_logic;
  signal clk_cpu          : std_logic;
  signal clk_dmtd         : std_logic;

  signal local_reset_n : std_logic;
  signal wrn_irq       : std_logic;


  signal pins : std_logic_vector(31 downto 0);
  signal pps  : std_logic;

  signal vic_master_irq : std_logic;

  function f_bool2int (x : boolean) return integer is
  begin
    if(x) then
      return 1;
    else
      return 0;
    end if;
  end f_bool2int;

  function f_resize_slv (x : std_logic_vector; len : integer) return std_logic_vector is
    variable tmp : std_logic_vector(len-1 downto 0);
  begin
    if(len > x'length) then
      tmp(x'length-1 downto 0)   := x;
      tmp(len-1 downto x'length) := (others => '0');
    elsif(len < x'length) then
      tmp := x(len-1 downto 0);
    else
      tmp := x;
    end if;
    return tmp;
  end f_resize_slv;

  signal ebm_src_out : t_wrf_source_out;
  signal ebm_src_in  : t_wrf_source_in;
  signal ebs_snk_in  : t_wrf_sink_in;
  signal ebs_snk_out : t_wrf_sink_out;

  attribute buffer_type                    : string;  --" {bufgdll | ibufg | bufgp | ibuf | bufr | none}";
  attribute buffer_type of clk_125m_pllref : signal is "BUFG";

  attribute keep                    : string;
  attribute keep of clk_125m_pllref : signal is "TRUE";
  attribute keep of clk_sys         : signal is "TRUE";
  attribute keep of clk_cpu         : signal is "TRUE";
  attribute keep of phy_rx_rbclk    : signal is "TRUE";
  attribute keep of clk_dmtd        : signal is "TRUE";

  signal powerup_reset_cnt : unsigned(7 downto 0) := "00000000";
  signal powerup_rst_n     : std_logic            := '0';
  signal sys_locked        : std_logic;

  signal led_state        : std_logic_vector(15 downto 0);
  signal pps_led, pps_ext : std_logic;

  signal led_link   : std_logic;
  signal led_act    : std_logic;
  signal vme_access : std_logic;

  signal tm                        : t_mt_timing_if;
  signal wrn_gpio_out, wrn_gpio_in : std_logic_vector(31 downto 0);
  signal rst_net_n                 : std_logic;
  signal wrn_debug_msg_irq         : std_logic;
  
begin


  U_Buf_CLK_GTP : IBUFDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_125m_gtp,
      I  => clk_125m_gtp_p_i,
      IB => clk_125m_gtp_n_i
      );

  U_Buf_CLK_PLL : IBUFGDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => true  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_125m_pllref,            -- Buffer output
      I  => clk_125m_pllref_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => clk_125m_pllref_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

  clk_125m_pllref_o <= clk_125m_pllref;

  cmp_sys_clk_pll : PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLK_FEEDBACK       => "CLKFBOUT",
      COMPENSATION       => "INTERNAL",
      DIVCLK_DIVIDE      => 1,
      CLKFBOUT_MULT      => 8,
      CLKFBOUT_PHASE     => 0.000,
      CLKOUT0_DIVIDE     => 16,         -- 62.5 MHz
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
      CLKOUT1_DIVIDE     => 8,          -- 125 MHz
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
--      CLKOUT2_DIVIDE     => 16,
--      CLKOUT2_PHASE      => 0.000,
--      CLKOUT2_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 8.0,
      REF_JITTER         => 0.016)
    port map (
      CLKFBOUT => pllout_clk_fb_pllref,
      CLKOUT0  => pllout_clk_sys,
      CLKOUT1  => pllout_clk_cpu,
      CLKOUT2  => open,
      CLKOUT3  => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => sys_locked,
      RST      => '0',
      CLKFBIN  => pllout_clk_fb_pllref,
      CLKIN    => clk_125m_pllref);

  cmp_dmtd_clk_pll : PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLK_FEEDBACK       => "CLKFBOUT",
      COMPENSATION       => "INTERNAL",
      DIVCLK_DIVIDE      => 1,
      CLKFBOUT_MULT      => 50,
      CLKFBOUT_PHASE     => 0.000,
      CLKOUT0_DIVIDE     => 16,         -- 62.5 MHz
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
--      CLKOUT1_DIVIDE     => 16,         -- 62.5 MHz
--      CLKOUT1_PHASE      => 0.000,
--      CLKOUT1_DUTY_CYCLE => 0.500,
--      CLKOUT2_DIVIDE     => 8,
--      CLKOUT2_PHASE      => 0.000,
--      CLKOUT2_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 50.0,
      REF_JITTER         => 0.016)
    port map (
      CLKFBOUT => pllout_clk_fb_dmtd,
      CLKOUT0  => pllout_clk_dmtd,
      CLKOUT1  => open,                 --pllout_clk_sys,
      CLKOUT2  => open,
      CLKOUT3  => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => open,
      RST      => '0',
      CLKFBIN  => pllout_clk_fb_dmtd,
      CLKIN    => clk_20m_vcxo_buf);

  
  p_powerup_reset : process(clk_sys)
  begin
    if rising_edge(clk_sys) then
      if(VME_RST_n_i = '0' or rst_n_a_i = '0') then
        powerup_rst_n <= '0';
      elsif sys_locked = '1' then
        if(powerup_reset_cnt = "11111111") then
          powerup_rst_n <= '1';
        else
          powerup_rst_n     <= '0';
          powerup_reset_cnt <= powerup_reset_cnt + 1;
        end if;
      else
        powerup_rst_n     <= '0';
        powerup_reset_cnt <= "00000000";
      end if;
    end if;
  end process;

--  rst_n_a <= VME_RST_n_i and rst_n_i;
  U_Sync_Reset : gc_sync_ffs
    port map (
      clk_i    => clk_sys,
      rst_n_i  => '1',
      data_i   => powerup_rst_n,
      synced_o => local_reset_n);

  cmp_clk_sys_buf : BUFG
    port map (
      O => clk_sys,
      I => pllout_clk_sys);

  cmp_clk_cpu_buf : BUFG
    port map (
      O => clk_cpu,
      I => pllout_clk_cpu);

  cmp_clk_dmtd_buf : BUFG
    port map (
      O => clk_dmtd,
      I => pllout_clk_dmtd);

  cmp_clk_vcxo : BUFG
    port map (
      O => clk_20m_vcxo_buf,
      I => clk_20m_vcxo_i);

  gen_with_vme64_core : if not g_bypass_vme_core generate
  
  U_VME_Core : xvme64x_core
    generic map (
      g_adem_a24 => x"fff80000")
    port map (
      clk_i           => clk_sys,
      rst_n_i         => powerup_rst_n,
      VME_AS_n_i      => VME_AS_n_i,
      VME_RST_n_i     => powerup_rst_n,
      VME_WRITE_n_i   => VME_WRITE_n_i,
      VME_AM_i        => VME_AM_i,
      VME_DS_n_i      => VME_DS_n_i,
      VME_GA_i        => VME_GA_i,
      VME_BERR_o      => VME_BERR_o,
      VME_DTACK_n_o   => VME_DTACK_n_o,
      VME_RETRY_n_o   => VME_RETRY_n_o,
      VME_RETRY_OE_o  => VME_RETRY_OE_o,
      VME_LWORD_n_b_i => VME_LWORD_n_b,
      VME_LWORD_n_b_o => VME_LWORD_n_b_out,
      VME_ADDR_b_i    => VME_ADDR_b,
      VME_DATA_b_o    => VME_DATA_b_out,
      VME_ADDR_b_o    => VME_ADDR_b_out,
      VME_DATA_b_i    => VME_DATA_b,
      VME_IRQ_n_o     => VME_IRQ_n_o,
      VME_IACK_n_i    => VME_IACK_n_i,
      VME_IACKIN_n_i  => VME_IACKIN_n_i,
      VME_IACKOUT_n_o => VME_IACKOUT_n_o,
      VME_DTACK_OE_o  => VME_DTACK_OE_o,
      VME_DATA_DIR_o  => VME_DATA_DIR_int,
      VME_DATA_OE_N_o => VME_DATA_OE_N_o,
      VME_ADDR_DIR_o  => VME_ADDR_DIR_int,
      VME_ADDR_OE_N_o => VME_ADDR_OE_N_o,
      master_o        => cnx_slave_in(c_MASTER_VME),
      master_i        => cnx_slave_out(c_MASTER_VME),
      irq_i           => vic_master_irq);

  VME_DATA_b    <= VME_DATA_b_out    when VME_DATA_DIR_int = '1' else (others => 'Z');
  VME_ADDR_b    <= VME_ADDR_b_out    when VME_ADDR_DIR_int = '1' else (others => 'Z');
  VME_LWORD_n_b <= VME_LWORD_n_b_out when VME_ADDR_DIR_int = '1' else 'Z';

  VME_ADDR_DIR_o <= VME_ADDR_DIR_int;
  VME_DATA_DIR_o <= VME_DATA_DIR_int;

  end generate gen_with_vme64_core;

  gen_without_vme64_core: if g_bypass_vme_core generate
    -- synthesis translate_off
    cnx_slave_in(c_MASTER_VME) <= sim_wb_i;
    sim_wb_o <= cnx_slave_out(c_MASTER_VME);
    -- synthesis translate_on    
  end generate gen_without_vme64_core;
      
  
  gen_with_wr : if(g_with_white_rabbit) generate

    -- Tristates for SFP EEPROM
    sfp_mod_def1_b <= '0' when sfp_scl_out = '0' else 'Z';
    sfp_mod_def2_b <= '0' when sfp_sda_out = '0' else 'Z';
    sfp_scl_in     <= sfp_mod_def1_b;
    sfp_sda_in     <= sfp_mod_def2_b;

    tempid_dq_b   <= '0' when wrc_owr_en(0) = '1' else 'Z';
    wrc_owr_in(0) <= tempid_dq_b;

    -- Tristates for SVEC EEPROM
    scl_afpga_b <= '0' when wrc_scl_out = '0' else 'Z';
    sda_afpga_b <= '0' when wrc_sda_out = '0' else 'Z';
    wrc_scl_in  <= scl_afpga_b;
    wrc_sda_in  <= sda_afpga_b;

    U_WR_CORE : xwr_core
      generic map (
        g_simulation                => f_bool2int(g_simulation),
        g_phys_uart                 => true,
        g_virtual_uart              => true,
        g_with_external_clock_input => false,
        g_aux_clks                  => 2,
        g_interface_mode            => PIPELINED,
        g_address_granularity       => BYTE,
        g_softpll_enable_debugger   => false,
        g_dpram_initf               => "wrc.bram")
      port map (
        clk_sys_i    => clk_sys,
        clk_dmtd_i   => clk_dmtd,
        clk_ref_i    => clk_125m_pllref,
        clk_aux_i(0) => fmc0_clk_aux_i,
        clk_aux_i(1) => fmc1_clk_aux_i,
        rst_n_i      => local_reset_n,

        dac_hpll_load_p1_o => dac_hpll_load_p1,
        dac_hpll_data_o    => dac_hpll_data,
        dac_dpll_load_p1_o => dac_dpll_load_p1,
        dac_dpll_data_o    => dac_dpll_data,

        phy_ref_clk_i      => clk_125m_pllref,
        phy_tx_data_o      => phy_tx_data,
        phy_tx_k_o         => phy_tx_k,
        phy_tx_disparity_i => phy_tx_disparity,
        phy_tx_enc_err_i   => phy_tx_enc_err,
        phy_rx_data_i      => phy_rx_data,
        phy_rx_rbclk_i     => phy_rx_rbclk,
        phy_rx_k_i         => phy_rx_k,
        phy_rx_enc_err_i   => phy_rx_enc_err,
        phy_rx_bitslide_i  => phy_rx_bitslide,
        phy_rst_o          => phy_rst,
        phy_loopen_o       => phy_loopen,

        led_link_o => led_link,
        led_act_o  => led_act,

        scl_o => wrc_scl_out,
        scl_i => wrc_scl_in,
        sda_o => wrc_sda_out,
        sda_i => wrc_sda_in,

        sfp_scl_o => sfp_scl_out,
        sfp_scl_i => sfp_scl_in,
        sfp_sda_o => sfp_sda_out,
        sfp_sda_i => sfp_sda_in,
        sfp_det_i => sfp_mod_def0_b,

        uart_rxd_i => uart_rxd_i,
        uart_txd_o => uart_txd_o,

        owr_en_o => wrc_owr_en,
        owr_i    => wrc_owr_in,

        slave_i => cnx_master_out(c_SLAVE_WR_CORE),
        slave_o => cnx_master_in(c_SLAVE_WR_CORE),


        wrf_src_o => ebs_snk_in,
        wrf_src_i => ebs_snk_out,
        wrf_snk_o => ebm_src_in,
        wrf_snk_i => ebm_src_out,

        btn1_i => '0',
        btn2_i => '0',

        tm_link_up_o         => tm_link_up,
        tm_dac_value_o       => tm_dac_value,
        tm_dac_wr_o          => tm_dac_wr,
        tm_clk_aux_lock_en_i => tm_clk_aux_lock_en,
        tm_clk_aux_locked_o  => tm_clk_aux_locked,
        tm_time_valid_o      => tm_time_valid,
        tm_tai_o             => tm_tai,
        tm_cycles_o          => tm_cycles,

        pps_p_o     => pps,
        pps_led_o   => pps_led
        );

    U_DAC_Helper : spec_serial_dac
      generic map (
        g_num_data_bits  => 16,
        g_num_extra_bits => 8,
        g_num_cs_select  => 1)
      port map (
        clk_i         => clk_sys,
        rst_n_i       => local_reset_n,
        value_i       => dac_hpll_data,
        cs_sel_i      => "1",
        load_i        => dac_hpll_load_p1,
        sclk_divsel_i => "010",
        dac_cs_n_o(0) => pll20dac_sync_n_o,
        dac_sclk_o    => pll20dac_sclk_o,
        dac_sdata_o   => pll20dac_din_o,
        xdone_o       => open);

    U_DAC_Main : spec_serial_dac
      generic map (
        g_num_data_bits  => 16,
        g_num_extra_bits => 8,
        g_num_cs_select  => 1)
      port map (
        clk_i         => clk_sys,
        rst_n_i       => local_reset_n,
        value_i       => dac_dpll_data,
        cs_sel_i      => "1",
        load_i        => dac_dpll_load_p1,
        sclk_divsel_i => "010",
        dac_cs_n_o(0) => pll25dac_sync_n_o,
        dac_sclk_o    => pll25dac_sclk_o,
        dac_sdata_o   => pll25dac_din_o,
        xdone_o       => open);


  end generate gen_with_wr;

  gen_without_wr : if (not g_with_white_rabbit) generate
    cnx_master_in(c_SLAVE_WR_CORE).ack   <= '1';
    cnx_master_in(c_SLAVE_WR_CORE).stall <= '0';
    cnx_master_in(c_SLAVE_WR_CORE).err   <= '0';
    cnx_master_in(c_SLAVE_WR_CORE).rty   <= '0';
  end generate gen_without_wr;


  U_Intercon : xwb_sdb_crossbar
    generic map (
      g_num_masters => c_NUM_WB_SLAVES,
      g_num_slaves  => c_NUM_WB_MASTERS,
      g_registered  => true,
      g_wraparound  => true,
      g_layout      => c_INTERCONNECT_LAYOUT,
      g_sdb_addr    => c_SDB_ADDRESS)
    port map (
      clk_sys_i => clk_sys,
      rst_n_i   => local_reset_n,
      slave_i   => cnx_slave_in,
      slave_o   => cnx_slave_out,
      master_i  => cnx_master_in,
      master_o  => cnx_master_out);

  U_VIC : xwb_vic
    generic map (
      g_interface_mode      => PIPELINED,
      g_address_granularity => BYTE,
      g_num_interrupts      => 4,
      g_init_vectors        => c_VIC_VECTOR_TABLE)
    port map (
      clk_sys_i    => clk_sys,
      rst_n_i      => local_reset_n,
      slave_i      => cnx_master_out(c_SLAVE_VIC),
      slave_o      => cnx_master_in(c_SLAVE_VIC),
      irqs_i(0)    => fmc0_host_irq_i,
      irqs_i(1)    => fmc1_host_irq_i,
      irqs_i(2)    => wrn_irq,
      irqs_i(3)    => wrn_debug_msg_irq,
      irq_master_o => vic_master_irq);


  gen_wr_node_with_white_rabbit : if g_with_white_rabbit generate
    
    U_Mock_Turtle : mock_turtle_core
      generic map (
        g_config            => g_mock_turtle_config,
        g_double_core_clock => g_double_mt_core_clock,
        g_with_rmq          => true,
        g_with_white_rabbit => true)
      port map (
        clk_i           => clk_sys,
        clk_cpu_i       => clk_cpu,
        clk_ref_i       => clk_125m_pllref,
        rst_n_i         => local_reset_n,
        dp_master_o(0)  => fmc0_dp_wb_o,
        dp_master_o(1)  => fmc1_dp_wb_o,
        dp_master_i(0)  => fmc0_dp_wb_i,
        dp_master_i(1)  => fmc1_dp_wb_i,
        wr_src_o        => ebm_src_out,
        wr_src_i        => ebm_src_in,
        wr_snk_o        => ebs_snk_out,
        wr_snk_i        => ebs_snk_in,
        host_slave_i    => cnx_master_out(c_SLAVE_WR_NODE),
        host_slave_o    => cnx_master_in(c_SLAVE_WR_NODE),
        host_irq_o      => wrn_irq,
        tm_i            => tm,
        gpio_o          => wrn_gpio_out,
        gpio_i          => wrn_gpio_in,
        debug_msg_irq_o => wrn_debug_msg_irq
        );

  end generate gen_wr_node_with_white_rabbit;

  gen_wr_node_without_white_rabbit : if not g_with_white_rabbit generate

  end generate gen_wr_node_without_white_rabbit;

  gen_with_phy : if(g_with_wr_phy and g_with_white_rabbit) generate

    U_GTP : wr_gtp_phy_spartan6
      generic map (
        g_enable_ch0 => 0,
        g_enable_ch1 => 1,
        g_simulation => f_bool2int(g_simulation))
      port map (
        gtp_clk_i          => clk_125m_gtp,
        ch0_ref_clk_i      => clk_125m_pllref,
        ch0_tx_data_i      => x"00",
        ch0_tx_k_i         => '0',
        ch0_tx_disparity_o => open,
        ch0_tx_enc_err_o   => open,
        ch0_rx_rbclk_o     => open,
        ch0_rx_data_o      => open,
        ch0_rx_k_o         => open,
        ch0_rx_enc_err_o   => open,
        ch0_rx_bitslide_o  => open,
        ch0_rst_i          => '1',
        ch0_loopen_i       => '0',

        ch1_ref_clk_i      => clk_125m_pllref,
        ch1_tx_data_i      => phy_tx_data,
        ch1_tx_k_i         => phy_tx_k(0),
        ch1_tx_disparity_o => phy_tx_disparity,
        ch1_tx_enc_err_o   => phy_tx_enc_err,
        ch1_rx_data_o      => phy_rx_data,
        ch1_rx_rbclk_o     => phy_rx_rbclk,
        ch1_rx_k_o         => phy_rx_k(0),
        ch1_rx_enc_err_o   => phy_rx_enc_err,
        ch1_rx_bitslide_o  => phy_rx_bitslide,
        ch1_rst_i          => phy_rst,
        ch1_loopen_i       => '0',      --phy_loopen,
        pad_txn0_o         => open,
        pad_txp0_o         => open,
        pad_rxn0_i         => '0',
        pad_rxp0_i         => '0',
        pad_txn1_o         => sfp_txn_o,
        pad_txp1_o         => sfp_txp_o,
        pad_rxn1_i         => sfp_rxn_i,
        pad_rxp1_i         => sfp_rxp_i);

  end generate gen_with_phy;

  gen_without_wr_phy : if not g_with_wr_phy generate
    phy_rx_rbclk <= clk_125m_pllref;
    phy_rx_data <= phy_tx_data;
    phy_rx_k <= phy_tx_k;
    phy_rx_enc_err <= '0';
    phy_rx_bitslide <= (others => '0');
      
  end generate gen_without_wr_phy;
  
  U_LED_Controller : gc_bicolor_led_ctrl
    generic map(
      g_NB_COLUMN    => 4,
      g_NB_LINE      => 2,
      g_CLK_FREQ     => 62500000,       -- in Hz
      g_REFRESH_RATE => 250             -- in Hz
      )
    port map(
      rst_n_i => local_reset_n,
      clk_i   => clk_sys,

      led_intensity_i => "1100100",     -- in %

      led_state_i => led_state,

      column_o   => fp_led_column_o,
      line_o     => fp_led_line_o,
      line_oen_o => fp_led_line_oen_o
      );

  U_Drive_VME_Access_Led : gc_extend_pulse
    generic map (
      g_width => 5000000)
    port map (
      clk_i      => clk_sys,
      rst_n_i    => local_reset_n,
      pulse_i    => cnx_slave_in(c_MASTER_VME).cyc,
      extended_o => vme_access);

  U_Drive_PPS : gc_extend_pulse
    generic map (
      g_width => 5000000)
    port map (
      clk_i      => clk_125m_pllref,
      rst_n_i    => local_reset_n,
      pulse_i    => pps,
      extended_o => pps_ext);

  pps_o <= pps;

  ----------------------------------
  -- WR Node stuff begins here    --
  ----------------------------------

  gen_with_external_leds : if(g_use_external_fp_leds) generate
    led_state <= led_state_i;
  end generate gen_with_external_leds;

  gen_without_external_leds : if(not g_use_external_fp_leds) generate

    -- Drive the front panel LEDs:

    -- LED 1: WR Link status
    led_state(6) <= led_link;
    led_state(7) <= '0';

    -- LED 2: WR Link activity status
    led_state(4) <= led_act;
    led_state(5) <= '0';

    -- LED 3: WR PPS blink
    led_state(2) <= pps_ext;
    led_state(3) <= '0';

    -- LED 4: WR Time validity
    led_state(0) <= tm_time_valid;
    led_state(1) <= '0';

    -- LED 5: VME access
    led_state(14) <= vme_access;
    led_state(15) <= '0';

    -- LED 6: FD0 locked to WR
    led_state(12) <= tm_clk_aux_locked(0);
    led_state(13) <= '0';

    -- LED 6: FD1 locked to WR
    led_state(10) <= tm_clk_aux_locked(1);
    led_state(11) <= '0';

    led_state(8) <= '0';
    led_state(9) <= '0';

  end generate gen_without_external_leds;

  -- The SFP is permanently enabled.
  sfp_tx_disable_o <= '0';

  -- Debug signals assignments (FP lemos)

  rst_n_sys_o <= local_reset_n;
  clk_sys_o   <= clk_sys;

-- forward timing to the FMC cores in the top level.
  tm_link_up_o        <= tm_link_up;
  tm_dac_value_o      <= tm_dac_value;
  tm_dac_wr_o         <= tm_dac_wr;
  tm_clk_aux_lock_en  <= tm_clk_aux_lock_en_i;
  tm_time_valid_o     <= tm_time_valid;
  tm_tai_o            <= tm_tai;
  tm_cycles_o         <= tm_cycles;
  tm_clk_aux_locked_o <= tm_clk_aux_locked;

  tm.cycles                 <= tm_cycles;
  tm.tai                    <= tm_tai;
  tm.time_valid             <= tm_time_valid;
  tm.link_up                <= tm_link_up;
  tm.aux_locked(1 downto 0) <= tm_clk_aux_locked;
  tm.aux_locked(7 downto 6) <= (others => '0');

  fmc0_host_wb_o              <= cnx_master_out(c_SLAVE_FMC0);
  fmc1_host_wb_o              <= cnx_master_out(c_SLAVE_FMC1);
  cnx_master_in(c_SLAVE_FMC0) <= fmc0_host_wb_i;
  cnx_master_in(c_SLAVE_FMC1) <= fmc1_host_wb_i;


  fp_gpio1_a2b_o  <= wrn_gpio_out(24);
  fp_gpio2_a2b_o  <= wrn_gpio_out(25);
  fp_gpio34_a2b_o <= wrn_gpio_out(26);

  wrn_gpio_in(0) <= fp_gpio1_b;
  wrn_gpio_in(1) <= fp_gpio2_b;
  wrn_gpio_in(2) <= fp_gpio3_b;
  wrn_gpio_in(3) <= fp_gpio4_b;

  fp_gpio1_b <= 'Z' when wrn_gpio_out(24) = '0' else wrn_gpio_out(0);
  fp_gpio2_b <= 'Z' when wrn_gpio_out(25) = '0' else wrn_gpio_out(1);
  fp_gpio3_b <= 'Z' when wrn_gpio_out(26) = '0' else wrn_gpio_out(2);
  fp_gpio4_b <= 'Z' when wrn_gpio_out(26) = '0' else wrn_gpio_out(3);
  
  
end rtl;


