-------------------------------------------------------------------------------
-- Title      : WR Node Core Example Design (SPEC)
-- Project    : WR Node Core
-------------------------------------------------------------------------------
-- File       : spec_top.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2015-07-24
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- A simple WR Node core design for experimenting or using as a template for
-- your projects. Use in conjunction with the WR Node "Hello, world" example
-- from the WR Node Core Software project (ohwr.org/projects/wr-node-core-sw).
--
-- This design contains:
-- - WR Node with 2 CPU Cores (each with 32 kB of RAM)
-- - 2 GPIO controllers connected to the Dedicated Peripheral ports of each of
--   the CPU cores. The GPIO outputs are connected together.
-- - The GPIO controls the 4 LEDs on the SPEC front panel
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

      leds_n_o : out std_logic_vector(3 downto 0)
    );
end spec_top;

architecture rtl of spec_top is

  -- Host Message Queue configuration
  -- Each CPU has three queues assigned:
  -- 1) a small incoming queue (8 entries x 32 words) for sending host to CPU commands
  -- 2) a large outgoing queue (128 entries x 16 words) for optional event
  -- logging (asynchronous)
  -- 3) a small outgoing queue (8 entries x 128 words) for receiving command replies
  --    (CPU to host)
  
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

  -- Remote Message Queue, for playing with White Rabbit/Etherbone
  -- 1) outgoing path (CPU -> WR Network): 16 entries x 128 words
  -- 2) incoming path (WR Network -> CPU): 16 entries x 128 words.
  -- Use at your convenience.
  
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
      app_id       => x"d330d330",
      cpu_count    => 2,
      cpu_memsizes => (32768, 32768, 0, 0, 0, 0, 0, 0),
      hmq_config   => c_hmq_config,
      rmq_config   => c_rmq_config,
      shared_mem_size => 8192
      );

  signal clk_sys : std_logic;
  signal rst_n_sys   : std_logic;

  signal fmc_dp_wb_out : t_wishbone_master_out;
  signal fmc_dp_wb_in  : t_wishbone_master_in;
  
  signal cpu0_gpio_oen : std_logic_vector(31 downto 0);
  signal cpu0_gpio_out : std_logic_vector(31 downto 0);
  signal cpu0_gpio_in    : std_logic_vector(31 downto 0);

  -- keep VHDL happy... :-(
  signal dummy : std_logic_vector(31 downto 0);
  
begin

  U_Node_Template : spec_node_template
    generic map (
      g_simulation           => g_simulation,
      g_with_wr_phy          => false,
      g_with_white_rabbit =>  false,
      g_double_wrnode_core_clock => false,
      g_wr_node_config       => c_node_config)
    port map (
      rst_n_sys_o          => rst_n_sys,
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

      fmc0_dp_wb_o => fmc_dp_wb_out,
      fmc0_dp_wb_i => fmc_dp_wb_in,

      fmc0_clk_aux_i       => '0',
      fmc0_host_irq_i      => '0'
);

  U_GPIO_CPU0 : xwb_gpio_port
    generic map (
      g_interface_mode         => PIPELINED,
      g_address_granularity    => BYTE,
      g_num_pins               => 32,
      -- we don't want a 3-state output
      g_with_builtin_tristates => false)
    port map (
      clk_sys_i  => clk_sys,
      rst_n_i    => rst_n_sys,
      slave_i    => fmc_dp_wb_out,
      slave_o    => fmc_dp_wb_in,
      gpio_b     => dummy,
      gpio_out_o => cpu0_gpio_out,
      gpio_in_i  => cpu0_gpio_in,
      gpio_oen_o => cpu0_gpio_oen);

  leds_n_o(0) <= not cpu0_gpio_out(0);
  leds_n_o(1) <= not cpu0_gpio_out(1);
  leds_n_o(2) <= not cpu0_gpio_out(2);
  leds_n_o(3) <= not cpu0_gpio_out(3);

  cpu0_gpio_in(4) <= not button1_i;
  cpu0_gpio_in(5) <= not button2_i;
  cpu0_gpio_in(3 downto 0) <= cpu0_gpio_out(3 downto 0);
  cpu0_gpio_in(31 downto 6) <= (others => '0');

 
end rtl;



