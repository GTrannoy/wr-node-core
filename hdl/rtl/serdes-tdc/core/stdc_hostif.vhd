library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.stdc_wbgen2_pkg.all;

entity stdc_hostif is
  generic(
    D_DEPTH : positive;
    D_WIDTH : positive
    );
  port(
    -- system signals
    sys_rst_n_i : in std_logic;
    clk_sys_i   : in std_logic;
    clk_125m_i  : in std_logic;

    -- SERDES
    serdes_clk_i    : in std_logic;
    serdes_strobe_i : in std_logic;

    -- Wishbone
    wb_addr_i  : in  std_logic_vector(31 downto 0);
    wb_data_i  : in  std_logic_vector(31 downto 0);
    wb_data_o  : out std_logic_vector(31 downto 0);
    wb_cyc_i   : in  std_logic;
    wb_sel_i   : in  std_logic_vector(3 downto 0);
    wb_stb_i   : in  std_logic;
    wb_we_i    : in  std_logic;
    wb_ack_o   : out std_logic;
    wb_stall_o : out std_logic;

    -- TDC input
    stdc_input_i : in std_logic;

    -- Timing stamps
    tai_i     : in  std_logic_vector(39 downto 0);
    cycles_i  : in  std_logic_vector(27 downto 0);

    -- TDC outputs                      
    strobe_o  : out std_logic;
    ts_nsec_o : out std_logic_vector(30 downto 0);  -- before was "stdc_data_o"
    ts_tai_o  : out std_logic_vector(39 downto 0)
    
	 -- ChipScope Signals
--    TRIG_O : out std_logic_vector(127 downto 0)
    );
end entity;

architecture rtl of stdc_hostif is

  component stdc is
    port(
      sys_clk_i       : in  std_logic;
      sys_rst_n_i     : in  std_logic;
      serdes_clk_i    : in  std_logic;
      serdes_strobe_i : in  std_logic;
      stdc_input_i    : in  std_logic;
      detect_o        : out std_logic;
      polarity_o      : out std_logic;
      timestamp_8th_o : out std_logic_vector(2 downto 0)
      );
  end component;

  component stdc_fifo is
    generic(
      D_DEPTH : positive;
      D_WIDTH : positive
      );
    port(
      sys_clk_i : in std_logic;

      clear_i : in std_logic;

      full_o : out std_logic;
      we_i   : in  std_logic;
      data_i : in  std_logic_vector(D_WIDTH-1 downto 0);

      empty_o : out std_logic;
      re_i    : in  std_logic;
      data_o  : out std_logic_vector(D_WIDTH-1 downto 0)
      );
  end component;

  component stdc_wb_slave is
    port (
      rst_n_i   : in std_logic;
      clk_sys_i : in std_logic;

      -- Wishbone interface
      wb_adr_i   : in  std_logic_vector(2 downto 0);
      wb_dat_i   : in  std_logic_vector(31 downto 0);
      wb_dat_o   : out std_logic_vector(31 downto 0);
      wb_cyc_i   : in  std_logic;
      wb_sel_i   : in  std_logic_vector(3 downto 0);
      wb_stb_i   : in  std_logic;
      wb_we_i    : in  std_logic;
      wb_ack_o   : out std_logic;
      wb_stall_o : out std_logic;
      regs_i     : in  t_stdc_in_registers;
      regs_o     : out t_stdc_out_registers);
  end component;

  signal detect        : std_logic;
  signal polarity      : std_logic;
  signal timestamp_8th : std_logic_vector(2 downto 0);
  signal timestamp_8th_reg : std_logic_vector(2 downto 0);
  signal cycles_reg    : std_logic_vector(27 downto 0);
  signal tai_reg       : std_logic_vector(39 downto 0);

  signal got_a_pulse   : std_logic;

  signal fifo_clear    : std_logic;
  signal fifo_full     : std_logic;
  signal fifo_we       : std_logic;
  signal fifo_di       : std_logic_vector(D_WIDTH-1 downto 0);
  signal fifo_empty    : std_logic;
  signal fifo_re       : std_logic;
  signal fifo_do       : std_logic_vector(D_WIDTH-1 downto 0);

  signal regs_i : t_stdc_in_registers;
  signal regs_o : t_stdc_out_registers;


begin


  -- instantiate basic TDC core
  cmp_stdc : stdc
    port map(
      sys_clk_i       => clk_125m_i,
      sys_rst_n_i     => sys_rst_n_i,
      serdes_clk_i    => serdes_clk_i,
      serdes_strobe_i => serdes_strobe_i,
      stdc_input_i    => stdc_input_i,
      detect_o        => detect,
      polarity_o      => polarity,
      timestamp_8th_o => timestamp_8th
      );

  -- FIFO
  cmp_fifo : stdc_fifo
    generic map(
      D_DEPTH => D_DEPTH,
      D_WIDTH => D_WIDTH 
      )
    port map(
      sys_clk_i => clk_125m_i,
      clear_i   => fifo_clear,
      full_o    => fifo_full,
      we_i      => fifo_we,
      data_i    => fifo_di,
      empty_o   => fifo_empty,
      re_i      => fifo_re,
      data_o    => fifo_do
      );

  -- instantiate the wb interface generated with Wbgen2
  comp_stdc_wb_slave : stdc_wb_slave
    port map(
      rst_n_i    => sys_rst_n_i,
      clk_sys_i  => clk_sys_i,
      wb_adr_i   => wb_addr_i(4 downto 2),
      wb_dat_i   => wb_data_i,
      wb_dat_o   => wb_data_o,
      wb_cyc_i   => wb_cyc_i,
      wb_sel_i   => wb_sel_i,
      wb_stb_i   => wb_stb_i,
      wb_we_i    => wb_we_i,
      wb_ack_o   => wb_ack_o,
      wb_stall_o => wb_stall_o,
      regs_i     => regs_i,
      regs_o     => regs_o
      );


  -- if next =1 and fifo not empty, send to tdc_data next fifo element
  regs_i.tdc_polarity_i <= fifo_do(72);
  regs_i.tdc_ts_tai_h_i (31 downto 8) <= (others =>'0');
  regs_i.tdc_ts_tai_h_i ( 7 downto 0) <= fifo_do(71 downto 64);
  regs_i.tdc_ts_tai_l_i <= fifo_do(63 downto 32);
  regs_i.tdc_ts_ns_i    <= '0' & fifo_do(31 downto  4) & fifo_do(2 downto  0); -- fifo_di(3)='0' removed

  -- if clear command, send a reset to the fifo
  fifo_clear <= regs_o.ctrl_clr_o or (not(sys_rst_n_i));

  -- fill status registers
  regs_i.status_empty_i <= fifo_empty;
  regs_i.status_ovf_i   <= fifo_we and fifo_full;

  -- FIFO data structure:
  --     ------------------------------------------------------------------
  --     |  Edge polarity  |  TAI   |   WR Cycles  |  ns within WR_cycle  |
  --     ------------------------------------------------------------------
  --  Edge polarity:        1 bit   (72) 
  --  TAI:                 40 bits  (71 downto 32)
  --  WR Cycles:           28 bits  (31 downto 4)
  --  ns withing WR_cycle:  4 bits  ( 3 downto 0)
  
  pc_reg_fifo_xclk_hdl : process (clk_125m_i)
  begin
    if rising_edge(clk_125m_i) then
       if sys_rst_n_i = '0' then
          fifo_we <= '0';
          fifo_re <= '0';
       else
          -- if enabled edge detected write in the fifo       
          fifo_we <= got_a_pulse;
          fifo_re <= regs_o.ctrl_next_o and not(fifo_re);
          if got_a_pulse = '1' then
             fifo_di(72)           <= polarity;
             fifo_di(71 downto 32) <= tai_reg ;
             fifo_di(31 downto  4) <= cycles_reg;  
             fifo_di( 3 downto  0) <= '0' & timestamp_8th_reg; -- '0' added for readability in the simul!
          end if;
       end if;
    end if;
  end process;


  ts_nsec_o   <= cycles_reg & timestamp_8th_reg;
  ts_tai_o    <= tai_reg; 
  strobe_o    <= fifo_we;

  p_reg_cycles : process(sys_rst_n_i, clk_125m_i)
  begin
    if sys_rst_n_i = '0' then
       cycles_reg <= (others => '0');
       tai_reg    <= (others => '0');
       -- Filter the edges w.r.t. the polarity programmed
       got_a_pulse <= '0';
    elsif rising_edge(clk_125m_i) then
       -- Filter the edges w.r.t. the polarity programmed
       got_a_pulse <= detect and ((polarity and regs_o.ctrl_filter_o(0)) or (not polarity and regs_o.ctrl_filter_o(1)));
       if detect = '1' then
          if (unsigned(timestamp_8th) <= 4) then
             -- timestamp_8th is measured w.r.t. serializer serdestrobe signal
              -- We wish it w.r.t. WRcycl change
              timestamp_8th_reg <= std_logic_vector(unsigned(timestamp_8th) + 3);  
              if (unsigned(cycles_i) > 3) then
                 -- 'got_a_pulse' takes 3 WR cycles that we should substract
                 cycles_reg <= std_logic_vector(unsigned(cycles_i)-3);
                 tai_reg    <= tai_i; 
              else
                 tai_reg    <= std_logic_vector(unsigned(tai_i)-1);
                 cycles_reg <= std_logic_vector(unsigned(cycles_i)-3+125000000);
              end if;
          else  
             -- timestamp_8th is measured w.r.t. serializer serdestrobe signal
             -- but we wish to measure w.r.t. the WRcyc that in this case just change +1
             timestamp_8th_reg <= std_logic_vector(unsigned(timestamp_8th) -5); 
             if (unsigned(cycles_i) > 2) then
                cycles_reg <= std_logic_vector(unsigned(cycles_i)-2);
                tai_reg    <= tai_i;             
             else           
                tai_reg    <= std_logic_vector(unsigned(tai_i)-1);
                cycles_reg <= std_logic_vector(unsigned(cycles_i)-2 + 125000000);
             end if;
          end if;  
       end if;
    end if;
  end process;
  
end architecture;
