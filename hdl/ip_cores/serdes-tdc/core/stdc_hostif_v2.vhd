library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.stdc_package.all;
use work.stdc_hostif_package.all;
use work.stdc_wbgen2_pkg.all;

entity stdc_hostif is
	generic(
		D_DEPTH: positive
	);
	port(
		-- system signals
		sys_rst_n_i: in std_logic;
		clk_sys_i: in std_logic;
		clk_125m_i: in std_logic;
		
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
		cycles_i: in std_logic_vector(27 downto 0);
		
		-- TDC outputs			
		strobe_o         : out    std_logic;
		stdc_data_o       : out    std_logic_vector(31 downto 0);
		
		-- ChipScope Signals
		TRIG_O			: out std_logic_vector(127 downto 0)
	);
end entity;

architecture rtl of stdc_hostif is

	component stdc_wb_slave is
		port (
			rst_n_i        : in     std_logic;
			clk_sys_i      : in     std_logic;
			
			-- Wishbone interface
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
signal timestamp_8th, timestamp_resync: std_logic_vector(2 downto 0);

signal fifo_clear: std_logic;
signal fifo_full: std_logic;
signal fifo_we: std_logic;
signal fifo_di: std_logic_vector(31 downto 0);
signal fifo_empty: std_logic;
signal fifo_re: std_logic;
signal fifo_do: std_logic_vector(31 downto 0);

signal regs_i: t_stdc_in_registers;
signal regs_o: t_stdc_out_registers;

signal cycles_reg: std_logic_vector(27 downto 0);  
-- signal dbg_cycles_slv: std_logic_vector(27 downto 0);  -- for debugging only

signal signal_reg, signal_reg2, en: std_logic;

--  component chipscope_ila
--    port (
--      CONTROL : inout std_logic_vector(35 downto 0);
--      CLK     : in    std_logic;
--      TRIG0   : in    std_logic_vector(31 downto 0);
--      TRIG1   : in    std_logic_vector(31 downto 0);
--      TRIG2   : in    std_logic_vector(31 downto 0);
--      TRIG3   : in    std_logic_vector(31 downto 0));
--  end component;
--
--  component chipscope_icon
--    port (
--      CONTROL0 : inout std_logic_vector (35 downto 0));
--  end component;
--
--  signal CONTROL     : std_logic_vector(35 downto 0);
--  signal TRIG        : std_logic_vector(127 downto 0);

begin
	
	-- Debugging part -----
--  chipscope_icon_1: chipscope_icon
--    port map (
--      CONTROL0 => CONTROL);
--
--  chipscope_ila_1: chipscope_ila
--    port map (
--      CONTROL => CONTROL,
--      CLK     => clk_125m_i,
--      TRIG0   => TRIG(31 downto 0),
--      TRIG1   => TRIG(63 downto 32),
--      TRIG2   => TRIG(95 downto 64),
--      TRIG3   => TRIG(127 downto 96));
		
   TRIG_O(31 downto 0)  <= fifo_di ;
	--TRIG_O(63 downto 32) <= fifo_do; 
	TRIG_O(59 downto 32) <= fifo_do(27 downto 0) ;
	
	TRIG_O(60) <= fifo_re ;
	TRIG_O(61) <= signal_i ;
	TRIG_O(62) <= signal_reg ;
	TRIG_O(63) <= signal_reg2 ;
   TRIG_O(64) <= en ;
		
   TRIG_O(65) <= detect ;
	TRIG_O(93 downto 66) <= cycles_i ;
		
	TRIG_O(96 downto 94) <= timestamp_resync ;
	TRIG_O(124 downto 97) <= cycles_reg ;
	
	TRIG_O(125) <= fifo_full ;
	TRIG_O(126) <= fifo_we ;
	TRIG_O(127) <= polarity ;
		
	-- Debugging part end ------
	
	
	-- instantiate basic TDC core
	cmp_stdc: stdc
		port map(
			sys_clk_i 		 => clk_125m_i,  
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
			D_DEPTH => D_DEPTH,
			D_WIDTH => 32
		)
		port map(
			sys_clk_i => clk_125m_i,  
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
			clk_sys_i 	=>  clk_sys_i,
			wb_adr_i 	=>  wb_addr_i(3 downto 2),
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
		
		
--	fifo_di <= polarity & std_logic_vector(unsigned(cycles_reg)-0) & timestamp_resync when timestamp_resync(2)='0' else
--	           polarity & std_logic_vector(unsigned(cycles_reg)-1) & timestamp_resync;
	
	timestamp_resync <= std_logic_vector(unsigned(timestamp_8th)+1);
		
	-- if next =1 and fifo not empty, send to tdc_data next fifo element
	regs_i.tdc_data_i <= fifo_do;
	
	-- if clear command, send a reset to the fifo
	fifo_clear <= regs_o.ctrl_clr_o or (not(sys_rst_n_i));
	
	-- fill status registers
	regs_i.status_empty_i <= fifo_empty ;
	regs_i.status_ovf_i   <= fifo_we and fifo_full ;
	
	pc_reg_fifo_xclk_hdl: process (sys_rst_n_i, clk_125m_i)
	begin
	    if sys_rst_n_i = '0' then
				fifo_we <= '0';
            fifo_re <= '0';
       elsif rising_edge(clk_125m_i) then 
		    -- if enabled edge detected write in the fifo	  
	       fifo_we <= detect and ((polarity and regs_o.ctrl_filter_o(0)) or (not polarity and regs_o.ctrl_filter_o(1)));
	       fifo_re <= regs_o.ctrl_next_o and not(fifo_re); 
          if detect = '1' then
				  if (timestamp_resync(2)='0') then
				       fifo_di <= polarity & std_logic_vector(unsigned(cycles_reg)-1) & timestamp_resync ;
			     else
	                fifo_di <= polarity & std_logic_vector(unsigned(cycles_reg)-2) & timestamp_resync ;
				  end if;
			 end if;
	    end if;
	end process;
	
	stdc_data_o <= fifo_di;  
	strobe_o <= fifo_we;     
	
	p_reg_cycles: process(sys_rst_n_i, clk_125m_i)
   begin
       if sys_rst_n_i = '0' then
          signal_reg  <= '0' ;
			 signal_reg2  <= '0' ;
			 cycles_reg  <= (cycles_reg'range => '0') ;
			 
       elsif rising_edge(clk_125m_i) then
          signal_reg  <= signal_i ;
			 signal_reg2  <= signal_reg ;
			 if en = '1' then
             cycles_reg <= cycles_i ; -- dbg_cycles_slv; --(dbg_cycles_slv only used for simulation)
          end if;
       end if;
  end process;

  en <= signal_reg xor signal_reg2 ;  --  Edge detector
	
	
--  ********* For debugging only. Remove later!!
--  p_debugging_counter: process(sys_rst_n_i, clk_125m_i)
--  begin
--    if sys_rst_n_i = '0' then
--      dbg_cycles_slv <= (dbg_cycles_slv'range => '0');
--    elsif rising_edge(clk_125m_i) then
--      dbg_cycles_slv <= std_logic_vector(unsigned(dbg_cycles_slv)+1); 
--    end if;
--  end process;
		
		
end architecture;
