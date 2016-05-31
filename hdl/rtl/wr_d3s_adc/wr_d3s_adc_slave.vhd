library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.gencores_pkg.all;
use work.genram_pkg.all;
use work.wishbone_pkg.all;
use work.d3ss_wbgen2_pkg.all;

library UNISIM;
use UNISIM.vcomponents.all;

entity wr_d3s_adc_slave is
  port (
    clk_sys_i   : in std_logic;
    rst_n_sys_i : in std_logic;

    clk_125m_pllref_i: in std_logic;

    clk_wr_o : out std_logic;

    tm_tai_i : in std_logic_vector(39 downto 0);
    tm_cycles_i          : in  std_logic_vector(27 downto 0);
    tm_time_valid_i      : in  std_logic;
    tm_clk_aux_lock_en_o : out std_logic;
    tm_clk_aux_locked_i  : in  std_logic;

   -- WR reference clock from FMC's PLL (AD9516)
    wr_ref_clk_n_i : in std_logic;
    wr_ref_clk_p_i : in std_logic;
    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out;

    -- DDS Dac I/F (Maxim)
    dac_n_o : out std_logic_vector(13 downto 0);
    dac_p_o : out std_logic_vector(13 downto 0);
    
    debug_o : out std_logic_vector(3 downto 0)
    );

end wr_d3s_adc_slave;

architecture rtl of wr_d3s_adc_slave is

  signal clk_wr_ref, clk_wr_ref_pllin : std_logic;
  signal pllout_clk_fb_pllref, pllout_clk_wr_ref : std_logic;
  signal clk_dds_phy                             : std_logic;

  signal rst_n_wr : std_logic;

  signal regs_in  : t_d3ss_in_registers;
  signal regs_out : t_d3ss_out_registers;

  constant c_CNX_MASTER_COUNT : integer := 5;

  constant c_cnx_base_addr : t_wishbone_address_array(c_CNX_MASTER_COUNT-1 downto 0) :=
    (x"00000000",                       -- Base regs
     x"00000100",                       -- AcqBuf1
     x"00000200",                       -- AcqBuf2
     x"00000300",                       -- AcqBuf3
     x"00000400"                        -- Serdes TDC
     );

  constant c_cnx_base_mask : t_wishbone_address_array(c_CNX_MASTER_COUNT-1 downto 0) :=
    (x"00000700",
     x"00000700",
     x"00000700",
     x"00000700",
     x"00000700"
     );

  signal cnx_out : t_wishbone_master_out_array(0 to c_CNX_MASTER_COUNT-1);
  signal cnx_in  : t_wishbone_master_in_array(0 to c_CNX_MASTER_COUNT-1);
  signal locked_out : std_logic;
  alias clk_wr is clk_wr_ref_pllin;
  
begin

locked_out <= '1';
  
    U_Buf_CLK_WR_Ref : IBUFGDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_wr_ref_pllin,           -- Buffer output
      I  => wr_ref_clk_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => wr_ref_clk_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

    
  U_Intercon : xwb_crossbar
    generic map (
      g_num_masters => 1,
      g_num_slaves  => c_CNX_MASTER_COUNT,
      g_registered  => true,
      g_address     => c_cnx_base_addr,
      g_mask        => c_cnx_base_mask)
    port map (
      clk_sys_i  => clk_sys_i,
      rst_n_i    => rst_n_sys_i,
      slave_i(0) => slave_i,
      slave_o(0) => slave_o,
      master_i   => cnx_in,
      master_o   => cnx_out);


  U_Sync_Reset : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_wr,
      rst_n_i  => '1',
      data_i   => rst_n_sys_i and locked_out,
      synced_o => rst_n_wr);

  U_CSR : entity work.d3s_adc_slave_wb
    port map (
      rst_n_i    => rst_n_sys_i,
      clk_sys_i  => clk_sys_i,
      wb_adr_i   => cnx_out(0).adr(4 downto 2),
      wb_dat_i   => cnx_out(0).dat,
      wb_dat_o   => cnx_in(0).dat,
      wb_cyc_i   => cnx_out(0).cyc,
      wb_sel_i   => cnx_out(0).sel,
      wb_stb_i   => cnx_out(0).stb,
      wb_we_i    => cnx_out(0).we,
      wb_ack_o   => cnx_in(0).ack,
      wb_stall_o => cnx_in(0).stall,
      clk_wr_i   => clk_wr,
      regs_i     => regs_in,
      regs_o     => regs_out);

  cnx_in(0).err <= '0';
  cnx_in(0).rty <= '0';

  U_Phase_Dec: entity work.d3s_phase_decoder
      port map (
        clk_wr_i         => clk_wr,
        rst_n_wr_i       => rst_n_wr,
        r_enable_i       => regs_out.cr_enable_o,
        r_delay_coarse_i => regs_out.rec_delay_coarse_o,
        tm_time_valid_i  => tm_time_valid_i,
        tm_tai_i         => tm_tai_i,
        tm_cycles_i      => tm_cycles_i,
        fifo_phase_i     => regs_out.phfifo_rl_phase_o,
        fifo_rl_i        => regs_out.phfifo_rl_length_o,
        fifo_is_rl_i     => regs_out.phfifo_is_rl_o,
        fifo_tstamp_i    => regs_out.phfifo_tstamp_o,
        fifo_empty_i     => regs_out.phfifo_rd_empty_o,
        fifo_rd_o        => regs_in.phfifo_rd_req_i,
        phase_o          => open,
        phase_valid_o    => open);

end rtl;
