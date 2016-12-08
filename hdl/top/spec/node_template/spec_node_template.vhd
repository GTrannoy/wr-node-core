-------------------------------------------------------------------------------
-- Title      : WR Node Core template design for the SPEC carrier
-- Project    : WR Node Core
-------------------------------------------------------------------------------
-- File       : spec_node_template.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-12-07
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Shared part of a typical WR node for the SPEC carrier. Contains pre-configured:
-- - WR PTP Core
-- - WR Node Core + Etherbone
-- - Wishbone interfaces for one mezzanine. 
-- Just instantiate this in the top level of your SPEC (see wr_node_demo
-- project), connect any cores you want, synthesize and play!
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

use work.spec_node_pkg.all;
use work.wishbone_pkg.all;
use work.wr_fabric_pkg.all;
use work.gn4124_core_pkg.all;
use work.wr_node_pkg.all;
use work.etherbone_pkg.all;
use work.gencores_pkg.all;
use work.wrcore_pkg.all;
use work.wr_xilinx_pkg.all;

library unisim;
use unisim.vcomponents.all;

entity spec_node_template is
  generic (
-- SDB record of the mezzanine connected to slot 0
    g_fmc0_sdb        : t_sdb_record;
-- VIC interrupt vector address of the mezzanine in slot 0
    g_fmc0_vic_vector : t_wishbone_address;

-- Enables/disable White Rabbit support
    g_with_white_rabbit : boolean := true;

-- Gives the WRPC LM32 firmware
    g_wr_core_dpram_initf : string := "none";

-- Reduces some timeouts to speed up simulations.
    g_simulation     : boolean := false;
-- Enable/disable instantiation of the gigabit transceiver core.
-- Speeds up the simulations a lot.
    g_with_wr_phy    : boolean := false;
-- When true, the CPUs in the WR node run at 125 MHz (twice the
-- 62.5 MHz system clock). May not meet the timing for heavily
-- congested designs.
    g_double_wrnode_core_clock : boolean := false;

-- Configuration of the WR Node Core. Fill in according to your needs.
    g_wr_node_config : t_wr_node_config;

    -- clk_sys_o speed (& CPU speed). Currently only a discrete set of
    -- frequencies is supported
    g_system_clock_freq : integer := 62500000
    
    );

  port (
    

      -------------------------------------------------------------------------
      -- Standard SPEC ports (Gennum bridge, LEDS, Etc. Do not modify
      -------------------------------------------------------------------------
      
      -- system reset & clock output (default: 62.5 MHz)
      rst_n_sys_o : out std_logic;
      clk_sys_o   : out std_logic;
      pps_o       : out std_logic;
      
      clk_20m_vcxo_i : in std_logic;    -- 20MHz VCXO clock

      clk_125m_pllref_p_i : in std_logic;  -- 125 MHz PLL reference
      clk_125m_pllref_n_i : in std_logic;

      clk_125m_gtp_n_i : in std_logic;  -- 125 MHz GTP reference
      clk_125m_gtp_p_i : in std_logic;

      l_rst_n : in std_logic;   -- reset from gn4124 (rstout18_n)

      -- general purpose interface
      gpio       : inout std_logic_vector(1 downto 0);  -- gpio[0] -> gn4124 gpio8
                                        -- gpio[1] -> gn4124 gpio9
--      -- pcie to local [inbound data] - rx
--      p2l_rdy    : out   std_logic;     -- rx buffer full flag
--      p2l_clkn   : in    std_logic;     -- receiver source synchronous clock-
--      p2l_clkp  : in    std_logic;     -- receiver source synchronous clock+
--      p2l_data  : in    std_logic_vector(15 downto 0);  -- parallel receive data
--      p2l_dframe : in    std_logic;     -- receive frame
--      p2l_valid  : in    std_logic;     -- receive data valid
--
--      -- inbound buffer request/status
--      p_wr_req : in  std_logic_vector(1 downto 0);  -- pcie write request
--      p_wr_rdy : out std_logic_vector(1 downto 0);  -- pcie write ready
--      rx_error : out std_logic;                     -- receive error
--
--      -- local to parallel [outbound data] - tx
--      l2p_data   : out std_logic_vector(15 downto 0);  -- parallel transmit data
--      l2p_dframe : out std_logic;       -- transmit data frame
--      l2p_valid  : out std_logic;       -- transmit data valid
--      l2p_clkn   : out std_logic;  -- transmitter source synchronous clock-
--      l2p_clkp   : out std_logic;  -- transmitter source synchronous clock+
--      l2p_edb    : out std_logic;       -- packet termination and discard
--
--      -- outbound buffer status
--      l2p_rdy    : in std_logic;        -- tx buffer full flag
--      l_wr_rdy   : in std_logic_vector(1 downto 0);  -- local-to-pcie write
--      p_rd_d_rdy : in std_logic_vector(1 downto 0);  -- pcie-to-local read response data ready
--      tx_error   : in std_logic;        -- transmit error
--      vc_rdy    : in std_logic_vector(1 downto 0);  -- channel ready

      -- front panel leds
      led_red   : out std_logic;
      led_green : out std_logic;

      -------------------------------------------------------------------------
      -- PLL VCXO DAC Drive
      -------------------------------------------------------------------------

      dac_sclk_o  : out std_logic;
      dac_din_o   : out std_logic;
      dac_cs1_n_o : out std_logic;
      dac_cs2_n_o : out std_logic;

      fmc_scl_b : inout std_logic := '1';
      fmc_sda_b : inout std_logic := '1';

      carrier_onewire_b : inout std_logic := '1';
      fmc_prsnt_m2c_l_i : in    std_logic;

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


      -------------------------------------------------------------------------
      -- WR core UART
      -------------------------------------------------------------------------
            
      uart_rxd_i : in  std_logic := '1';
      uart_txd_o : out std_logic;

      -------------------------------------------------------------------------
      -- Flash SPI
      -------------------------------------------------------------------------

      spi_cs_n_o : out std_logic;
      spi_sclk_o : out std_logic;
      spi_mosi_o : out std_logic;
      spi_miso_i : in  std_logic;
      
      -------------------------------------------------------------------------
      -- FMC <> WRNode interface (FMC slot 1)
      -------------------------------------------------------------------------

      -- aux clock for WR core to lock-
      fmc0_clk_aux_i  : in  std_logic;
      -- host Wishbone bus (i.e. for the device driver to access the mezzanine regs)
      fmc0_host_wb_o  : out t_wishbone_master_out;
      fmc0_host_wb_i  : in  t_wishbone_master_in;
      -- host interrupt line
      fmc0_host_irq_i : in  std_logic;

      -- Shared Peripheral port

      dp_master_o : out t_wishbone_master_out_array(0 to g_wr_node_config.cpu_count-1);
      dp_master_i : in t_wishbone_master_in_array(0 to g_wr_node_config.cpu_count-1);
      
      sp_master_o : out t_wishbone_master_out;
      sp_master_i: in t_wishbone_master_in := cc_dummy_master_in;
    
      -------------------------------------------------------------------------
      -- WR Core timing interface.
      -------------------------------------------------------------------------

      tm_link_up_o         : out std_logic;
      tm_dac_value_o       : out std_logic_vector(23 downto 0);
      tm_dac_wr_o          : out std_logic_vector(0 downto 0);
      tm_clk_aux_lock_en_i : in  std_logic_vector(0 downto 0) := (others => '0');
      tm_clk_aux_locked_o  : out std_logic_vector(0 downto 0);
      tm_time_valid_o      : out std_logic;
      tm_tai_o             : out std_logic_vector(39 downto 0);
      tm_cycles_o          : out std_logic_vector(27 downto 0)
      );

end spec_node_template;

architecture rtl of spec_node_template is

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

  component spec_reset_gen is
    port (
      clk_sys_i        : in  std_logic;
      rst_pcie_n_a_i   : in  std_logic;
      rst_button_n_a_i : in  std_logic;
      rst_n_o          : out std_logic);
  end component spec_reset_gen;

  component i2c_mux is
    port (
      i2c_sel_i : in  std_logic_vector(1 downto 0);
      i2c_lck_o : out std_logic;
      sda_mux_i : in  std_logic;
      sda_mux_o : out std_logic;
      scl_mux_i : in  std_logic;
      scl_mux_o : out std_logic;
      wrc_sda_i : out std_logic;
      wrc_sda_o : in  std_logic;
      wrc_scl_i : out std_logic;
      wrc_scl_o : in  std_logic;
      wrn_sda_i : out std_logic;
      wrn_sda_o : in  std_logic;
      wrn_scl_i : out std_logic;
      wrn_scl_o : in  std_logic
    );
  end component;

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
      return f_sdb_embed_bridge ( c_WRCORE_BRIDGE_SDB, x"00040000" );
    else
      return f_sdb_embed_device ( cc_dummy_sdb_device, x"00040000" );
    end if;
  end function;
  

  constant c_NUM_WB_MASTERS : integer := 5;
  constant c_NUM_WB_SLAVES  : integer := 1;

--  constant c_MASTER_GENNUM    : integer := 0;
  constant c_MASTER_ETHERBONE : integer := 0;

  constant c_SLAVE_FMC0     : integer := 0;
  constant c_SLAVE_WR_CORE  : integer := 1;
  constant c_SLAVE_WR_NODE  : integer := 2;
  constant c_SLAVE_VIC      : integer := 3;
  constant c_SLAVE_FLASH    : integer := 4;

  constant c_INTERCONNECT_LAYOUT : t_sdb_record_array(c_NUM_WB_MASTERS - 1 downto 0) :=
    (
      c_SLAVE_FMC0    => g_fmc0_sdb,
      c_SLAVE_WR_CORE => f_pick_wr_core_sdb,
      c_SLAVE_WR_NODE => f_sdb_embed_device(c_WR_NODE_SDB, x"00020000"),
      c_SLAVE_VIC     => f_sdb_embed_device(c_xwb_vic_sdb, x"00002000"),
      c_SLAVE_FLASH   => f_sdb_embed_device(c_xwb_xil_multiboot_sdb, x"00002100")
      );

  constant c_SDB_ADDRESS : t_wishbone_address := x"00000000";

  constant c_VIC_VECTOR_TABLE : t_wishbone_address_array(0 to 2) :=
    (0 => g_fmc0_vic_vector,
     1 => x"00020000", -- WRNC Mqueue interrupt
     2 => x"00020001" -- WRNC Debug Msg interrupt
     );

  signal cnx_master_out : t_wishbone_master_out_array(c_NUM_WB_MASTERS-1 downto 0);
  signal cnx_master_in  : t_wishbone_master_in_array(c_NUM_WB_MASTERS-1 downto 0);

  signal cnx_slave_out : t_wishbone_slave_out_array(c_NUM_WB_SLAVES-1 downto 0);
  signal cnx_slave_in  : t_wishbone_slave_in_array(c_NUM_WB_SLAVES-1 downto 0);

  signal gn_wb_adr : std_logic_vector(31 downto 0);

  signal wrn_fmc0_wb_out, wrn_fmc1_wb_out, wrc_aux_master_out : t_wishbone_master_out;
  signal wrn_fmc0_wb_in, wrn_fmc1_wb_in, wrc_aux_master_in    : t_wishbone_master_in;
 
  signal wb_to_multiboot : t_wishbone_master_out;
  signal wb_from_multiboot : t_wishbone_master_in;
  signal tm_link_up         : std_logic;
  signal tm_tai             : std_logic_vector(39 downto 0);
  signal tm_cycles          : std_logic_vector(27 downto 0);
  signal tm_time_valid      : std_logic;
  signal tm_clk_aux_lock_en : std_logic_vector(0 downto 0);
  signal tm_clk_aux_locked  : std_logic_vector(0 downto 0);
  signal tm_dac_value       : std_logic_vector(23 downto 0);
  signal tm_dac_wr          : std_logic_vector(0 downto 0);


  signal wrc_scl_out : std_logic;
  signal wrc_scl_in  : std_logic;
  signal wrc_sda_out : std_logic;
  signal wrc_sda_in  : std_logic;
  signal wrc_i2c_sel : std_logic;
  signal wrn_i2c_in  : t_wrn_i2c_in_array(0 to g_wr_node_config.cpu_count-1);
  signal wrn_i2c_out : t_wrn_i2c_out_array(0 to g_wr_node_config.cpu_count-1);
  signal i2c_lck     : std_logic;
  signal fmc_scl_in  : std_logic;
  signal fmc_sda_in  : std_logic;
  signal fmc_scl_out : std_logic;
  signal fmc_sda_out : std_logic;

  --signal wrc_scl_out, wrc_scl_in, wrc_sda_out, wrc_sda_in : std_logic;
  signal sfp_scl_out, sfp_scl_in, sfp_sda_out, sfp_sda_in : std_logic;
  signal wrc_owr_en, wrc_owr_in                           : std_logic_vector(1 downto 0);

  signal pllout_clk_sys       : std_logic;
  signal pllout_clk_multiboot       : std_logic;
  signal pllout_clk_csi2c     : std_logic;
  signal pllout_clk_cpu       : std_logic;
  signal pllout_clk_dmtd      : std_logic;
  signal pllout_clk_fb_pllref : std_logic;
  signal pllout_clk_fb_dmtd   : std_logic;

  signal clk_20m_vcxo_buf : std_logic;
  signal clk_125m_pllref  : std_logic;
  signal clk_125m_gtp     : std_logic;
  signal clk_sys          : std_logic;
  signal clk_multiboot    : std_logic;
  signal clk_csi2c        : std_logic;
  signal clk_cpu         : std_logic;
  signal clk_dmtd         : std_logic;

  signal local_reset_n     : std_logic;
  signal wrn_irq           : std_logic;
  signal rst_multiboot     : std_logic;

  signal pins : std_logic_vector(31 downto 0);

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

  function f_calc_sys_divider ( freq : integer ) return integer is
  begin
    case freq is
      when 62500000 => return 16;
      when 40000000 => return 25;
      when 100000000 => return 10;
      when others => report "Unsupported WRNode system clock frequency" severity failure;
    end case;
  end f_calc_sys_divider;
  
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

  signal tm                        : t_wrn_timing_if;
  signal wrn_gpio_out, wrn_gpio_in : std_logic_vector(31 downto 0);
  signal rst_net_n                 : std_logic;
  signal wrn_debug_msg_irq : std_logic;

  signal dummy_wb_master : t_wishbone_master_out;

begin 

  U_Reset_Generator : spec_reset_gen
    port map (
      clk_sys_i        => clk_sys,
      rst_pcie_n_a_i   => l_rst_n,
      rst_button_n_a_i => '1',
      rst_n_o          => local_reset_n);


  U_Multiboot_Rst: gc_sync_ffs
    port map (
      clk_i    => clk_multiboot,
      rst_n_i  => '1',
      data_i   => local_reset_n,
      synced_o => rst_multiboot,
      npulse_o => open,
      ppulse_o => open);

  U_CC: xwb_clock_crossing port map (
      -- Slave control port
      slave_clk_i    => clk_sys,
      slave_rst_n_i  => local_reset_n,
      slave_i        => cnx_master_out(c_SLAVE_FLASH),
      slave_o        => cnx_master_in(c_SLAVE_FLASH),
      -- Master reader port
      master_clk_i   => clk_multiboot,
      master_rst_n_i => rst_multiboot,
      master_i       => wb_from_multiboot,
      master_o       => wb_to_multiboot
	);

  U_Flash : xwb_xil_multiboot
    port map (
      clk_i      => clk_multiboot,
      rst_n_i    => rst_multiboot,
      wbs_i      => wb_to_multiboot,
      wbs_o      => wb_from_multiboot,
      spi_cs_n_o => spi_cs_n_o,
      spi_sclk_o => spi_sclk_o,
      spi_mosi_o => spi_mosi_o,
      spi_miso_i => spi_miso_i);
  
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

  cmp_sys_clk_pll : PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLK_FEEDBACK       => "CLKFBOUT",
      COMPENSATION       => "INTERNAL",
      DIVCLK_DIVIDE      => 1,
      CLKFBOUT_MULT      => 8,
      CLKFBOUT_PHASE     => 0.000,
      CLKOUT0_DIVIDE     => f_calc_sys_divider(g_system_clock_freq),         -- 62.5 MHz
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
      CLKOUT1_DIVIDE     => 8,         -- 125 MHz
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
      CLKOUT2_DIVIDE     => 100,
      CLKOUT2_PHASE      => 0.000,
      CLKOUT2_DUTY_CYCLE => 0.500,
      CLKOUT3_DIVIDE     => 128,
      CLKOUT3_PHASE      => 0.000,
      CLKOUT3_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 8.0,
      REF_JITTER         => 0.016)
    port map (
      CLKFBOUT => pllout_clk_fb_pllref,
      CLKOUT0  => pllout_clk_sys,
      CLKOUT1  => pllout_clk_cpu,
      CLKOUT2  => pllout_clk_multiboot,
      CLKOUT3  => pllout_clk_csi2c,
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
      CLKOUT1_DIVIDE     => 16,         -- 62.5 MHz
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
      CLKOUT2_DIVIDE     => 8,
      CLKOUT2_PHASE      => 0.000,
      CLKOUT2_DUTY_CYCLE => 0.500,
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

  cmp_clk_sys_buf : BUFG
    port map (
      O => clk_sys,
      I => pllout_clk_sys);

 cmp_clk_sys_multiboot : BUFG
    port map (
      O => clk_multiboot,
      I => pllout_clk_multiboot);

 cmp_clk_sys_csi2c : BUFG
    port map (
      O => clk_csi2c,
      I => pllout_clk_csi2c);
  
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
  
  -------------------------------------------------------------------------------
  -- Gennum core
  -------------------------------------------------------------------------------

--  U_GN4124_Core : gn4124_core
--    port map
--    (
--      ---------------------------------------------------------
--      -- Control and status
--      rst_n_a_i => l_rst_n,
--      status_o  => open,
--
--      ---------------------------------------------------------
--      -- P2L Direction
--      --
--      -- Source Sync DDR related signals
--      p2l_clk_p_i  => p2l_clkp,
--      p2l_clk_n_i  => p2l_clkn,
--      p2l_data_i   => p2l_data,
--      p2l_dframe_i => p2l_dframe,
--      p2l_valid_i  => p2l_valid,
--      -- P2L Control
--      p2l_rdy_o    => p2l_rdy,
--      p_wr_req_i   => p_wr_req,
--      p_wr_rdy_o   => p_wr_rdy,
--      rx_error_o   => rx_error,
--      vc_rdy_i     => vc_rdy,
--
--      ---------------------------------------------------------
--      -- L2P Direction
--      ---------------------------------------------------------
--
--      -- Source Sync DDR related signals
--      l2p_clk_p_o  => l2p_clkp,
--      l2p_clk_n_o  => l2p_clkn,
--      l2p_data_o   => l2p_data,
--      l2p_dframe_o => l2p_dframe,
--      l2p_valid_o  => l2p_valid,
--      -- L2P Control
--      l2p_edb_o    => l2p_edb,
--      l2p_rdy_i    => l2p_rdy,
--      l_wr_rdy_i   => l_wr_rdy,
--      p_rd_d_rdy_i => p_rd_d_rdy,
--      tx_error_i   => tx_error,
--
--      ---------------------------------------------------------
--      -- Interrupt interface
--      ---------------------------------------------------------
--      
--      dma_irq_o => open,
--      irq_p_i   => '0',
--      irq_p_o   => open,
--
--      dma_reg_clk_i => clk_sys,
--
--      ---------------------------------------------------------
--      -- CSR wishbone interface (master pipelined)
--      csr_clk_i   => clk_sys,
--      csr_adr_o   => gn_wb_adr,
--      csr_dat_o   => cnx_slave_in(c_MASTER_GENNUM).dat,
--      csr_sel_o   => cnx_slave_in(c_MASTER_GENNUM).sel,
--      csr_stb_o   => cnx_slave_in(c_MASTER_GENNUM).stb,
--      csr_we_o    => cnx_slave_in(c_MASTER_GENNUM).we,
--      csr_cyc_o   => cnx_slave_in(c_MASTER_GENNUM).cyc,
--      csr_dat_i   => cnx_slave_out(c_MASTER_GENNUM).dat,
--      csr_ack_i   => cnx_slave_out(c_MASTER_GENNUM).ack,
--      csr_stall_i => cnx_slave_out(c_MASTER_GENNUM).stall,
--      csr_err_i => cnx_slave_out(c_MASTER_GENNUM).err,
--      csr_rty_i => cnx_slave_out(c_MASTER_GENNUM).rty,
--      csr_int_i => '0',
--		
--      dma_clk_i   => clk_sys,
--      dma_ack_i   => '1',
--      dma_stall_i => '0',
--      dma_err_i => '0',
--      dma_rty_i => '0',
--      dma_dat_i   => (others => '0'),
--      dma_int_i => '0',
--      dma_reg_adr_i => (others => '0'),
--      dma_reg_dat_i => (others => '0'),
--      dma_reg_sel_i => (others => '0'),
--      dma_reg_stb_i => '0',
--      dma_reg_cyc_i => '0',
--      dma_reg_we_i  => '0'
--      );
--
--  cnx_slave_in(c_MASTER_GENNUM).adr <= gn_wb_adr(29 downto 0) & "00";

  gen_with_wr : if( g_with_white_rabbit ) generate
  
  -- Tristates for SFP EEPROM
  sfp_mod_def1_b <= '0' when sfp_scl_out = '0' else 'Z';
  sfp_mod_def2_b <= '0' when sfp_sda_out = '0' else 'Z';
  sfp_scl_in     <= sfp_mod_def1_b;
  sfp_sda_in     <= sfp_mod_def2_b;

  carrier_onewire_b <= '0' when wrc_owr_en(0) = '1' else 'Z';
  wrc_owr_in(0) <= carrier_onewire_b;

  U_WR_CORE : xwr_core
    generic map (
      g_simulation                => f_bool2int(g_simulation),
      g_phys_uart                 => true,
      g_virtual_uart              => true,
      g_with_external_clock_input => false,
      g_ep_rxbuf_size => 1024,
      g_aux_clks                  => 1,
      g_interface_mode            => PIPELINED,
      g_address_granularity       => BYTE,
      g_softpll_enable_debugger   => false,
      g_dpram_size                => 131072/4,
      g_dpram_initf               => g_wr_core_dpram_initf)
    port map (
      clk_sys_i    => clk_sys,
      clk_dmtd_i   => clk_dmtd,
      clk_ref_i    => clk_125m_pllref,
      clk_aux_i(0) => fmc0_clk_aux_i,
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

      led_link_o => led_green,
      led_act_o  => led_red,

      scl_o        => wrc_scl_out,
      scl_i        => wrc_scl_in,
      sda_o        => wrc_sda_out,
      sda_i        => wrc_sda_in,
      i2c_sel_o    => wrc_i2c_sel,
      i2c_lck_i    => i2c_lck,
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

      aux_master_o => wrc_aux_master_out,
      aux_master_i => wrc_aux_master_in,

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

      rst_aux_n_o => rst_net_n,
      pps_p_o     => pps_o,
      pps_led_o   => open
      );

  U_DAC_ARB : spec_serial_dac_arb
    generic map (
      g_invert_sclk    => false,
      g_num_extra_bits => 8)

    port map (
      clk_i   => clk_sys,
      rst_n_i => local_reset_n,

      val1_i  => dac_dpll_data,
      load1_i => dac_dpll_load_p1,

      val2_i  => dac_hpll_data,
      load2_i => dac_hpll_load_p1,

      dac_cs_n_o(0) => dac_cs1_n_o,
      dac_cs_n_o(1) => dac_cs2_n_o,
      dac_sclk_o    => dac_sclk_o,
      dac_din_o     => dac_din_o);

  end generate gen_with_wr;

  wrn_i2c_in(1).lck <= i2c_lck;
  -- FMC I2C connection
  U_I2C_MUX : i2c_mux
    port map (
      i2c_sel_i(0) => wrc_i2c_sel,
      i2c_sel_i(1) => wrn_i2c_out(1).sel,
      i2c_lck_o => i2c_lck,

      sda_mux_i => fmc_sda_in,
      sda_mux_o => fmc_sda_out,
      scl_mux_i => fmc_scl_in,
      scl_mux_o => fmc_scl_out,

      wrc_sda_i => wrc_sda_in,
      wrc_sda_o => wrc_sda_out,
      wrc_scl_i => wrc_scl_in,
      wrc_scl_o => wrc_scl_out,

      wrn_sda_i => wrn_i2c_in(1).sda,
      wrn_sda_o => wrn_i2c_out(1).sda,
      wrn_scl_i => wrn_i2c_in(1).scl,
      wrn_scl_o => wrn_i2c_out(1).scl
      );

  --3 state I2C port
  fmc_scl_b <= '0' when fmc_scl_out = '0' else 'Z';
  fmc_sda_b <= '0' when fmc_sda_out = '0' else 'Z';
  fmc_scl_in <= fmc_scl_b;
  fmc_sda_in <= fmc_sda_b;

--  chipscope_icon_1: chipscope_icon
--    port map (
--      CONTROL0 => CONTROL);
--
--  chipscope_ila_1: chipscope_ila
--    port map (
--      CONTROL => CONTROL,
--      CLK     => clk_csi2c,
--      TRIG0   => TRIG(31 downto 0),
--      TRIG1   => TRIG(63 downto 32),
--      TRIG2   => TRIG(95 downto 64),
--      TRIG3   => TRIG(127 downto 96));
--
--  trig(0)  <= i2c_lck;
--  trig(1)  <= wrc_i2c_sel;
--  trig(2)  <= wrn_i2c_out(1).sel;
--  trig(3)  <= wrc_sda_in;
--  trig(4)  <= wrc_sda_out;
--  trig(5)  <= wrc_scl_in;
--  trig(6)  <= wrc_scl_out;
--  trig(7)  <= wrn_i2c_in(1).sda;
--  trig(8)  <= wrn_i2c_out(1).sda;
--  trig(9)  <= wrn_i2c_in(1).scl;
--  trig(10) <= wrn_i2c_out(1).scl;
--  trig(11) <= fmc_scl_in;
--  trig(12) <= fmc_sda_in;
--  trig(13) <= fmc_scl_out;
--  trig(14) <= fmc_sda_out;

  gen_without_wr: if ( not g_with_white_rabbit ) generate
    cnx_master_in(c_SLAVE_WR_CORE).ack <= '1';
    cnx_master_in(c_SLAVE_WR_CORE).stall <= '0';
    cnx_master_in(c_SLAVE_WR_CORE).err <= '0';
    cnx_master_in(c_SLAVE_WR_CORE).rty <= '0';
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
      g_num_interrupts      => 3,
      g_init_vectors        => c_VIC_VECTOR_TABLE,
      g_retry_timeout => 10000) -- hack - 100us retry timeout to make SPEC work
    port map (
      clk_sys_i    => clk_sys,
      rst_n_i      => local_reset_n,
      slave_i      => cnx_master_out(c_SLAVE_VIC),
      slave_o      => cnx_master_in(c_SLAVE_VIC),
      irqs_i(0)    => fmc0_host_irq_i,
      irqs_i(1)    => wrn_irq,
      irqs_i(2)    => wrn_debug_msg_irq,
      irq_master_o => vic_master_irq);

 gpio(0) <= vic_master_irq;

  gen_wr_node_with_white_rabbit : if g_with_white_rabbit generate
  
  U_WR_Node : wr_node_core_with_etherbone
    generic map (
      g_config => g_wr_node_config,
      g_double_core_clock => g_double_wrnode_core_clock,
      g_with_eb_remote => true)
    port map (
      clk_i          => clk_sys,
      clk_cpu_i      => clk_cpu,
      clk_ref_i      => clk_125m_pllref,
      rst_n_i        => local_reset_n,
      rst_net_n_i    => rst_net_n,
      eb_topxbar_o   => cnx_slave_in(c_MASTER_ETHERBONE),
      eb_topxbar_i   => cnx_slave_out(c_MASTER_ETHERBONE),
      dp_master_o    => dp_master_o,
      dp_master_i    => dp_master_i,
      wr_src_o       => ebm_src_out,
      wr_src_i       => ebm_src_in,
      wr_snk_o       => ebs_snk_out,
      wr_snk_i       => ebs_snk_in,
      eb_config_i    => wrc_aux_master_out,
      eb_config_o    => wrc_aux_master_in,
      host_slave_i   => cnx_master_out(c_SLAVE_WR_NODE),
      host_slave_o   => cnx_master_in(c_SLAVE_WR_NODE),
      host_irq_o     => wrn_irq,
      tm_i           => tm,
      gpio_o         => wrn_gpio_out,
      gpio_i         => wrn_gpio_in,
      wrn_i2c_i      => wrn_i2c_in,
      wrn_i2c_o      => wrn_i2c_out,
      debug_msg_irq_o => wrn_debug_msg_irq
      );

  end generate gen_wr_node_with_white_rabbit;

  gen_wr_node_without_white_rabbit:  if not g_with_white_rabbit generate
    
    U_WR_Node : wr_node_core
      generic map (
        g_config            => g_wr_node_config,
        g_double_core_clock => g_double_wrnode_core_clock,
        g_with_rmq          => false,
        g_with_white_rabbit => false,
        g_system_clock_freq => g_system_clock_freq)
      port map (
        clk_i           => clk_sys,
        clk_cpu_i       => clk_cpu,
        rst_n_i         => local_reset_n,

        dp_master_o => dp_master_o,
        dp_master_i => dp_master_i,
        
        host_slave_i   => cnx_master_out(c_SLAVE_WR_NODE),
        host_slave_o   => cnx_master_in(c_SLAVE_WR_NODE),
        host_irq_o     => wrn_irq,
        gpio_o         => wrn_gpio_out,
        gpio_i         => wrn_gpio_in,
        wrn_i2c_i      => wrn_i2c_in,
        wrn_i2c_o      => wrn_i2c_out,
        debug_msg_irq_o => wrn_debug_msg_irq,
        tm_i => tm
    );
    
  end generate gen_wr_node_without_white_rabbit;
  
  gen_with_phy : if(g_with_wr_phy and g_with_white_rabbit ) generate

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
  tm.aux_locked(0 downto 0) <= tm_clk_aux_locked;
  tm.aux_locked(7 downto 1) <= (others => '0');

  fmc0_host_wb_o              <= cnx_master_out(c_SLAVE_FMC0);
  cnx_master_in(c_SLAVE_FMC0) <= fmc0_host_wb_i;

  gen_leds_without_wr: if not g_with_white_rabbit  generate
    led_red <= wrn_gpio_out(0);
    led_green <= wrn_gpio_out(1);
    end generate gen_leds_without_wr;

  
end rtl;


