-------------------------------------------------------------------------------
-- Title      : WR Node Core Example Design (SVEC)
-- Project    : WR Node Core
-------------------------------------------------------------------------------
-- File       : svec_top.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2015-05-29
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
-- - The GPIO controls the 8 LEDs on the SVEC front panel and gives the access
--   to the 4 LEMO connectors (input or output, direction is programmable)
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
use work.svec_node_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_node_pkg.all;

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

    fmc1_fd_spi_cs_dac_n_o : out std_logic;
    fmc1_fd_spi_sclk_o     : out std_logic;
    fmc1_fd_spi_mosi_o     : out std_logic;
    fmc1_fd_spi_miso_i     : in  std_logic;
    fmc1_fd_ext_rst_n_o    : out std_logic;

    tempid_dq_b : inout std_logic;

    uart_rxd_i : in  std_logic := '1';
    uart_txd_o : out std_logic

   -- put the FMC I/Os here
    );
end svec_top;

architecture rtl of svec_top is

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
      rmq_config   => c_rmq_config
      );

  signal clk_sys : std_logic;
  signal rst_n_sys   : std_logic;

  signal fmc_dp_wb_out : t_wishbone_master_out_array(1 downto 0);
  signal fmc_dp_wb_in  : t_wishbone_master_in_array(1 downto 0);
  
  signal cpu0_gpio_oen, cpu1_gpio_oen : std_logic_vector(31 downto 0);
  signal cpu0_gpio_out, cpu1_gpio_out : std_logic_vector(31 downto 0);
  signal cpu_gpio_out, cpu_gpio_in    : std_logic_vector(31 downto 0);

  -- keep VHDL happy... :-(
  signal dummy : std_logic_vector(31 downto 0);
  
begin

  U_Node_Template : svec_node_template
    generic map (
      g_simulation           => g_simulation,
      g_with_wr_phy          => true,
      g_wr_node_config       => c_node_config,
      -- we drive the FP leds from our demo CPUs instead of the WR core
      g_use_external_fp_leds => true)
    port map (
      rst_n_a_i           => rst_n_a_i,
      rst_n_sys_o         => rst_n_sys,
      clk_sys_o           => clk_sys,
      clk_20m_vcxo_i      => clk_20m_vcxo_i,
      clk_125m_pllref_p_i => clk_125m_pllref_p_i,
      clk_125m_pllref_n_i => clk_125m_pllref_n_i,
      clk_125m_gtp_p_i    => clk_125m_gtp_p_i,
      clk_125m_gtp_n_i    => clk_125m_gtp_n_i,
      fp_led_line_oen_o   => fp_led_line_oen_o,
      fp_led_line_o       => fp_led_line_o,
      fp_led_column_o     => fp_led_column_o,
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

      tempid_dq_b => tempid_dq_b,

      uart_rxd_i => uart_rxd_i,
      uart_txd_o => uart_txd_o,

      fmc0_dp_wb_o => fmc_dp_wb_out(0),
      fmc0_dp_wb_i => fmc_dp_wb_in(0),

      fmc1_dp_wb_o => fmc_dp_wb_out(1),
      fmc1_dp_wb_i => fmc_dp_wb_in(1),

      led_state_i => cpu_gpio_out(23 downto 8)

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
      slave_i    => fmc_dp_wb_out(0),
      slave_o    => fmc_dp_wb_in(0),
      gpio_b     => dummy,
      gpio_out_o => cpu0_gpio_out,
      gpio_in_i  => cpu_gpio_in,
      gpio_oen_o => cpu0_gpio_oen);

  U_GPIO_CPU1 : xwb_gpio_port
    generic map (
      g_interface_mode         => PIPELINED,
      g_address_granularity    => BYTE,
      g_num_pins               => 32,
      
      -- we don't want a 3-state output
      g_with_builtin_tristates => false)
    port map (
      clk_sys_i  => clk_sys,
      rst_n_i    => rst_n_sys,
      slave_i    => fmc_dp_wb_out(1),
      slave_o    => fmc_dp_wb_in(1),
      gpio_b     => dummy,
      gpio_out_o => cpu1_gpio_out,
      gpio_in_i  => cpu_gpio_in,
      gpio_oen_o => cpu1_gpio_oen);

  cpu_gpio_out <= cpu0_gpio_out or cpu1_gpio_out;
  
  -- FP GPIO directions
  fp_gpio1_a2b_o  <= cpu0_gpio_oen(0) or cpu1_gpio_oen(0);
  fp_gpio2_a2b_o  <= cpu0_gpio_oen(1) or cpu1_gpio_oen(1);
  fp_gpio34_a2b_o <= cpu0_gpio_oen(2) or cpu1_gpio_oen(2);


  -- FP GPIO bidir in/out

  fp_gpio1_b <= (cpu0_gpio_out(0) or cpu1_gpio_out(0))
                when (cpu0_gpio_oen(0) = '1' or cpu1_gpio_oen(0) = '1') else 'Z';

  fp_gpio2_b <= (cpu0_gpio_out(1) or cpu1_gpio_out(1))
                when (cpu0_gpio_oen(1) = '1' or cpu1_gpio_oen(1) = '1') else 'Z';

  -- FP lines 3 and 4 share the same direction line
  fp_gpio3_b <= (cpu0_gpio_out(2) or cpu1_gpio_out(2))
                when (cpu0_gpio_oen(2) = '1' or cpu1_gpio_oen(2) = '1') else 'Z';

  fp_gpio4_b <= (cpu0_gpio_out(3) or cpu1_gpio_out(3))
                when (cpu0_gpio_oen(2) = '1' or cpu1_gpio_oen(2) = '1') else 'Z';

  -- gpio inputs (same for both CPUs)
  cpu_gpio_in(0) <= fp_gpio1_b;
  cpu_gpio_in(1) <= fp_gpio2_b;
  cpu_gpio_in(2) <= fp_gpio3_b;
  cpu_gpio_in(3) <= fp_gpio4_b;
  
  cpu_gpio_in(31 downto 4) <= (others => '0');
end rtl;



