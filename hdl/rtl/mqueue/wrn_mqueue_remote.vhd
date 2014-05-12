library ieee;
use ieee.std_logic_1164.all;

use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;

entity wrn_mqueue_remote is
  generic (
    g_config : t_wrn_mqueue_config := c_wrn_default_mqueue_config
    );

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    si_slave_i : in  t_wishbone_slave_in;
    si_slave_o : out t_wishbone_slave_out;

    ebm_master_o : out t_wishbone_master_out;
    ebm_master_i : in  t_wishbone_master_in := cc_dummy_master_in;

    ebs_slave_o : out t_wishbone_slave_out;
    ebs_slave_i : in  t_wishbone_slave_in := cc_dummy_slave_in;

    rmq_status_o : out std_logic_vector(15 downto 0)
    );

end wrn_mqueue_remote;

architecture rtl of wrn_mqueue_remote is

  component wrn_mqueue_etherbone_output
    generic (
      g_config : t_wrn_mqueue_config);
    port (
      clk_i        : in  std_logic;
      rst_n_i      : in  std_logic;
      slots_i      : in  t_slot_bus_out_array(0 to g_config.out_slot_count-1);
      slots_o      : out t_slot_bus_in_array(0 to g_config.out_slot_count-1);
      stat_i       : in  t_slot_status_out_array(0 to g_config.out_slot_count-1);
      discard_o    : out std_logic_vector(g_config.out_slot_count-1 downto 0);
      ebm_o        : out t_wishbone_master_out;
      ebm_i        : in  t_wishbone_master_in := cc_dummy_master_in;
      host_slave_i : in  t_wishbone_slave_in;
      host_slave_o : out t_wishbone_slave_out);
  end component;

  signal si_incoming_in, eb_incoming_in   : t_slot_bus_in_array(0 to g_config.in_slot_count-1);
  signal si_incoming_out, eb_incoming_out : t_slot_bus_out_array(0 to g_config.in_slot_count-1);
  signal si_outgoing_in, eb_outgoing_in   : t_slot_bus_in_array(0 to g_config.out_slot_count-1);
  signal si_outgoing_out, eb_outgoing_out : t_slot_bus_out_array(0 to g_config.out_slot_count-1);

  signal incoming_stat : t_slot_status_out_array(0 to g_config.in_slot_count-1);
  signal outgoing_stat : t_slot_status_out_array(0 to g_config.out_slot_count-1);

  signal eb_outgoing_discard : std_logic_vector(g_config.out_slot_count-1 downto 0);
  
  
begin  -- rtl

  U_SI_Wishbone_Slave : wrn_mqueue_wishbone_slave
    generic map (
      g_with_gcr => false,
      g_config   => g_config)
    port map (
      clk_i             => clk_i,
      rst_n_i           => rst_n_i,
      incoming_status_i => incoming_stat,
      outgoing_status_i => outgoing_stat,

      incoming_o => si_incoming_in,
      incoming_i => si_incoming_out,
      outgoing_o => si_outgoing_in,
      outgoing_i => si_outgoing_out,

      slave_i => si_slave_i,
      slave_o => si_slave_o);

  -- CB to Etherbone direction (outgoing slots)
  gen_outgoing_slots : for i in 0 to g_config.out_slot_count-1 generate

    U_Out_SlotX : wrn_mqueue_slot
      generic map (
        g_entries => g_config.in_slot_config(i).entries,
        g_width   => g_config.in_slot_config(i).width)
      port map (
        clk_i     => clk_i,
        rst_n_i   => rst_n_i,
        stat_o    => outgoing_stat(i),
        inb_i     => si_outgoing_in(i),
        inb_o     => si_outgoing_out(i),
        outb_i    => eb_outgoing_in(i),
        outb_o    => eb_outgoing_out(i),
        out_discard_i => eb_outgoing_discard(i));

  end generate gen_outgoing_slots;

  U_EB_Output : wrn_mqueue_etherbone_output
    generic map (
      g_config => g_config)
    port map (
      clk_i        => clk_i,
      rst_n_i      => rst_n_i,
      slots_i      => eb_outgoing_out,
      slots_o      => eb_outgoing_in,
      stat_i       => outgoing_stat,
      discard_o    => eb_outgoing_discard,
      ebm_o        => ebm_master_o,
      ebm_i        => ebm_master_i,
      host_slave_i => cc_dummy_slave_in);

end rtl;
