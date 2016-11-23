library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.genram_pkg.all;
use work.gencores_pkg.all;
use work.gmtc_wbgen2_pkg.all;
use work.manchester_decoder_pkg.all;


entity gmt_converter is
  port (
    clk_sys_i : in std_logic;
    clk_wr_i  : in std_logic;
    clk_40m_i : in std_logic;

    rst_n_sys_i : in std_logic;

    tm_cycles_i : in std_logic_vector(27 downto 0);
    tm_tai_i    : in std_logic_vector(31 downto 0);
    tm_valid_i  : in std_logic;

    gmt_i : in  std_logic_vector(4 downto 0);
    gmt_o : out std_logic_vector(4 downto 0);

    pps_gmt_a_i : in std_logic;

    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out
    );

end gmt_converter;

architecture rtl of gmt_converter is

  component manchester_decoder is
    port (
      rst_n_i      : in  std_logic;
      clk_i        : in  std_logic;
      md_i         : in  std_logic;
      data_o       : out std_logic_vector (31 downto 0);
      data_ready_o : out std_logic;
      mil_pulse_o  : out std_logic;
      sc_pulse_o   : out std_logic;
      error_o      : out ErrorReg_type);
  end component manchester_decoder;

  component gc_prog_delay is
    generic (
      g_width          : integer;
      g_max_depth_log2 : integer);
    port (
      clk_i            : in  std_logic;
      rst_n_i          : in  std_logic;
      d_i              : in  std_logic_vector(g_width-1 downto 0);
      q_o              : out std_logic_vector(g_width-1 downto 0);
      delay_setpoint_i :     std_logic_vector(g_max_depth_log2-1 downto 0));
  end component gc_prog_delay;

  component gmt_converter_wb_slave is
    port (
      rst_n_i    : in  std_logic;
      clk_sys_i  : in  std_logic;
      wb_adr_i   : in  std_logic_vector(3 downto 0);
      wb_dat_i   : in  std_logic_vector(31 downto 0);
      wb_dat_o   : out std_logic_vector(31 downto 0);
      wb_cyc_i   : in  std_logic;
      wb_sel_i   : in  std_logic_vector(3 downto 0);
      wb_stb_i   : in  std_logic;
      wb_we_i    : in  std_logic;
      wb_ack_o   : out std_logic;
      wb_stall_o : out std_logic;
      clk_40m_i  : in  std_logic;
      clk_wr_i   : in  std_logic;
      regs_i     : in  t_gmtc_in_registers;
      regs_o     : out t_gmtc_out_registers);
  end component gmt_converter_wb_slave;

  type t_gmt_input is record
    data      : std_logic_vector(31 downto 0);
    tstamp_wr : std_logic_vector(27 downto 0);
    ready_40m : std_logic;
    ready_wr  : std_logic;
    ready_sys : std_logic;
  end record;

  type t_gmt_input_array is array(0 to 4) of t_gmt_input;

  signal regs_in     : t_gmtc_in_registers;
  signal regs_out    : t_gmtc_out_registers;
  signal rx_channels : t_gmt_input_array;

  signal rst_n_40m : std_logic;
  signal rst_n_wr  : std_logic;
  signal pps_gmt_p : std_logic;
  
begin

  U_Sync_Reset_40m : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_40m_i,
      rst_n_i  => '1',
      data_i   => rst_n_sys_i and (not regs_out.cr_swrst_o),
      synced_o => rst_n_40m);

  U_Sync_Reset_WR : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_wr_i,
      rst_n_i  => '1',
      data_i   => rst_n_sys_i and (not regs_out.cr_swrst_o),
      synced_o => rst_n_wr);

  U_Sync_PPS : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_wr_i,
      rst_n_i  => rst_n_wr,
      data_i   => pps_gmt_a_i,
      ppulse_o => pps_gmt_p);

  U_CSR : gmt_converter_wb_slave
    port map (
      rst_n_i    => rst_n_sys_i,
      clk_sys_i  => clk_sys_i,
      wb_adr_i   => slave_i.adr(5 downto 2),
      wb_dat_i   => slave_i.dat,
      wb_dat_o   => slave_o.dat,
      wb_cyc_i   => slave_i.cyc,
      wb_sel_i   => slave_i.sel,
      wb_stb_i   => slave_i.stb,
      wb_we_i    => slave_i.we,
      wb_ack_o   => slave_o.ack,
      wb_stall_o => slave_o.stall,
      clk_wr_i   => clk_wr_i,
      clk_40m_i  => clk_40m_i,
      regs_i     => regs_in,
      regs_o     => regs_out);

  
  
  gen_channels : for i in 0 to 4 generate

    U_Delay : gc_prog_delay
      generic map (
        g_width          => 1,
        g_max_depth_log2 => 16)         -- max 1.5 ms
      port map (
        clk_i            => clk_40m_i,
        rst_n_i          => rst_n_40m,
        d_i(0)           => gmt_i(i),
        q_o(0)           => gmt_o(i),
        delay_setpoint_i => regs_out.delay_o);

    U_Receiver : manchester_decoder
      port map (
        rst_n_i      => rst_n_40m,
        clk_i        => clk_40m_i,
        md_i         => gmt_i(i),
        data_o       => rx_channels(i).data,
        data_ready_o => rx_channels(i).ready_40m,
        mil_pulse_o  => open,
        sc_pulse_o   => open,
        error_o      => open);

    U_Sync_Done_SYS : gc_pulse_synchronizer2
      port map (
        clk_in_i    => clk_40m_i,
        rst_in_n_i  => rst_n_40m,
        clk_out_i   => clk_sys_i,
        rst_out_n_i => rst_n_sys_i,
        d_ready_o   => open,
        d_p_i       => rx_channels(i).ready_40m,
        q_p_o       => rx_channels(i).ready_sys);

    U_Sync_Done_WR : gc_pulse_synchronizer2
      port map (
        clk_in_i    => clk_40m_i,
        rst_in_n_i  => rst_n_40m,
        clk_out_i   => clk_wr_i,
        rst_out_n_i => rst_n_wr,
        d_ready_o   => open,
        d_p_i       => rx_channels(i).ready_40m,
        q_p_o       => rx_channels(i).ready_wr);

    p_readout : process(clk_sys_i)
    begin
      if rising_edge(clk_sys_i) then
        if rst_n_sys_i = '0' or regs_out.cr_swrst_o = '1' then
          regs_in.rx_status_i(i) <= '0';
        else
          if (rx_channels(i).ready_sys = '1') then
            regs_in.rx_status_i(i) <= '1';
          elsif (regs_out.rx_status_o(i) = '1' and regs_out.rx_status_load_o = '1') then
            regs_in.rx_status_i(i) <= '0';
          end if;
        end if;
      end if;
    end process;

    p_timestamp : process(clk_wr_i)
    begin
      if rising_edge(clk_wr_i) then
        if rx_channels(i).ready_wr = '1' then
          rx_channels(i).tstamp_wr <= tm_cycles_i;
        end if;
      end if;
    end process;



  end generate gen_channels;

  regs_in.rx_status_i(7 downto 5) <= (others => '0');

  p_data_regs : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then

      regs_in.rx_tstamp0_i <= "0000" & rx_channels(0).tstamp_wr;
      regs_in.rx_tstamp1_i <= "0000" & rx_channels(1).tstamp_wr;
      regs_in.rx_tstamp2_i <= "0000" & rx_channels(2).tstamp_wr;
      regs_in.rx_tstamp3_i <= "0000" & rx_channels(3).tstamp_wr;
      regs_in.rx_tstamp4_i <= "0000" & rx_channels(4).tstamp_wr;
      
      if rx_channels(0).ready_sys = '1' then
        regs_in.rx_data0_i <= rx_channels(0).data;
      end if;
      if rx_channels(1).ready_sys = '1' then
        regs_in.rx_data1_i <= rx_channels(1).data;
      end if;
      if rx_channels(2).ready_sys = '1' then
        regs_in.rx_data2_i <= rx_channels(2).data;
      end if;
      if rx_channels(3).ready_sys = '1' then
        regs_in.rx_data3_i <= rx_channels(3).data;
      end if;
      if rx_channels(4).ready_sys = '1' then
        regs_in.rx_data4_i <= rx_channels(4).data;
      end if;

    end if;
    
  end process;


end rtl;


