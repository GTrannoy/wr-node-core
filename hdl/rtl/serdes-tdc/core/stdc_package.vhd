library ieee;
use ieee.std_logic_1164.all;

package stdc_package is

component stdc is
	port(
		sys_clk_i: in std_logic;
		sys_rst_n_i: in std_logic;		
		serdes_clk_i: in std_logic;
		serdes_strobe_i: in std_logic;		
		signal_i: in std_logic;
		detect_o: out std_logic;
		polarity_o: out std_logic;
		timestamp_8th_o: out std_logic_vector(2 downto 0)
	);
end component;

end package;
 
