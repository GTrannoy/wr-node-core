library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.genram_pkg.all;

entity gc_prog_delay is
  generic
    (
      g_width          : integer := 16;
      g_max_depth_log2 : integer := 16);

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    d_i : in  std_logic_vector(g_width-1 downto 0);
    q_o : out std_logic_vector(g_width-1 downto 0);

    delay_setpoint_i : std_logic_vector(g_max_depth_log2-1 downto 0)
    );

end gc_prog_delay;

architecture rtl of gc_prog_delay is

  signal wr_ptr, rd_ptr : unsigned(g_max_depth_log2-1 downto 0);
  signal init : std_logic;
begin

  U_Delay_line : generic_dpram
    generic map (
      g_data_width       => g_width,
      g_size             => 2 ** g_max_depth_log2,
      g_with_byte_enable => false,
      g_dual_clock       => false)
    port map (
      rst_n_i => rst_n_i,
      clka_i  => clk_i,
      wea_i   => '1',
      aa_i    => std_logic_vector(wr_ptr),
      da_i    => d_i,
      clkb_i  => clk_i,
      web_i   => '0',
      ab_i    => std_logic_vector(rd_ptr),
      qb_o    => q_o);

  p_counters : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        wr_ptr <= (others => '0');
        rd_ptr <= (others => '0');
        init <= '1';
      else
        wr_ptr <= wr_ptr + 1;
        rd_ptr <= wr_ptr - unsigned(delay_setpoint_i) + 1;
      end if;
    end if;
  end process;
  
  
end rtl;
