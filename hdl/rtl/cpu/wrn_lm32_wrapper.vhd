library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.genram_pkg.all;
use work.wishbone_pkg.all;
use work.wrn_cpu_csr_wbgen2_pkg.all;
use work.wrn_private_pkg.all;

entity wrn_lm32_wrapper is
  generic(
    g_iram_size : integer;
    g_cpu_id    : integer
    );

  port(
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;
    irq_i     : in std_logic_vector(31 downto 0) := x"00000000";

    dwb_o : out t_wishbone_master_out;
    dwb_i : in  t_wishbone_master_in;

    cpu_csr_i : in  t_wrn_cpu_csr_out_registers;
    cpu_csr_o : out t_wrn_cpu_csr_in_registers
    );
end wrn_lm32_wrapper;

architecture wrapper of wrn_lm32_wrapper is

  constant c_iram_addr_width : integer := f_log2_size(g_iram_size)-2;

  component lm32_cpu_wr_node is
    generic (
      eba_reset : std_logic_vector(31 downto 0) := x"00000000"
      );

    port (
      clk_i     : in std_logic;
      rst_i     : in std_logic;
      interrupt : in std_logic_vector(31 downto 0) := x"00000000";

      --jtag_clk        : in  std_logic;
      --jtag_update     : in  std_logic;
      --jtag_reg_q      : in std_logic_vector(7 downto 0);
      --jtag_reg_addr_q : in std_logic_vector(2 downto 0);
      --jtag_reg_d      : out  std_logic_vector(7 downto 0);
      --jtag_reg_addr_d : out  std_logic_vector (2 downto 0);

      iram_i_adr_o : out std_logic_vector(31 downto 0);
      iram_i_dat_i : in  std_logic_vector(31 downto 0);
      iram_i_en_o  : out std_logic;
      iram_d_adr_o : out std_logic_vector(31 downto 0);
      iram_d_dat_o : out std_logic_vector(31 downto 0);
      iram_d_dat_i : in  std_logic_vector(31 downto 0);
      iram_d_sel_o : out std_logic_vector(3 downto 0);
      iram_d_we_o  : out std_logic;
      iram_d_en_o  : out std_logic;

      D_DAT_O : out std_logic_vector(31 downto 0);
      D_ADR_O : out std_logic_vector(31 downto 0);
      D_CYC_O : out std_logic;
      D_SEL_O : out std_logic_vector(3 downto 0);
      D_STB_O : out std_logic;
      D_WE_O  : out std_logic;
      D_DAT_I : in  std_logic_vector(31 downto 0);
      D_ACK_I : in  std_logic;
      D_ERR_I : in  std_logic := '0';
      D_RTY_I : in  std_logic := '0'
      );

  end component;

  component wrn_cpu_iram
    generic (
      g_size : integer);
    port (
      clk_i   : in  std_logic;
      rst_n_i : in  std_logic;
      aa_i    : in  std_logic_vector(f_log2_size(g_size)-1 downto 0);
      ab_i    : in  std_logic_vector(f_log2_size(g_size)-1 downto 0);
      da_i    : in  std_logic_vector(31 downto 0);
      db_i    : in  std_logic_vector(31 downto 0);
      qa_o    : out std_logic_vector(31 downto 0);
      qb_o    : out std_logic_vector(31 downto 0);
      ena_i   : in  std_logic;
      enb_i   : in  std_logic;
      wea_i   : in  std_logic;
      web_i   : in  std_logic);
  end component;

  function f_x_to_zero (x : std_logic_vector) return std_logic_vector is
    variable tmp : std_logic_vector(x'length-1 downto 0);
  begin
    for i in 0 to x'length-1 loop
      if(x(i) = 'X' or x(i) = 'U') then
        tmp(i) := '0';
      else
        tmp(i) := x(i);
      end if;
    end loop;
    return tmp;
  end function;


  signal jtag_clk        : std_logic;
  signal jtag_update     : std_logic;
  signal jtag_reg_q      : std_logic_vector(7 downto 0);
  signal jtag_reg_addr_q : std_logic_vector(2 downto 0);
  signal jtag_reg_d      : std_logic_vector(7 downto 0);
  signal jtag_reg_addr_d : std_logic_vector (2 downto 0);

  signal cm_out : t_wishbone_master_out;
  signal cm_in  : t_wishbone_master_in;

  signal data_addr_reg : t_wishbone_address;

  signal cpu_reset, cpu_enable, cpu_reset_n : std_logic;
  signal host_rdata                         : std_logic_vector(31 downto 0);
  signal host_write                         : std_logic;
  signal data_was_busy, data_remaining      : std_logic;

  signal rst : std_logic;

  signal d_adr : std_logic_vector(31 downto 0);


  component chipscope_ila
    port (
      CONTROL : inout std_logic_vector(35 downto 0);
      CLK     : in    std_logic;
      TRIG0   : in    std_logic_vector(31 downto 0);
      TRIG1   : in    std_logic_vector(31 downto 0);
      TRIG2   : in    std_logic_vector(31 downto 0);
      TRIG3   : in    std_logic_vector(31 downto 0));
  end component;

  component chipscope_icon
    port (
      CONTROL0 : inout std_logic_vector (35 downto 0));
  end component;

  signal CONTROL : std_logic_vector(35 downto 0);
  signal CLK     : std_logic;
  signal TRIG0   : std_logic_vector(31 downto 0);
  signal TRIG1   : std_logic_vector(31 downto 0);
  signal TRIG2   : std_logic_vector(31 downto 0);
  signal TRIG3   : std_logic_vector(31 downto 0);

  signal core_sel_match : std_logic;

  signal cpu_dwb_out, cpu_iwb_out : t_wishbone_master_out;
  signal cpu_dwb_in, cpu_iwb_in   : t_wishbone_master_in;

  signal iram_access          : std_logic;
  signal iram_access_d0       : std_logic;
  signal iram_i_wr, iram_d_wr : std_logic;
  signal iram_i_adr           : std_logic_vector(f_log2_size(g_iram_size)-3 downto 0);
  signal iram_i_d, iram_d_q   : std_logic_vector(31 downto 0);

begin

  xwb_lm32_1 : xwb_lm32
    generic map (
      g_profile => "medium_icache")
    port map (
      clk_sys_i => clk_sys_i,
      rst_n_i   => cpu_reset_n,
      irq_i     => x"00000000",
      dwb_o     => cpu_dwb_out,
      dwb_i     => cpu_dwb_in,
      iwb_o     => cpu_iwb_out,
      iwb_i     => cpu_iwb_in);

  iram : generic_dpram
    generic map (
      g_data_width       => 32,
      g_size             => g_iram_size / 4,
      g_with_byte_enable => true,
      g_dual_clock       => false)
    port map (
      rst_n_i => rst_n_i,
      clka_i  => clk_sys_i,

      wea_i => iram_i_wr,
      aa_i  => iram_i_adr,
      da_i  => iram_i_d,
      qa_o  => cpu_iwb_in.dat,

      clkb_i => clk_sys_i,
      bweb_i => cpu_dwb_out.sel,
      web_i  => iram_d_wr,
      ab_i   => cpu_dwb_out.adr(f_log2_size(g_iram_size)-1 downto 2),
      db_i   => cpu_dwb_out.dat,
      qb_o   => iram_d_q
      );

  iram_access <= '1' when cpu_dwb_out.adr (31 downto 20) = x"000" and cpu_dwb_out.cyc = '1' and cpu_dwb_out.stb = '1' else '0';

  cpu_dwb_in.ack   <= iram_access_d0 or dwb_i.ack;
  cpu_dwb_in.dat   <= iram_d_q when iram_access_d0 = '1' else dwb_i.dat;
  cpu_dwb_in.stall <= '0'      when iram_access = '1'    else dwb_i.stall;
  cpu_dwb_in.err   <= '0';
  cpu_dwb_in.rty   <= '0';
  iram_d_wr        <= iram_access and cpu_dwb_out.we;

  dwb_o.cyc <= cpu_dwb_out.cyc;
  dwb_o.stb <= cpu_dwb_out.stb and not iram_access;
  dwb_o.sel <= cpu_dwb_out.sel;
  dwb_o.we  <= cpu_dwb_out.we;
  dwb_o.adr <= cpu_dwb_out.adr;
  dwb_o.dat <= cpu_dwb_out.dat;

  p_decode : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if cpu_reset_n = '0' then
        iram_access_d0 <= '0';
      else
        iram_access_d0 <= iram_access;
        cpu_iwb_in.ack <= cpu_iwb_out.cyc and cpu_iwb_out.stb;
      end if;
    end if;
  end process;

  cpu_iwb_in.stall <= '0';
  cpu_iwb_in.err   <= '0';
  cpu_iwb_in.rty   <= '0';


  core_sel_match <= '1' when unsigned(cpu_csr_i.core_sel_o) = g_cpu_id else '0';
  cpu_reset      <= not rst_n_i or cpu_csr_i.reset_o(g_cpu_id);
  cpu_enable     <= not cpu_reset;
  cpu_reset_n <= not cpu_reset;

  iram_i_d   <= cpu_csr_i.udata_o;
  iram_i_wr  <= cpu_csr_i.udata_load_o and core_sel_match;
  iram_i_adr <= cpu_csr_i.uaddr_addr_o(f_log2_size(g_iram_size)-3 downto 0) when cpu_enable = '0' else
                cpu_iwb_out.adr(f_log2_size(g_iram_size)-1 downto 2);
  
  cpu_csr_o.udata_i <= cpu_iwb_in.dat;



  p_jtag_regs : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_i = '0' or cpu_enable = '0' then
        jtag_clk        <= '0';
        jtag_update     <= '0';
        jtag_reg_addr_d <= (others => '0');
        jtag_reg_d      <= (others => '0');
      else


      end if;
    end if;
  end process;


end wrapper;
