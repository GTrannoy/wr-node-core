library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

use work.genram_pkg.all;

entity wrn_cpu_iram is
  
  generic (
    g_size : integer);

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    aa_i : in std_logic_vector(f_log2_size(g_size)-1 downto 0);
    ab_i : in std_logic_vector(f_log2_size(g_size)-1 downto 0);

    da_i : in std_logic_vector(31 downto 0);
    db_i : in std_logic_vector(31 downto 0);

    qa_o : out std_logic_vector(31 downto 0);
    qb_o : out std_logic_vector(31 downto 0);

    ena_i : in std_logic;
    enb_i : in std_logic;

    bwea_i : in std_logic_vector(3 downto 0);
    bweb_i : in std_logic_vector(3 downto 0);

    wea_i : in std_logic;
    web_i : in std_logic
    );

end wrn_cpu_iram;

architecture rtl of wrn_cpu_iram is
  constant c_num_bytes : integer := 4;

  

  type t_ram_type is array(0 to g_size - 1) of std_logic_vector(7 downto 0);
  type t_ram_byte_array is array(0 to 3) of t_ram_type;

  function f_empty_ram_array return t_ram_byte_array is
    variable rv : t_ram_byte_array;
    begin
      for i in 0 to g_size-1 loop
        rv(0)(i) := x"00";
        rv(1)(i) := x"00";
        rv(2)(i) := x"00";
        rv(3)(i) := x"00";
      end loop;  -- i
      return rv;
    end function;
  
  shared variable iram : t_ram_byte_array := f_empty_ram_array;

  signal wea_rep, web_rep, s_we_a, s_we_b : std_logic_vector(c_num_bytes-1 downto 0);

begin  -- rtl

  wea_rep <= (others => wea_i);
  web_rep <= (others => web_i);

  s_we_a <= bwea_i and wea_rep;
  s_we_b <= bweb_i and web_rep;

  gen_ram_byteselects : for i in 0 to 3 generate
    process(clk_i)
    begin
      if rising_edge(clk_i) then
        if(ena_i = '1') then
          if(s_we_a(i) = '1') then
            iram(i)(to_integer(unsigned(aa_i))) := da_i(i*8+7 downto i*8);
            qa_o(i*8+7 downto i*8)              <= da_i(i*8+7 downto i*8);
          else
            qa_o(i*8+7 downto i*8) <= iram(i)(to_integer(unsigned(aa_i)));
          end if;
        end if;
        if(enb_i = '1') then
          if(s_we_b(i) = '1') then
            iram(i)(to_integer(unsigned(ab_i))) := db_i(i*8+7 downto i*8);
            qb_o(i*8+7 downto i*8)              <= db_i(i*8+7 downto i*8);
          else
            qb_o(i*8+7 downto i*8) <= iram(i)(to_integer(unsigned(ab_i)));
          end if;
        end if;
      end if;
    end process;
  end generate gen_ram_byteselects;

end rtl;
