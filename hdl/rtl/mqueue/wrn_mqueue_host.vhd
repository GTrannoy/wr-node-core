library ieee;
use ieee.std_logic_1164.all;

use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;

entity wrn_mqueue_host is
  generic (
    g_config : t_wrn_mqueue_config := c_wrn_default_mqueue_config
    );

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    si_slave_i : in  t_wishbone_slave_in;
    si_slave_o : out t_wishbone_slave_out;

    host_slave_i : in  t_wishbone_slave_in;
    host_slave_o : out t_wishbone_slave_out;
    host_irq_o   : out std_logic;

    hmq_status_o : out std_logic_vector(15 downto 0)
    );

end wrn_mqueue_host;

architecture rtl of wrn_mqueue_host is

  signal si_incoming_in, host_incoming_in   : t_slot_bus_in_array(0 to g_config.in_slot_count-1);
  signal si_incoming_out, host_incoming_out : t_slot_bus_out_array(0 to g_config.in_slot_count-1);
  signal si_outgoing_in, host_outgoing_in   : t_slot_bus_in_array(0 to g_config.out_slot_count-1);
  signal si_outgoing_out, host_outgoing_out : t_slot_bus_out_array(0 to g_config.out_slot_count-1);

  signal incoming_stat : t_slot_status_out_array(0 to g_config.in_slot_count-1);
  signal outgoing_stat : t_slot_status_out_array(0 to g_config.out_slot_count-1);

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

  -- CB to Host direction (outgoing slots)
  gen_outgoing_slots : for i in 0 to g_config.out_slot_count-1 generate

    U_Out_SlotX : wrn_mqueue_slot
      generic map (
        g_entries => g_config.out_slot_config(i).entries,
        g_width   => g_config.out_slot_config(i).width)
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_n_i,
        stat_o  => outgoing_stat(i),
        inb_i   => si_outgoing_in(i),
        inb_o   => si_outgoing_out(i),
        outb_i  => host_outgoing_in(i),
        outb_o  => host_outgoing_out(i));

  end generate gen_outgoing_slots;

  -- Host to CB direction (incoming slots)
  gen_incoming_slots : for i in 0 to g_config.in_slot_count-1 generate

    U_In_SlotX : wrn_mqueue_slot
      generic map (
        g_entries => g_config.in_slot_config(i).entries,
        g_width   => g_config.in_slot_config(i).width)
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_n_i,
        stat_o  => incoming_stat(i),
        inb_i   => host_incoming_in(i),
        inb_o   => host_incoming_out(i),
        outb_i  => si_incoming_in(i),
        outb_o  => si_incoming_out(i));

    hmq_status_o (i) <= not incoming_stat(i).empty;

  end generate gen_incoming_slots;
  
  U_Host_Wishbone_Slave : wrn_mqueue_wishbone_slave
    generic map (
      g_with_gcr => true,
      g_config   => g_config)
    port map (
      clk_i             => clk_i,
      rst_n_i           => rst_n_i,
      incoming_status_i => incoming_stat,
      outgoing_status_i => outgoing_stat,

      incoming_o => host_incoming_in,
      incoming_i => host_incoming_out,
      outgoing_o => host_outgoing_in,
      outgoing_i => host_outgoing_out,

      slave_i => host_slave_i,
      slave_o => host_slave_o);

  
end rtl;
