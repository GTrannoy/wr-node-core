library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_fabric_pkg.all;


package wr_node_pkg is

  type t_wrn_timing_if is record
    link_up        : std_logic;
    dac_value      : std_logic_vector(23 downto 0);
    dac_wr         : std_logic;
    clk_aux_locked : std_logic;
    time_valid     : std_logic;
    tai            : std_logic_vector(39 downto 0);
    cycles         : std_logic_vector(27 downto 0);
  end record;

  type t_int_array is array(integer range<>) of integer;

  type t_wr_node_config is record
    app_id       : std_logic_vector(31 downto 0);
    cpu_count    : integer;
    cpu_memsizes : t_int_array (0 to 7);
    hmq_config   : t_wrn_mqueue_config;
    rmq_config   : t_wrn_mqueue_config;
  end record;


  constant c_default_node_config : t_wr_node_config :=
    (
      app_id       => x"115790de",
      cpu_count    => 2,
      cpu_memsizes => (32768, 32768, 0, 0, 0, 0, 0, 0),
      hmq_config   => c_wrn_default_mqueue_config,
      rmq_config   => c_wrn_default_mqueue_config
      );

  --- Functions

  function f_dummy_master_in_array(size : integer)
    return t_wishbone_master_in_array;
  
  

  component wr_node_core is
    generic (
      g_config : t_wr_node_config);
    port (
      clk_i        : in  std_logic;
      rst_n_i      : in  std_logic;
      sp_master_o  : out t_wishbone_master_out;
      sp_master_i  : in  t_wishbone_master_in                                  := cc_dummy_master_in;
      dp_master_o  : out t_wishbone_master_out_array(0 to g_config.cpu_count-1);
      dp_master_i  : in  t_wishbone_master_in_array(0 to g_config.cpu_count-1) := f_dummy_master_in_array(g_config.cpu_count);
      ebm_master_o : out t_wishbone_master_out;
      ebm_master_i : in  t_wishbone_master_in                                  := cc_dummy_master_in;
      ebs_slave_o  : out t_wishbone_slave_out;
      ebs_slave_i  : in  t_wishbone_slave_in                                   := cc_dummy_slave_in;
      host_slave_i : in  t_wishbone_slave_in;
      host_slave_o : out t_wishbone_slave_out;
      host_irq_o   : out std_logic;
      clk_ref_i : in std_logic;
      tm_i         : in  t_wrn_timing_if);
  end component wr_node_core;

  component wr_node_core_with_etherbone is
    generic (
      g_config : t_wr_node_config);
    port (
      clk_i        : in  std_logic;
      rst_n_i      : in  std_logic;
      sp_master_o  : out t_wishbone_master_out;
      sp_master_i  : in  t_wishbone_master_in                                  := cc_dummy_master_in;
      dp_master_o  : out t_wishbone_master_out_array(0 to g_config.cpu_count-1);
      dp_master_i  : in  t_wishbone_master_in_array(0 to g_config.cpu_count-1) := f_dummy_master_in_array(g_config.cpu_count);
      wr_src_o     : out t_wrf_source_out;
      wr_src_i     : in  t_wrf_source_in;
      wr_snk_o     : out t_wrf_sink_out;
      wr_snk_i     : in  t_wrf_sink_in;
      eb_config_i  : in  t_wishbone_slave_in;
      eb_config_o  : out t_wishbone_slave_out;
      host_slave_i : in  t_wishbone_slave_in;
      host_slave_o : out t_wishbone_slave_out;
      host_irq_o   : out std_logic;
      clk_ref_i : in std_logic;
      tm_i         : in  t_wrn_timing_if);
  end component wr_node_core_with_etherbone;


end wr_node_pkg;

package body wr_node_pkg is

  
  function f_dummy_master_in_array(size : integer)
    return t_wishbone_master_in_array
  is
    variable rv : t_wishbone_master_in_array(0 to size-1);
  begin
    for i in 0 to size-1 loop
      rv(i) := cc_dummy_master_in;
    end loop;  -- i

    return rv;
  end function;
  
  

end wr_node_pkg;
