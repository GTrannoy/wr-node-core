library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wr_node_pkg.all;
use work.wrn_mqueue_pkg.all;

use work.wishbone_pkg.all;

entity mt_config_rom is
  generic(
    -- Message Queue and CPU configuration
    g_config            : t_wr_node_config := c_default_node_config;
-- When true, the CPUs can run with 2x the system clock. User design must
--    supply the clk_cpu_i signal which is in phase with the clk_i signal.
    g_double_core_clock : boolean          := false;
-- When true, the Remote Message Queue is implemented.
    g_with_rmq          : boolean          := true;
-- Frequency of clk_sys_i, in Hz
    g_system_clock_freq : integer          := 62500000;
-- Enables/disables WR support
    g_with_white_rabbit : boolean          := false;
    -- Choice of the CPU core used: LM32 or URV
    g_cpu_arch          : string           := "LM32"
    );
  port
    (
      clk_i : in  std_logic;
      rst_n_i : in std_logic;

      slave1_i : in t_wishbone_slave_in;
      slave2_i : in t_wishbone_slave_in;
      slave1_o : out t_wishbone_slave_out;
      slave2_o : out t_wishbone_slave_out
    );
end entity;

architecture rtl of mt_config_rom is

  constant c_rom_size      : integer := 256;
  type t_rom_array is array(0 to c_rom_size-1) of std_logic_vector(31 downto 0);
  constant c_mt_revision : integer := 20161208;

  function f_char_to_slv (c : character) return std_logic_vector is
  begin
    return std_logic_vector(to_unsigned(character'pos(c), 8));
  end f_char_to_slv;

  function f_bool_to_sl (x : boolean) return std_logic is
  begin
    if x then
      return '1';
    else
      return '0';
    end if;
  end f_bool_to_sl;

  function f_int_to_slv(x : integer) return std_logic_vector is
  begin
    return std_logic_vector(to_unsigned(x, 32));
  end f_int_to_slv;

  procedure f_make_mq_config (
    cfg    : out t_rom_array;
    offset :     integer;
    mq     :     t_wrn_mqueue_config
    ) is
  begin
    cfg(offset)   := f_int_to_slv(mq.in_slot_count);
    cfg(offset+1) := f_int_to_slv(mq.out_slot_count);
    for i in 0 to 15 loop
      cfg(offset + 2 * i + 2)     := f_int_to_slv(mq.in_slot_config(i).width);
      cfg(offset + 2 * i + 2 + 1) := f_int_to_slv(mq.in_slot_config(i).entries);
    end loop;
    for i in 0 to 15 loop
      cfg(offset + 32 + 2 * i + 2)     := f_int_to_slv(mq.out_slot_config(i).width);
      cfg(offset + 32 + 2 * i + 2 + 1) := f_int_to_slv(mq.out_slot_config(i).entries);
    end loop;
    
  end f_make_mq_config;

  impure function f_initialize_rom return t_rom_array is
    variable cfg : t_rom_array;
  begin
    cfg(0) := f_char_to_slv('T') & f_char_to_slv('R') & f_char_to_slv('T') & f_char_to_slv('L');
    cfg(1) := f_int_to_slv(c_mt_revision);
    if g_cpu_arch = "LM32" then
      cfg(2) := x"00000001";
    else
      cfg(2) := x"00000002";
    end if;
    cfg(3)    := f_int_to_slv(g_system_clock_freq);
    cfg(4)(0) := f_bool_to_sl(g_with_white_rabbit);
    cfg(4)(1) := f_bool_to_sl(g_with_rmq);
    cfg(4)(2) := f_bool_to_sl(g_double_core_clock);
    cfg(5)    := g_config.app_id;
    cfg(6)    := f_int_to_slv(g_config.cpu_count);
    cfg(7)    := f_int_to_slv(g_config.shared_mem_size);

    for i in 0 to 7 loop
      if (i < g_config.cpu_count) then
        cfg(i) := f_int_to_slv(g_config.cpu_memsizes(i));
      else
        cfg(i) := (others => '0');
      end if;
    end loop;

    -- word 64
    f_make_mq_config(cfg, 64, g_config.hmq_config);
    f_make_mq_config(cfg, 64 + 64 + 2, g_config.rmq_config);

    return cfg;
    
  end f_initialize_rom;

  constant c_rom_data : t_rom_array := f_initialize_rom;

begin

end rtl;
