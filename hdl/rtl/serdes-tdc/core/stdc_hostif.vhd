library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.stdc_wbgen2_pkg.all;

entity stdc_hostif is
  generic(
    D_DEPTH : positive
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

    -- 125Mhz tick
    cycles_i : in std_logic_vector(27 downto 0);

    -- TDC outputs                      
    strobe_o    : out std_logic;
    stdc_data_o : out std_logic_vector(31 downto 0);

    -- ChipScope Signals
    TRIG_O : out std_logic_vector(127 downto 0)
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
      wb_adr_i   : in  std_logic_vector(1 downto 0);
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

  signal detect                          : std_logic;
  signal polarity                        : std_logic;
  signal timestamp_8th, timestamp_resync : std_logic_vector(2 downto 0);

  signal fifo_clear : std_logic;
  signal fifo_full  : std_logic;
  signal fifo_we    : std_logic;
  signal fifo_di    : std_logic_vector(31 downto 0);
  signal fifo_empty : std_logic;
  signal fifo_re    : std_logic;
  signal fifo_do    : std_logic_vector(31 downto 0);

  signal regs_i : t_stdc_in_registers;
  signal regs_o : t_stdc_out_registers;

  signal cycles_reg : std_logic_vector(27 downto 0);
  signal got_a_pulse : std_logic;
  
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
      D_WIDTH => 32
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

  -- instantiate the wb interface generated with wbgen2
  comp_stdc_wb_slave : stdc_wb_slave
    port map(
      rst_n_i    => sys_rst_n_i,
      clk_sys_i  => clk_sys_i,
      wb_adr_i   => wb_addr_i(3 downto 2),
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


--      fifo_di <= polarity & std_logic_vector(unsigned(cycles_reg)-0) & timestamp_resync when timestamp_resync(2)='0' else
--                 polarity & std_logic_vector(unsigned(cycles_reg)-1) & timestamp_resync;

  timestamp_resync <= std_logic_vector(unsigned(timestamp_8th)+1);

  -- if next =1 and fifo not empty, send to tdc_data next fifo element
  regs_i.tdc_data_i <= fifo_do;

  -- if clear command, send a reset to the fifo
  fifo_clear <= regs_o.ctrl_clr_o or (not(sys_rst_n_i));

  -- fill status registers
  regs_i.status_empty_i <= fifo_empty;
  regs_i.status_ovf_i   <= fifo_we and fifo_full;

  got_a_pulse <= detect and ((polarity and regs_o.ctrl_filter_o(0)) or (not polarity and regs_o.ctrl_filter_o(1)));
  
  pc_reg_fifo_xclk_hdl : process (sys_rst_n_i, clk_125m_i)
  begin
    if sys_rst_n_i = '0' then
      fifo_we <= '0';
      fifo_re <= '0';
    elsif rising_edge(clk_125m_i) then
      -- if enabled edge detected write in the fifo       
      fifo_we <= got_a_pulse;
      fifo_re <= regs_o.ctrl_next_o and not(fifo_re);
      if detect = '1' then
        if (timestamp_resync(2) = '0') then
          fifo_di <= polarity & std_logic_vector(unsigned(cycles_reg)-1) & timestamp_resync;
        else
          fifo_di <= polarity & std_logic_vector(unsigned(cycles_reg)-2) & timestamp_resync;
        end if;
      end if;
    end if;
  end process;

  stdc_data_o <= fifo_di;
  strobe_o    <= fifo_we;

  p_reg_cycles : process(sys_rst_n_i, clk_125m_i)
  begin
    if sys_rst_n_i = '0' then
      cycles_reg <= (others => '0');
    elsif rising_edge(clk_125m_i) then
      if got_a_pulse = '1' then
        cycles_reg <= cycles_i;
      end if;
    end if;
  end process;
  
  
  
end architecture;
