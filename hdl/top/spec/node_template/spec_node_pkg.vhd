-------------------------------------------------------------------------------
-- Title      : WR Node Core template design for the SPEC carrier
-- Project    : WR Node Core
-------------------------------------------------------------------------------
-- File       : spec_node_pkg.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2015-11-18
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Sample top level SPEC wrapper with WR node code and WR PTP core embedded.
-- Just connect your FMCs and configure the mqueues to start working!
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

library work;
use work.wishbone_pkg.all;
use work.wr_node_pkg.all;
use work.wrn_mqueue_pkg.all;

package spec_node_pkg is

  constant c_unused_wisbone_slave_out : t_wishbone_slave_out :=
    ('1', '0', '0', '0', '0', x"deadbeef");

  constant c_unused_fmc0_record : t_sdb_record := f_sdb_embed_device(cc_dummy_sdb_device, x"00010000");
  
  component spec_node_template is
    generic (
      g_fmc0_sdb        : t_sdb_record := c_unused_fmc0_record;
      g_fmc0_vic_vector : t_wishbone_address := x"00000000";
      g_simulation      : boolean := false;
      g_with_white_rabbit        : boolean := false;
      g_with_wr_phy     : boolean := true;
      g_double_wrnode_core_clock : boolean := false;
      g_wr_node_config  : t_wr_node_config;
      g_system_clock_freq : integer := 62500000
      );
    port (
      rst_n_sys_o          : out   std_logic;
      clk_sys_o            : out   std_logic;
      clk_20m_vcxo_i       : in    std_logic;
      clk_125m_pllref_p_i  : in    std_logic;
      clk_125m_pllref_n_i  : in    std_logic;
      clk_125m_gtp_n_i     : in    std_logic;
      clk_125m_gtp_p_i     : in    std_logic;
      l_rst_n : in std_logic;   -- reset from gn4124 (rstout18_n)

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

      -- front panel leds
      led_red   : out std_logic;
      led_green : out std_logic;
      dac_sclk_o           : out   std_logic;
      dac_din_o            : out   std_logic;
      dac_cs1_n_o          : out   std_logic;
      dac_cs2_n_o          : out   std_logic;
      fmc_scl_b            : inout std_logic                    := '1';
      fmc_sda_b            : inout std_logic                    := '1';
      carrier_onewire_b    : inout std_logic                    := '1';
      fmc_prsnt_m2c_l_i    : in    std_logic;
      sfp_txp_o            : out   std_logic;
      sfp_txn_o            : out   std_logic;
      sfp_rxp_i            : in    std_logic                    := '0';
      sfp_rxn_i            : in    std_logic                    := '1';
      sfp_mod_def0_b       : in    std_logic;
      sfp_mod_def1_b       : inout std_logic;
      sfp_mod_def2_b       : inout std_logic;
      sfp_rate_select_b    : inout std_logic                    := '0';
      sfp_tx_fault_i       : in    std_logic                    := '0';
      sfp_tx_disable_o     : out   std_logic;
      sfp_los_i            : in    std_logic                    := '0';
      uart_rxd_i           : in    std_logic                    := '1';
      uart_txd_o           : out   std_logic;
      fmc0_clk_aux_i       : in    std_logic := '0';
      fmc0_host_wb_o       : out   t_wishbone_master_out;
      fmc0_host_wb_i       : in    t_wishbone_master_in := cc_dummy_master_in;
      fmc0_host_irq_i      : in    std_logic;

      dp_master_o : out t_wishbone_master_out_array(0 to g_wr_node_config.cpu_count-1);
      dp_master_i : in t_wishbone_master_in_array(0 to g_wr_node_config.cpu_count-1);
      sp_master_o          : out   t_wishbone_master_out;
      sp_master_i          : in    t_wishbone_master_in         := cc_dummy_master_in;
      tm_link_up_o         : out   std_logic;
      tm_dac_value_o       : out   std_logic_vector(23 downto 0);
      tm_dac_wr_o          : out   std_logic_vector(0 downto 0);
      tm_clk_aux_lock_en_i : in    std_logic_vector(0 downto 0) := (others => '0');
      tm_clk_aux_locked_o  : out   std_logic_vector(0 downto 0);
      tm_time_valid_o      : out   std_logic;
      tm_tai_o             : out   std_logic_vector(39 downto 0);
      tm_cycles_o          : out   std_logic_vector(27 downto 0));
  end component spec_node_template;

 
end spec_node_pkg;
