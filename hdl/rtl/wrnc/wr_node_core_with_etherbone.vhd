-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wr_node_core_with_etherbone.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-04-29
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- White Rabbit Node Core wrapped together with Etherbone. Provided for your
-- convenience.
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

use ieee.STD_LOGIC_1164.all;

library work;
use work.wr_node_pkg.all;
use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_fabric_pkg.all;
use work.etherbone_pkg.all;

entity wr_node_core_with_etherbone is
  
  generic (
    g_config : t_wr_node_config := c_default_node_config;
    g_double_core_clock : boolean := false;
    g_with_eb_remote    : boolean := false);

  port (
    clk_i       : in std_logic;
    clk_cpu_i   : in std_logic := '0';
    rst_n_i     : in std_logic;
    rst_net_n_i : in std_logic;

    sp_master_o : out t_wishbone_master_out;
    sp_master_i : in  t_wishbone_master_in := cc_dummy_master_in;

    dp_master_o : out t_wishbone_master_out_array(0 to g_config.cpu_count-1);
    dp_master_i : in  t_wishbone_master_in_array(0 to g_config.cpu_count-1) := f_dummy_master_in_array(g_config.cpu_count);

    wr_src_o : out t_wrf_source_out;
    wr_src_i : in     t_wrf_source_in;

    wr_snk_o : out t_wrf_sink_out;
    wr_snk_i : in     t_wrf_sink_in;

    eb_topxbar_o : out t_wishbone_master_out;
    eb_topxbar_i : in  t_wishbone_master_in;
    
    eb_config_i : in  t_wishbone_slave_in;
    eb_config_o : out t_wishbone_slave_out;

    host_slave_i : in  t_wishbone_slave_in;
    host_slave_o : out t_wishbone_slave_out;
    host_irq_o   : out std_logic;

    clk_ref_i : in std_logic;
    tm_i      : in t_wrn_timing_if;

    gpio_o : out std_logic_vector(31 downto 0);
    gpio_i : in  std_logic_vector(31 downto 0);

    wrn_i2c_i       : in t_wrn_i2c_in_array(0 to g_config.cpu_count-1);
    wrn_i2c_o       : out t_wrn_i2c_out_array(0 to g_config.cpu_count-1);
    
    debug_msg_irq_o : out std_logic

    );

end wr_node_core_with_etherbone;

architecture rtl of wr_node_core_with_etherbone is

  constant c_SLAVE_EBM_CONFIG : integer := 0;
  constant c_SLAVE_EBS_CONFIG : integer := 1;

  constant c_MUX_WRNODE  : integer := 0;
  constant c_MUX_TOPXBAR : integer := 1;

  constant c_EB_CONFIG_ADDR : t_wishbone_address_array(1 downto 0) :=
    (c_SLAVE_EBS_CONFIG => x"00000080",
     c_SLAVE_EBM_CONFIG => x"00000000");

  constant c_EB_CONFIG_MASK : t_wishbone_address_array(1 downto 0) :=
    (c_SLAVE_EBS_CONFIG => x"00000080",
     c_SLAVE_EBM_CONFIG => x"00000080");

  constant c_EBS_MUX_ADDR : t_wishbone_address_array(1 downto 0) :=
    (1 => x"00100000",
     0 => x"00000000");

  constant c_EBS_MUX_MASK : t_wishbone_address_array(1 downto 0) :=
    (1 => x"00100000",
     0 => x"00100000");

  constant c_EBM_MUX_ADDR : t_wishbone_address_array(0 downto 0) :=
    (0 => x"00000000");
  constant c_EBM_MUX_MASK : t_wishbone_address_array(0 downto 0) :=
    (0 => x"00000000");
  
  signal eb_config_out : t_wishbone_master_out_array(1 downto 0);
  signal eb_config_in  : t_wishbone_master_in_array(1 downto 0);

  signal ebs_mux_out : t_wishbone_master_out_array(1 downto 0);
  signal ebs_mux_in  : t_wishbone_master_in_array(1 downto 0);

  signal wrn_ebs_out, ebm_mux_out, wrn_ebm_out : t_wishbone_master_out;
  signal wrn_ebs_in, ebm_mux_in, wrn_ebm_in    : t_wishbone_master_in;
  signal wr_ebs_src_out : t_wrf_source_out;
  signal wr_ebs_src_in  : t_wrf_source_in;

  signal wrf_mux_snk_o : t_wrf_sink_out;
  signal wrf_mux_snk_i : t_wrf_sink_in := c_dummy_snk_in;

  signal mux_src_out   : t_wrf_source_out_array(1 downto 0);
  signal mux_src_in    : t_wrf_source_in_array(1 downto 0);
  signal mux_snk_out   : t_wrf_sink_out_array(1 downto 0);
  signal mux_snk_in    : t_wrf_sink_in_array(1 downto 0) := (others => c_dummy_snk_in);
  signal mux_class : t_wrf_mux_class(1 downto 0) :=
    (1 => x"20",
     0 => x"80");

  signal rst_net_n : std_logic;
begin


  rst_net_n <= rst_n_i and rst_net_n_i;

  U_Config_XBar : xwb_crossbar
    generic map (
      g_num_masters => 1,
      g_num_slaves  => 2,
      g_registered  => false,
      g_address     => c_EB_CONFIG_ADDR,
      g_mask        => c_EB_CONFIG_MASK)
    port map (
      clk_sys_i  => clk_i,
      rst_n_i    => rst_n_i,
      slave_i(0) => eb_config_i,
      slave_o(0) => eb_config_o,
      master_i   => eb_config_in,
      master_o   => eb_config_out);

  U_EBM_Mux : xwb_crossbar
    generic map (
      g_num_masters => 2,
      g_num_slaves  => 1,
      g_registered  => false,
      g_address     => c_EBM_MUX_ADDR,
      g_mask        => c_EBM_MUX_MASK)
    port map (
      clk_sys_i => clk_i,
      rst_n_i   => rst_n_i,
    
      slave_i(0) => eb_config_out(c_SLAVE_EBM_CONFIG),
      slave_i(1) => wrn_ebm_out,
    
      slave_o(0) => eb_config_in(c_SLAVE_EBM_CONFIG),
      slave_o(1) => wrn_ebm_in,
    
      master_i(0) => ebm_mux_in,
      master_o(0) => ebm_mux_out);


  gen_ebslave_with_eb_remote : if g_with_eb_remote generate

      U_EBS_Mux : xwb_crossbar
        generic map (
          g_num_masters => 1,
          g_num_slaves  => 2,
          g_registered  => false,
          g_address     => c_EBS_MUX_ADDR,
          g_mask        => c_EBS_MUX_MASK)
        port map (
          clk_sys_i => clk_i,
          rst_n_i   => rst_n_i,
        
          slave_i(0) => wrn_ebs_out,
          slave_o(0) => wrn_ebs_in,

          master_i => ebs_mux_in,
          master_o => ebs_mux_out);
    
      WRNode_Etherbone_Slave : eb_slave_core
      generic map (
        g_sdb_address => x"0000000000100000")
      port map (
        clk_i       => clk_i,
        nRst_i      => rst_net_n,
        src_o       => mux_src_out(c_MUX_TOPXBAR),
        src_i       => mux_src_in(c_MUX_TOPXBAR),
        snk_o       => wr_snk_o,
        snk_i       => wr_snk_i,
        cfg_slave_o => eb_config_in(c_SLAVE_EBS_CONFIG),
        cfg_slave_i => eb_config_out(c_SLAVE_EBS_CONFIG),
        master_o    => wrn_ebs_out,
        master_i    => wrn_ebs_in);

  end generate gen_ebslave_with_eb_remote;


  gen_ebslave_without_eb_remote : if ( not g_with_eb_remote ) generate

    WRNode_Etherbone_Slave : eb_slave_core
      generic map (
        g_sdb_address => x"00000000c0000000")
      port map (
        clk_i       => clk_i,
        nRst_i      => rst_net_n,
        src_o       => wr_ebs_src_out,
        src_i       => wr_ebs_src_in,
        snk_o       => wr_snk_o,
        snk_i       => wr_snk_i,
        cfg_slave_o => eb_config_in(c_SLAVE_EBS_CONFIG),
        cfg_slave_i => eb_config_out(c_SLAVE_EBS_CONFIG),
        master_o    => wrn_ebs_out,
        master_i    => wrn_ebs_in);

  end generate gen_ebslave_without_eb_remote;

  wr_ebs_src_in.stall <= '0';
  wr_ebs_src_in.err   <= '0';
  wr_ebs_src_in.rty   <= '0';
    
  process(clk_i)
  begin
    if rising_edge(clk_i) then
      wr_ebs_src_in.ack <= wr_ebs_src_out.stb and wr_ebs_src_out.cyc;
    end if;
  end process;

  gen_wrf_mux_with_eb_remote: if g_with_eb_remote generate

    WRF_MUX: xwrf_mux
    generic map (
      g_muxed_ports => 2)
    port map (
      clk_sys_i	=> clk_i,
      rst_n_i	=> rst_net_n,
      --ENDPOINT
      ep_src_o	=> wr_src_o,
      ep_src_i	=> wr_src_i,
      ep_snk_o  => wrf_mux_snk_o,
      ep_snk_i  => wrf_mux_snk_i,
      --Muxed ports
      mux_src_o => mux_snk_in,
      mux_src_i => mux_snk_out,
      mux_snk_o => mux_src_in,
      mux_snk_i => mux_src_out,
      mux_class_i  => mux_class);
    
  end generate gen_wrf_mux_with_eb_remote;

  gen_ebmaster_with_eb_remote: if g_with_eb_remote generate
  
    U_WRNode_Etherbone_Master : eb_master_top
      generic map (
        g_adr_bits_hi => 8,
        g_mtu         => 1024)
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_net_n,
        slave_i => ebm_mux_out,
        slave_o => ebm_mux_in,
        src_i   => mux_src_in(c_MUX_WRNODE),
        src_o   => mux_src_out(c_MUX_WRNODE));

  end generate gen_ebmaster_with_eb_remote;
  
  gen_ebmaster_without_eb_remote: if (not g_with_eb_remote ) generate
  
    U_WRNode_Etherbone_Master : eb_master_top
      generic map (
        g_adr_bits_hi => 8,
        g_mtu         => 1024)
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_net_n,
        slave_i => ebm_mux_out,
        slave_o => ebm_mux_in,
        src_i   => wr_src_i,
        src_o   => wr_src_o);

  end generate gen_ebmaster_without_eb_remote;

  gen_wr_node_with_eb_remote: if g_with_eb_remote generate

    U_WRNode_Core : wr_node_core
      generic map (
        g_config => g_config,
        g_double_core_clock => g_double_core_clock,
        g_with_white_rabbit =>true,
        g_with_rmq =>true)
      port map (
        clk_i        => clk_i,
        clk_cpu_i => clk_cpu_i,
        rst_n_i      => rst_n_i,
        dp_master_o  => dp_master_o,
        dp_master_i  => dp_master_i,
        sp_master_o  => sp_master_o,
        sp_master_i  => sp_master_i,
        ebm_master_o => wrn_ebm_out,
        ebm_master_i => wrn_ebm_in,
        ebs_slave_o  => ebs_mux_in(c_MUX_WRNODE),
        ebs_slave_i  => ebs_mux_out(c_MUX_WRNODE),
        host_slave_i => host_slave_i,
        host_slave_o => host_slave_o,
        host_irq_o   => host_irq_o,
        clk_ref_i    => clk_ref_i,
        tm_i         => tm_i,
        gpio_i       => gpio_i,
        gpio_o       => gpio_o,
        wrn_i2c_i    => wrn_i2c_i,
        wrn_i2c_o    => wrn_i2c_o,
        debug_msg_irq_o => debug_msg_irq_o);

    ebs_mux_in(c_MUX_TOPXBAR) <= eb_topxbar_i;
    eb_topxbar_o   <= ebs_mux_out(c_MUX_TOPXBAR);

  end generate gen_wr_node_with_eb_remote;
  
  gen_wr_node_without_eb_remote: if ( not g_with_eb_remote ) generate

    U_WRNode_Core : wr_node_core
      generic map (
        g_config => g_config,
        g_double_core_clock => g_double_core_clock,
        g_with_white_rabbit =>true,
        g_with_rmq =>true)
      port map (
        clk_i        => clk_i,
        clk_cpu_i => clk_cpu_i,
        rst_n_i      => rst_n_i,
        dp_master_o  => dp_master_o,
        dp_master_i  => dp_master_i,
        sp_master_o  => sp_master_o,
        sp_master_i  => sp_master_i,
        ebm_master_o => wrn_ebm_out,
        ebm_master_i => wrn_ebm_in,
        ebs_slave_o  => wrn_ebs_in,
        ebs_slave_i  => wrn_ebs_out,
        host_slave_i => host_slave_i,
        host_slave_o => host_slave_o,
        host_irq_o   => host_irq_o,
        clk_ref_i    => clk_ref_i,
        tm_i         => tm_i,
        gpio_i       => gpio_i,
        gpio_o       => gpio_o,
        wrn_i2c_i    => wrn_i2c_i,
        wrn_i2c_o    => wrn_i2c_o,
        debug_msg_irq_o => debug_msg_irq_o);
    
  end generate gen_wr_node_without_eb_remote;

end rtl;
