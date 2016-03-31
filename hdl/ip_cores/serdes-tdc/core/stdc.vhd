library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.stdc_package.all;
 
entity stdc is
	port(
		-- system signals
		sys_clk_i: in std_logic;
		sys_rst_n_i: in std_logic;
		
		-- SERDES
		serdes_clk_i: in std_logic;
		serdes_strobe_i: in std_logic;
		
		-- TDC input
		signal_i: in std_logic;
		
		-- timestamp output
		detect_o: out std_logic;
		polarity_o: out std_logic;
		timestamp_8th_o: out std_logic_vector(2 downto 0)
	);
end entity;

architecture rtl of stdc is
signal samples: std_logic_vector(7 downto 0);
signal serdes_cascade: std_logic;
signal looking_for: std_logic;

begin
	-- sample input at 8x the system clock rate
	cmp_master_serdes: ISERDES2
		generic map(
			BITSLIP_ENABLE => FALSE,
			DATA_RATE => "SDR",
			DATA_WIDTH => 8,
			INTERFACE_TYPE => "RETIMED",
			SERDES_MODE => "MASTER"
		)
		port map(
			CFB0 => open,
			CFB1 => open,
			DFB => open,
			FABRICOUT => open,
			INCDEC => open,
			Q4 => samples(7),
			Q3 => samples(6),
			Q2 => samples(5),
			Q1 => samples(4),
			SHIFTOUT => serdes_cascade,
			VALID => open,
			BITSLIP => '0',
			CE0 => '1',
			CLK0 => serdes_clk_i,
			CLK1 => '0',
			CLKDIV => sys_clk_i,
			D => signal_i,
			IOCE => serdes_strobe_i,
			RST => '0',
			SHIFTIN => '0'
		);
	cmp_slave_serdes: ISERDES2
		generic map(
			BITSLIP_ENABLE => FALSE,
			DATA_RATE => "SDR",
			DATA_WIDTH => 8,
			INTERFACE_TYPE => "RETIMED",
			SERDES_MODE => "SLAVE"
		)
		port map(
			CFB0 => open,
			CFB1 => open,
			DFB => open,
			FABRICOUT => open,
			INCDEC => open,
			Q4 => samples(3),
			Q3 => samples(2),
			Q2 => samples(1),
			Q1 => samples(0),
			SHIFTOUT => open,
			VALID => open,
			BITSLIP => '0',
			CE0 => '1',
			CLK0 => serdes_clk_i,
			CLK1 => '0',
			CLKDIV => sys_clk_i,
			D => '0',
			IOCE => serdes_strobe_i,
			RST => '0',
			SHIFTIN => serdes_cascade
		);
	
	-- analyse samples and generate events
	process(sys_clk_i)
	begin
		if rising_edge(sys_clk_i) then
			if sys_rst_n_i = '0' then
				detect_o <= '0';
				polarity_o <= '0';
				timestamp_8th_o <= (timestamp_8th_o'range => '0');
				looking_for <= '1';
			else
				detect_o <= '0';
				for i in 0 to 7 loop
					if samples(i) = looking_for then
						detect_o <= '1';
						polarity_o <= looking_for;
						timestamp_8th_o <= std_logic_vector(to_unsigned(i, 3));
						exit;
					end if;
				end loop;
				looking_for <= not samples(7);
			end if;
		end if;
	end process;

end architecture;
