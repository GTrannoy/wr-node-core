library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d3s_highpass_filter is
  generic (
    g_data_bits : integer
    );
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    x_valid_i : in std_logic;
    x_i : in  std_logic_vector(g_data_bits-1 downto 0);

    y_valid_o: out std_logic;
    y_o : out std_logic_vector(g_data_bits-1 downto 0);

    );

end d3s_highpass_filter;

architecture rtl of d3s_highpass_filter is

  signal x, x_d, y_d : signed(17 downto 0);
  signal coef        : signed(17 downto 0);

  signal x_ext, x_d_ext, y_d_mul, acc : signed (35 downto 0);

  function f_x_to_zeros(x : std_logic_vector) return std_logic_vector is
    variable rv : std_logic_vector(x'length-1 downto 0);
  begin
    -- synthesis translate_off
    for i in 0 to x'length -1 loop
      if x(i) = 'X' then
        rv(i) := '0';
      else
        rv(i) := x(i);
      end if;
    end loop;
    return rv;

    -- synthesis translate_on

    return x;
    
  end f_x_to_zeros;


begin
  x    <= resize(signed(f_x_to_zeros(x_i)), x'length);
  coef <= to_signed(g_coef, 18);

  x_ext   <= resize(x, 36) sll 18;
  x_d_ext <= resize(x_d, 36) sll 18;
  y_d_mul <= coef * y_d;
  acc     <= x_ext - x_d_ext + y_d_mul;

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        x_d <= (others => '0');
        y_d <= (others => '0');
      else
        y_d <= acc(35 downto 18);
        x_d <= x;
      end if;
    end if;
  end process;

  y_o <= std_logic_vector(y_d(g_data_bits-1 downto 0));
  
end rtl;

