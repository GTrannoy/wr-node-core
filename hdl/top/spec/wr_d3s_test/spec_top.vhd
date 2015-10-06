-------------------------------------------------------------------------------
-- Title      : WR RF DDS Distribution Node (SVEC)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : svec_top.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2015-09-09
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- fill me
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
use work.spec_node_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_node_pkg.all;

library unisim;
use unisim.vcomponents.all;

entity spec_top is
  generic (
    g_simulation : boolean := false
    );

 
  port (

    
      clk_20m_vcxo_i : in std_logic;    -- 20MHz VCXO clock

      clk_125m_pllref_p_i : in std_logic;  -- 125 MHz PLL reference
      clk_125m_pllref_n_i : in std_logic;

      clk_125m_gtp_n_i : in std_logic;  -- 125 MHz GTP reference
      clk_125m_gtp_p_i : in std_logic;

      L_RST_N: in std_logic; -- Gennum Local bus reset

      -- general purpose interface
      gpio       : inout std_logic_vector(1 downto 0);  -- gpio[0] -> gn4124 gpio8
                                        -- gpio[1] -> gn4124 gpio9
      -- pcie to local [inbound data] - rx
      p2l_rdy    : out   std_logic;     -- rx buffer full flag
      p2l_clkn   : in    std_logic;     -- receiver source synchronous clock-
      p2l_clkp  : in    std_logic;     -- receiver source synchronous clock+
      p2l_data  : in    std_logic_vector(15 downto 0);  -- parallel receive data
      p2l_dframe : in    std_logic;     -- receive frame
      p2l_valid  : in    std_logic;     -- receive data valid

      -- inbound buffer request/status
      p_wr_req : in  std_logic_vector(1 downto 0);  -- pcie write request
      p_wr_rdy : out std_logic_vector(1 downto 0);  -- pcie write ready
      rx_error : out std_logic;                     -- receive error

      -- local to parallel [outbound data] - tx
      l2p_data   : out std_logic_vector(15 downto 0);  -- parallel transmit data
      l2p_dframe : out std_logic;       -- transmit data frame
      l2p_valid  : out std_logic;       -- transmit data valid
      l2p_clkn   : out std_logic;  -- transmitter source synchronous clock-
      l2p_clkp   : out std_logic;  -- transmitter source synchronous clock+
      l2p_edb    : out std_logic;       -- packet termination and discard

      -- outbound buffer status
      l2p_rdy    : in std_logic;        -- tx buffer full flag
      l_wr_rdy   : in std_logic_vector(1 downto 0);  -- local-to-pcie write
      p_rd_d_rdy : in std_logic_vector(1 downto 0);  -- pcie-to-local read response data ready
      tx_error   : in std_logic;        -- transmit error
      vc_rdy    : in std_logic_vector(1 downto 0);  -- channel ready

      -- font panel leds
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

      button1_i : in std_logic := '1';
      button2_i : in std_logic := '1';

      leds_n_o : out std_logic_vector(3 downto 0);

      -------------------------------------------------------------------------
      -- FMC DDS
      -------------------------------------------------------------------------

    -- DDS Dac I/F (Maxim)
    fmc0_dac_n_o : out std_logic_vector(13 downto 0);
    fmc0_dac_p_o : out std_logic_vector(13 downto 0);

    -- SPI bus to both PLL chips
    fmc0_pll_sclk_o : buffer  std_logic;
    fmc0_pll_sdio_b : inout std_logic;
    fmc0_pll_sdo_i  : in    std_logic;


    -- System/WR PLL dedicated lines
    fmc0_pll_sys_ld_i      : in  std_logic;
    fmc0_pll_sys_reset_n_o : buffer std_logic;
    fmc0_pll_sys_cs_n_o    : buffer std_logic;
    fmc0_pll_sys_sync_n_o  : buffer std_logic;

    -- VCXO PLL dedicated lines
    fmc0_pll_vcxo_cs_n_o   : buffer std_logic;
    fmc0_pll_vcxo_sync_n_o : buffer std_logic;
    fmc0_pll_vcxo_status_i : in  std_logic;

    -- Phase Detector & ADC
    fmc0_adc_sdo_i : in  std_logic;
    fmc0_adc_sck_o : out std_logic;
    fmc0_adc_cnv_o : out std_logic;
    fmc0_adc_sdi_o : out std_logic;
    fmc0_pd_lockdet_i : in    std_logic;
    fmc0_pd_clk_o     : out   std_logic;
    fmc0_pd_data_b    : inout std_logic;
    fmc0_pd_le_o      : out   std_logic;
    
    -- WR reference clock from FMC's PLL (AD9516)
    fmc0_wr_ref_clk_n_i : in std_logic;
    fmc0_wr_ref_clk_p_i : in std_logic;

    fmc0_synth_clk_n_i : in std_logic;
    fmc0_synth_clk_p_i : in std_logic;

    fmc0_rf_clk_n_i : in std_logic;
    fmc0_rf_clk_p_i : in std_logic;

    -- Delay generator
    fmc0_delay_d_o     : out std_logic_vector(9 downto 0);
    fmc0_delay_fb_i    : in  std_logic;
    fmc0_delay_len_o   : out std_logic;
    fmc0_delay_pulse_o : out std_logic;

    -- Trigger input
    fmc0_trig_p_i : in std_logic;
    fmc0_trig_n_i : in std_logic;

    -- OneWire (ID & temp sensor)
    fmc0_onewire_b : inout std_logic;

    -- WR mezzanine DAC
    fmc0_wr_dac_sclk_o : out std_logic;
    fmc0_wr_dac_din_o : out std_logic;
    fmc0_wr_dac_sync_n_o : out std_logic

    );
end spec_top;

architecture rtl of spec_top is

  function f_int_to_bool (x : integer) return boolean is
  begin
    if (x = 0) then
      return false;
    else
      return true;
    end if;
  end function;


  component wr_d3s_core is
    generic (
      g_simulation     : boolean;
      g_sim_pps_period : integer := 1000);
    port (
      clk_sys_i            : in    std_logic;
      rst_n_i              : in    std_logic;
      clk_ref_i            : in    std_logic;
      clk_wr_o             : out   std_logic;
      tm_link_up_i         : in    std_logic := '1';
      tm_time_valid_i      : in    std_logic;
      tm_tai_i             : in    std_logic_vector(39 downto 0);
      tm_cycles_i          : in    std_logic_vector(27 downto 0);
      tm_clk_aux_lock_en_o : out   std_logic;
      tm_clk_aux_locked_i  : in    std_logic;
      tm_dac_value_i       : in    std_logic_vector(23 downto 0);
      tm_dac_wr_i          : in    std_logic;
      dac_n_o              : out   std_logic_vector(13 downto 0);
      dac_p_o              : out   std_logic_vector(13 downto 0);
      wr_ref_clk_n_i       : in    std_logic;
      wr_ref_clk_p_i       : in    std_logic;
      synth_clk_n_i        : in    std_logic;
      synth_clk_p_i        : in    std_logic;
      rf_clk_n_i           : in    std_logic;
      rf_clk_p_i           : in    std_logic;
      pll_sys_cs_n_o       : out   std_logic;
      pll_sys_ld_i         : in    std_logic;
      pll_sys_reset_n_o    : out   std_logic;
      pll_sys_sync_n_o     : out   std_logic;
      pll_vcxo_cs_n_o      : out   std_logic;
      pll_vcxo_sync_n_o    : out   std_logic;
      pll_vcxo_status_i    : in    std_logic;
      pll_sclk_o           : out   std_logic;
      pll_sdio_b           : inout std_logic;
      pll_sdo_i            : in    std_logic;
      pd_lockdet_i         : in    std_logic;
      pd_clk_o             : out   std_logic;
      pd_data_b            : inout std_logic;
      pd_le_o              : out   std_logic;
      adc_sdo_i            : in    std_logic;
      adc_sck_o            : out   std_logic;
      adc_cnv_o            : out   std_logic;
      adc_sdi_o            : out   std_logic;
      delay_d_o            : out   std_logic_vector(9 downto 0);
      delay_fb_i           : in    std_logic;
      delay_len_o          : out   std_logic;
      delay_pulse_o        : out   std_logic;
      trig_p_i             : in    std_logic;
      trig_n_i             : in    std_logic;
      onewire_b            : inout std_logic;
      wr_dac_sclk_o        : out   std_logic;
      wr_dac_din_o         : out   std_logic;
      wr_dac_sync_n_o      : out   std_logic;
      slave_i              : in    t_wishbone_slave_in;
      slave_o              : out   t_wishbone_slave_out;
      debug_o : out std_logic_vector(3 downto 0));
  end component wr_d3s_core;
  
 constant c_D3S_SDB_DEVICE : t_sdb_device := (
    abi_class     => x"0000",              -- undocumented device
    abi_ver_major => x"01",
    abi_ver_minor => x"00",
    wbd_endian    => c_sdb_endian_big,
    wbd_width     => x"7",                 -- 8/16/32-bit port granularity
    sdb_component => (
      addr_first  => x"0000000000000000",
      addr_last   => x"0000000000000fff",
      product     => (
        vendor_id => x"000000000000CE42",  -- CERN
        device_id => x"dd334410",          
        version   => x"00000001",
        date      => x"20150427",
        name      => "WR-D3S-Core        ")));
  
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
        others => (0, 0)
        )
      );

  
  constant c_node_config : t_wr_node_config :=
    (
      app_id       => x"dd3f3c01",
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

  constant c_d3s0_sdb_record : t_sdb_record       := f_sdb_embed_device(c_D3S_SDB_DEVICE, x"00010000");
  constant c_d3s1_sdb_record : t_sdb_record       := f_sdb_embed_device(c_D3S_SDB_DEVICE, x"00011000");
  constant c_d3s_vector     : t_wishbone_address := x"ffffffff";

  signal tm_link_up         : std_logic;
  signal tm_dac_value       : std_logic_vector(23 downto 0);
  signal tm_dac_wr          : std_logic_vector(0 downto 0);
  signal tm_clk_aux_lock_en : std_logic_vector(0 downto 0) := (others => '0');
  signal tm_clk_aux_locked  : std_logic_vector(0 downto 0);
  signal tm_time_valid      : std_logic;
  signal tm_tai             : std_logic_vector(39 downto 0);
  signal tm_cycles          : std_logic_vector(27 downto 0);

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
  signal fmc0_clk_wr : std_logic;

  signal debug : std_logic_vector(3 downto 0);

  constant c_slave_addr : t_wishbone_address_array(0 downto 0) :=
    ( 0 =>    x"00000000" );
  constant c_slave_mask : t_wishbone_address_array(0 downto 0) :=
    ( 0 =>    x"00000000" );

  signal fmc_wb_muxed_out : t_wishbone_master_out;
  signal fmc_wb_muxed_in : t_wishbone_master_in;


    
begin

  --chipscope_icon_1: chipscope_icon
  --  port map (
  --    CONTROL0 => CONTROL);

  --chipscope_ila_1: chipscope_ila
  --  port map (
  --    CONTROL => CONTROL,
  --    CLK     => clk_sys,
  --    TRIG0   => TRIG(31 downto 0),
  --    TRIG1   => TRIG(63 downto 32),
  --    TRIG2   => TRIG(95 downto 64),
  --    TRIG3   => TRIG(127 downto 96));

  TRIG(0) <= fmc0_pll_sclk_o;
  trig(1) <= fmc0_pll_sdio_b;
  trig(2) <= fmc0_pll_sdo_i;


  -- System/WR PLL dedicated lines
  trig(3) <=  fmc0_pll_sys_ld_i      ;
  trig(4) <=    fmc0_pll_sys_reset_n_o ;
  trig(5) <=    fmc0_pll_sys_cs_n_o    ;
  trig(6) <=    fmc0_pll_sys_sync_n_o  ;

  -- VCXO PLL dedicated lines
  trig(7) <=    fmc0_pll_vcxo_cs_n_o   ;
  trig(8) <=    fmc0_pll_vcxo_sync_n_o ;
  trig(9) <=    fmc0_pll_vcxo_status_i ;
  
  U_Node_Template : spec_node_template
    generic map (
      g_fmc0_sdb                 => c_d3s0_sdb_record,
      g_fmc0_vic_vector          => c_d3s_vector,
      g_simulation               => g_simulation,
      g_with_wr_phy              => true,
      g_double_wrnode_core_clock => false,
      g_wr_node_config           => c_node_config)
    port map (
      rst_n_sys_o          => rst_n,
      clk_sys_o            => clk_sys,

      clk_20m_vcxo_i       => clk_20m_vcxo_i,
      clk_125m_pllref_p_i  => clk_125m_pllref_p_i,
      clk_125m_pllref_n_i  => clk_125m_pllref_n_i,
      clk_125m_gtp_n_i     => clk_125m_gtp_n_i,
      clk_125m_gtp_p_i     => clk_125m_gtp_p_i,

      l_rst_n => l_rst_n,
      gpio               => gpio,
      p2l_rdy            => p2l_rdy,
      p2l_clkn          => p2l_clkn,
      p2l_clkp          => p2l_clkp,
      p2l_data           => p2l_data,
      p2l_dframe         => p2l_dframe,
      p2l_valid          => p2l_valid,
      p_wr_req           => p_wr_req,
      p_wr_rdy           => p_wr_rdy,
      rx_error           => rx_error,
      l2p_data           => l2p_data,
      l2p_dframe         => l2p_dframe,
      l2p_valid          => l2p_valid,
      l2p_clkn          => l2p_clkn,
      l2p_clkp          => l2p_clkp,
      l2p_edb            => l2p_edb,
      l2p_rdy            => l2p_rdy,
      l_wr_rdy           => l_wr_rdy,
      p_rd_d_rdy         => p_rd_d_rdy,
      tx_error           => tx_error,
      vc_rdy             => vc_rdy,
      led_red            => led_red,
      led_green          => led_green,
      
      dac_sclk_o           => dac_sclk_o,
      dac_din_o            => dac_din_o,
      dac_cs1_n_o          => dac_cs1_n_o,
      dac_cs2_n_o          => dac_cs2_n_o,
      fmc_scl_b            => fmc_scl_b,
      fmc_sda_b            => fmc_sda_b,
      carrier_onewire_b    => carrier_onewire_b,
      fmc_prsnt_m2c_l_i    => fmc_prsnt_m2c_l_i,
      sfp_txp_o            => sfp_txp_o,
      sfp_txn_o            => sfp_txn_o,
      sfp_rxp_i            => sfp_rxp_i,
      sfp_rxn_i            => sfp_rxn_i,
      sfp_mod_def0_b       => sfp_mod_def0_b,
      sfp_mod_def1_b       => sfp_mod_def1_b,
      sfp_mod_def2_b       => sfp_mod_def2_b,
      sfp_rate_select_b    => sfp_rate_select_b,
      sfp_tx_fault_i       => sfp_tx_fault_i,
      sfp_tx_disable_o     => sfp_tx_disable_o,
      sfp_los_i            => sfp_los_i,
      uart_rxd_i           => uart_rxd_i,
      uart_txd_o           => uart_txd_o,

      fmc0_clk_aux_i       => fmc0_clk_wr,
      cpu0_dp_wb_o         => fmc_dp_wb_out(0),
      cpu0_dp_wb_i         => fmc_dp_wb_in(0),
      cpu1_dp_wb_o         => fmc_dp_wb_out(1),
      cpu1_dp_wb_i         => fmc_dp_wb_in(1),
      tm_link_up_o         => tm_link_up,
      tm_dac_value_o       => tm_dac_value,
      tm_dac_wr_o          => tm_dac_wr,
      tm_clk_aux_lock_en_i => tm_clk_aux_lock_en,
      tm_clk_aux_locked_o  => tm_clk_aux_locked,
      tm_time_valid_o      => tm_time_valid,
      tm_tai_o             => tm_tai,
      tm_cycles_o          => tm_cycles);


  xwb_crossbar_1 : xwb_crossbar
    generic map (
      g_num_masters => 2,
      g_num_slaves  => 1,
      g_registered  => true,
      g_address     => c_slave_addr,
      g_mask        => c_slave_mask)
    port map (
      clk_sys_i => clk_sys,
      rst_n_i   => rst_n,
      slave_i(0)   => fmc_dp_wb_out(0),
      slave_i(1)   => fmc_dp_wb_out(1),
      slave_o(0)   => fmc_dp_wb_in(0),
      slave_o(1)   => fmc_dp_wb_in(1),
      master_o(0) => fmc_wb_muxed_out,
      master_i(0) => fmc_wb_muxed_in
      );





  U_DDS_Core0 : wr_d3s_core
    generic map (
      g_simulation     => g_simulation,
      g_sim_pps_period => 1000)
    port map (
      clk_sys_i            => clk_sys,
      rst_n_i              => rst_n,
      clk_ref_i            => '0',
      clk_wr_o => fmc0_clk_wr,
      tm_link_up_i         => tm_link_up,
      tm_time_valid_i      => tm_time_valid,
      tm_tai_i             => tm_tai,
      tm_cycles_i          => tm_cycles,
      tm_clk_aux_lock_en_o => tm_clk_aux_lock_en(0),
      tm_clk_aux_locked_i  => tm_clk_aux_locked(0),
      tm_dac_value_i => tm_dac_value,
      tm_dac_wr_i => tm_dac_wr(0),
      dac_n_o              => fmc0_dac_n_o,
      dac_p_o              => fmc0_dac_p_o,
      wr_ref_clk_n_i       => fmc0_wr_ref_clk_n_i,
      wr_ref_clk_p_i       => fmc0_wr_ref_clk_p_i,
      synth_clk_n_i     => fmc0_synth_clk_n_i,
      synth_clk_p_i     => fmc0_synth_clk_p_i,
      rf_clk_n_i     => fmc0_rf_clk_n_i,
      rf_clk_p_i     => fmc0_rf_clk_p_i,
      
      
      pll_sys_cs_n_o       => fmc0_pll_sys_cs_n_o,
      pll_sys_ld_i         => fmc0_pll_sys_ld_i,
      pll_sys_reset_n_o    => fmc0_pll_sys_reset_n_o,
      pll_sys_sync_n_o     => fmc0_pll_sys_sync_n_o,
      pll_vcxo_cs_n_o      => fmc0_pll_vcxo_cs_n_o,
      pll_vcxo_sync_n_o    => fmc0_pll_vcxo_sync_n_o,
      pll_vcxo_status_i    => fmc0_pll_vcxo_status_i,
      pll_sclk_o           => fmc0_pll_sclk_o,
      pll_sdio_b           => fmc0_pll_sdio_b,
      pll_sdo_i            => fmc0_pll_sdo_i,
      pd_lockdet_i         => fmc0_pd_lockdet_i,
      pd_clk_o             => fmc0_pd_clk_o,
      pd_data_b            => fmc0_pd_data_b,
      pd_le_o              => fmc0_pd_le_o,
      adc_sdo_i            => fmc0_adc_sdo_i,
      adc_sck_o            => fmc0_adc_sck_o,
      adc_cnv_o            => fmc0_adc_cnv_o,
      adc_sdi_o            => fmc0_adc_sdi_o,
      delay_d_o            => fmc0_delay_d_o,
      delay_fb_i           => fmc0_delay_fb_i,
      delay_len_o          => fmc0_delay_len_o,
      delay_pulse_o        => fmc0_delay_pulse_o,
      trig_p_i             => fmc0_trig_p_i,
      trig_n_i             => fmc0_trig_n_i,
      onewire_b            => fmc0_onewire_b,
      wr_dac_sync_n_o => fmc0_wr_dac_sync_n_o,
      wr_dac_din_o => fmc0_wr_dac_din_o,
      wr_dac_sclk_o => fmc0_wr_dac_sclk_o,
      slave_i              => fmc_wb_muxed_out,
      slave_o              => fmc_wb_muxed_in,
      debug_o => debug);

  --fp_gpio1_b <= debug(0);
  --fp_gpio2_b <= debug(1);
  --fp_gpio3_b <= debug(2);
  --fp_gpio4_b <= debug(3);
  
end rtl;



