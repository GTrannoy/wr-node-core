library ieee;
use ieee.std_logic_1164.all;

library work;
use work.stdc_package.all;
use work.stdc_hostif_package.all;
use work.stdc_wbgen2_pkg.all;

entity stdc_hostif is
	port(
		-- system signals
		sys_rst_n_i: in std_logic;
		sys_clk_i: in std_logic;
		
		-- SERDES
		serdes_clk_i: in std_logic;
		serdes_strobe_i: in std_logic;
		
		-- Wishbone
		wb_addr_i: in std_logic_vector(31 downto 0);
		wb_data_i: in std_logic_vector(31 downto 0);
		wb_data_o: out std_logic_vector(31 downto 0);
		wb_cyc_i: in std_logic;
		wb_sel_i: in std_logic_vector(3 downto 0);
		wb_stb_i: in std_logic;
		wb_we_i: in std_logic;
		wb_ack_o: out std_logic;
		wb_stall_o : out std_logic;
		
		-- TDC input
		signal_i: in std_logic;
		
		-- 125Mhz tick
		cycles_i: in std_logic_vector(27 downto 0)
	);
end entity;

architecture rtl of stdc_hostif is

	component stdc_wb_slave is
		port (
			rst_n_i        : in     std_logic;
			clk_sys_i      : in     std_logic;
			wb_adr_i       : in     std_logic_vector(1 downto 0);
			wb_dat_i       : in     std_logic_vector(31 downto 0);
			wb_dat_o       : out    std_logic_vector(31 downto 0);
			wb_cyc_i       : in     std_logic;
			wb_sel_i       : in     std_logic_vector(3 downto 0);
			wb_stb_i       : in     std_logic;
			wb_we_i        : in     std_logic;
			wb_ack_o       : out    std_logic;
			wb_stall_o     : out    std_logic;
			regs_i         : in     t_stdc_in_registers;
			regs_o         : out    t_stdc_out_registers);
	end component;

signal detect: std_logic;
signal polarity: std_logic;
signal timestamp_8th: std_logic_vector(2 downto 0);

signal fifo_clear: std_logic;
signal fifo_full: std_logic;
signal fifo_we: std_logic;
signal fifo_di: std_logic_vector(31 downto 0);
signal fifo_empty: std_logic;
signal fifo_re: std_logic;
signal fifo_do: std_logic_vector(31 downto 0);

signal regs_i: t_stdc_in_registers;
signal regs_o: t_stdc_out_registers;

begin
	-- instantiate basic TDC core
	cmp_stdc: stdc
		port map(
			sys_clk_i 		 => sys_clk_i,
			sys_rst_n_i 	 => sys_rst_n_i,
			serdes_clk_i 	 => serdes_clk_i,
			serdes_strobe_i => serdes_strobe_i,
			signal_i 		 => signal_i,
			detect_o 		 => detect,
			polarity_o 		 => polarity,
			timestamp_8th_o => timestamp_8th
		);
	
	-- FIFO
	cmp_fifo: stdc_fifo
		generic map(
			D_DEPTH => 10,
			D_WIDTH => 32
		)
		port map(
			sys_clk_i => sys_clk_i,
			clear_i 	=> fifo_clear,
			full_o 	=> fifo_full,
			we_i 		=> fifo_we,
			data_i 	=> fifo_di,
			empty_o 	=> fifo_empty,
			re_i 		=> fifo_re,
			data_o 	=> fifo_do
		);
		
	-- instantiate the wb interface generated with wbgen2
	comp_stdc_wb_slave: stdc_wb_slave
		port map(
			rst_n_i 		=>  sys_rst_n_i,
			clk_sys_i 	=>  sys_clk_i,
			wb_adr_i 	=>  wb_addr_i(1 downto 0),
			wb_dat_i 	=>  wb_data_i,
			wb_dat_o 	=>  wb_data_o,
			wb_cyc_i 	=>  wb_cyc_i,
			wb_sel_i 	=>  wb_sel_i,
			wb_stb_i 	=>  wb_stb_i,
			wb_we_i 		=>  wb_we_i,
			wb_ack_o 	=>  wb_ack_o,
			wb_stall_o 	=>  wb_stall_o,
			regs_i 		=>  regs_i,
			regs_o 		=>  regs_o
		);
		
	-- if enabled edge detected write in the fifo	
	fifo_we <= detect and ((polarity and regs_o.ctrl_filter_o(0)) or (not polarity and regs_o.ctrl_filter_o(1)));
	fifo_di <= polarity & cycles_i & timestamp_8th;
	
	-- if next =1 and fifo not empty, send to tdc_data next fifo element
	fifo_re <= regs_o.ctrl_next_o and (not fifo_empty);
	regs_i.tdc_data_i <= fifo_do;
	
	-- if clear command, send a reset to the fifo
	fifo_clear <= regs_o.ctrl_clr_o;
	
	-- fill status registers
	regs_i.status_noempty_i <= fifo_empty;
	regs_i.status_ovf_i <= fifo_we and fifo_full;
	
end architecture;
