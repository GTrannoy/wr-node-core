-------------------------------------------------------------------------------
-- Title      : WR Node Core template design for the SVEC carrier
-- Project    : WR Node Core
-------------------------------------------------------------------------------
-- File       : svec_node_pkg.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2015-02-20
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Sample top level SVEC wrapper with WR node code and WR PTP core embedded.
-- Just connect your FMCs and configure the mqueues to start playing!
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
use work.xvme64x_core_pkg.all;

package svec_node_pkg is

  component svec_node_template is
    generic (
      g_fmc0_sdb        : t_sdb_record;
      g_fmc0_vic_vector : t_wishbone_address;
      g_fmc1_sdb        : t_sdb_record;
      g_fmc1_vic_vector : t_wishbone_address;
      g_simulation      : integer;
      g_with_wr_phy     : integer;
      g_wr_node_config  : t_wr_node_config);
    port (
      rst_n_a_i            : in    std_logic;
      rst_n_sys_o          : out   std_logic;
      clk_sys_o            : out   std_logic;
      clk_20m_vcxo_i       : in    std_logic;
      clk_125m_pllref_p_i  : in    std_logic;
      clk_125m_pllref_n_i  : in    std_logic;
      clk_125m_gtp_p_i     : in    std_logic;
      clk_125m_gtp_n_i     : in    std_logic;
      fp_led_line_oen_o    : out   std_logic_vector(1 downto 0);
      fp_led_line_o        : out   std_logic_vector(1 downto 0);
      fp_led_column_o      : out   std_logic_vector(3 downto 0);
      fp_gpio1_a2b_o       : out   std_logic;
      fp_gpio2_a2b_o       : out   std_logic;
      fp_gpio34_a2b_o      : out   std_logic;
      fp_gpio1_b           : inout   std_logic;
      fp_gpio2_b           : inout   std_logic;
      fp_gpio3_b           : inout   std_logic;
      fp_gpio4_b           : inout   std_logic;
      VME_AS_n_i           : in    std_logic;
      VME_RST_n_i          : in    std_logic;
      VME_WRITE_n_i        : in    std_logic;
      VME_AM_i             : in    std_logic_vector(5 downto 0);
      VME_DS_n_i           : in    std_logic_vector(1 downto 0);
      VME_GA_i             : in    std_logic_vector(5 downto 0);
      VME_BERR_o           : inout std_logic;
      VME_DTACK_n_o        : inout std_logic;
      VME_RETRY_n_o        : out   std_logic;
      VME_RETRY_OE_o       : out   std_logic;
      VME_LWORD_n_b        : inout std_logic;
      VME_ADDR_b           : inout std_logic_vector(31 downto 1);
      VME_DATA_b           : inout std_logic_vector(31 downto 0);
      VME_BBSY_n_i         : in    std_logic;
      VME_IRQ_n_o          : out   std_logic_vector(6 downto 0);
      VME_IACK_n_i         : in    std_logic;
      VME_IACKIN_n_i       : in    std_logic;
      VME_IACKOUT_n_o      : out   std_logic;
      VME_DTACK_OE_o       : inout std_logic;
      VME_DATA_DIR_o       : inout std_logic;
      VME_DATA_OE_N_o      : inout std_logic;
      VME_ADDR_DIR_o       : inout std_logic;
      VME_ADDR_OE_N_o      : inout std_logic;
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
      pll20dac_din_o       : out   std_logic;
      pll20dac_sclk_o      : out   std_logic;
      pll20dac_sync_n_o    : out   std_logic;
      pll25dac_din_o       : out   std_logic;
      pll25dac_sclk_o      : out   std_logic;
      pll25dac_sync_n_o    : out   std_logic;
      fmc0_prsntm2c_n_i    : in    std_logic;
      fmc1_prsntm2c_n_i    : in    std_logic;
      tempid_dq_b          : inout std_logic;
      uart_rxd_i           : in    std_logic                    := '1';
      uart_txd_o           : out   std_logic;
      fmc0_clk_aux_i       : in    std_logic;
      fmc0_host_wb_o       : out   t_wishbone_master_out;
      fmc0_host_wb_i       : in    t_wishbone_master_in;
      fmc0_dp_wb_o         : out   t_wishbone_master_out;
      fmc0_dp_wb_i         : in    t_wishbone_master_in;
      fmc0_host_irq_i      : in    std_logic;
      fmc1_clk_aux_i       : in    std_logic;
      fmc1_host_wb_o       : out   t_wishbone_master_out;
      fmc1_host_wb_i       : in    t_wishbone_master_in;
      fmc1_dp_wb_o         : out   t_wishbone_master_out;
      fmc1_dp_wb_i         : in    t_wishbone_master_in;
      fmc1_host_irq_i      : in    std_logic;
      tm_link_up_o         : out   std_logic;
      tm_dac_value_o       : out   std_logic_vector(23 downto 0);
      tm_dac_wr_o          : out   std_logic_vector(1 downto 0);
      tm_clk_aux_lock_en_i : in    std_logic_vector(1 downto 0) := (others => '0');
      tm_clk_aux_locked_o  : out   std_logic_vector(1 downto 0);
      tm_time_valid_o      : out   std_logic;
      tm_tai_o             : out   std_logic_vector(39 downto 0);
      tm_cycles_o          : out   std_logic_vector(27 downto 0);
      carrier_scl_b        : inout std_logic;
      carrier_sda_b        : inout std_logic);
  end component svec_node_template;

end svec_node_pkg;