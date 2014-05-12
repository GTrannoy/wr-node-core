library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.genram_pkg.all;
use work.wishbone_pkg.all;

entity wrn_shared_mem is
  
  generic (
    g_size : integer);

  port(
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out);

end wrn_shared_mem;

architecture rtl of wrn_shared_mem is

begin  -- rtl



end rtl;
