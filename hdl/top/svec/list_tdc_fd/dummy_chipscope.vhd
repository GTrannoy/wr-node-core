library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity dummy_chipscope is
  port (
    clk_i : in std_logic);
end entity;


architecture rtl of dummy_chipscope is
  component chipscope_ila
    port (
      CONTROL : inout std_logic_vector(35 downto 0);
      CLK     : in    std_logic;
      TRIG0   : in    std_logic_vector(31 downto 0);
      TRIG1   : in    std_logic_vector(31 downto 0);
      TRIG2   : in    std_logic_vector(31 downto 0);
      TRIG3   : in    std_logic_vector(31 downto 0));
  end component;

  component chipscope_icon
    port (
      CONTROL0 : inout std_logic_vector (35 downto 0));
  end component;

  signal CONTROL : std_logic_vector(35 downto 0);
  signal CLK     : std_logic;
  signal trig    : std_logic_vector(127 downto 0);

  attribute keep         : string;
  attribute keep of trig : signal is "true";
begin

  chipscope_icon_1 : chipscope_icon
    port map (
      CONTROL0 => CONTROL);

  chipscope_ila_1 : chipscope_ila
    port map (
      CONTROL => CONTROL,
      CLK     => clk_i,
      TRIG0   => TRIG(31 downto 0),
      TRIG1   => TRIG(63 downto 32),
      TRIG2   => TRIG(95 downto 64),
      TRIG3   => TRIG(127 downto 96));

  gen_dummy_io : for i in 0 to 127 generate
    FD_1 : FD
      port map (
        Q => TRIG(i),
        C => clk_i,
        D => '0');
  end generate gen_dummy_io;
  
end rtl;
