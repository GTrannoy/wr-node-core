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


  signal iram_i_adr     : std_logic_vector(31 downto 0);
  signal iram_i_dat     : std_logic_vector(31 downto 0);
  signal iram_i_en      : std_logic;
  signal iram_d_adr     : std_logic_vector(31 downto 0);
  signal iram_d_dat_out : std_logic_vector(31 downto 0);
  signal iram_d_dat_in  : std_logic_vector(31 downto 0);
  signal iram_d_sel     : std_logic_vector(3 downto 0);
  signal iram_d_we      : std_logic;
  signal iram_d_en      : std_logic;

  signal cm_out : t_wishbone_master_out;
  signal cm_in  : t_wishbone_master_in;

  signal data_addr_reg : t_wishbone_address;

  signal cpu_reset, cpu_enable         : std_logic;
  signal host_rdata                    : std_logic_vector(31 downto 0);
  signal host_write                    : std_logic;
  signal data_was_busy, data_remaining : std_logic;

  signal rst : std_logic;

  signal d_adr : std_logic_vector(31 downto 0);

  signal iram_ena : std_logic;
  signal iram_aa  : std_logic_vector(c_iram_addr_width-1 downto 0);

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
  

  signal core_sel_match: std_logic;
begin

  core_sel_match <= '1' when unsigned(cpu_csr_i.core_sel_o) = g_cpu_id else '0';
  
  gen_cc : if g_cpu_id = 0 generate

    --chipscope_icon_1 : chipscope_icon
    --  port map (
    --    CONTROL0 => CONTROL);

    --chipscope_ila_1 : chipscope_ila
    --  port map (
    --    CONTROL => CONTROL,
    --    CLK     => clk_sys_i,
    --    TRIG0   => TRIG0,
    --    TRIG1   => TRIG1,
    --    TRIG2   => TRIG2,
    --    TRIG3   => TRIG3);

    trig0(0) <= rst;
    trig0(1) <= cpu_reset;
    trig0(2) <= iram_i_en;

    trig1 <= iram_i_adr;
    trig2 <= iram_i_dat;

    
  end generate gen_cc;

  rst <= not rst_n_i or cpu_csr_i.reset_o(g_cpu_id);

  cpu_reset  <= cpu_csr_i.reset_o(g_cpu_id);
  cpu_enable <= not cpu_reset;

  U_Wrapped_CPU : lm32_cpu_wr_node
    generic map (
      eba_reset => x"00000000")
    port map (
      clk_i     => clk_sys_i,
      rst_i     => rst,
      interrupt => irq_i,

      --jtag_clk        => jtag_clk,
      --jtag_update     => jtag_update,
      --jtag_reg_q      => jtag_reg_d,
      --jtag_reg_addr_q => jtag_reg_addr_d,
      --jtag_reg_d      => jtag_reg_q,
      --jtag_reg_addr_d => jtag_reg_addr_q,

      iram_i_adr_o => iram_i_adr,
      iram_i_dat_i => iram_i_dat,
      iram_i_en_o  => iram_i_en,
      iram_d_adr_o => iram_d_adr,
      iram_d_dat_o => iram_d_dat_out,
      iram_d_dat_i => iram_d_dat_in,
      iram_d_sel_o => iram_d_sel,
      iram_d_we_o  => iram_d_we,
      iram_d_en_o  => iram_d_en,

      D_DAT_O => cm_out.dat,
      D_ADR_O => d_adr,
      D_CYC_O => cm_out.cyc,
      D_SEL_O => cm_out.sel,
      D_STB_O => open,
      D_WE_O  => cm_out.we,
      D_DAT_I => f_x_to_zero (cm_in.dat),
      D_ACK_I => cm_in.ack,
      D_ERR_I => '0',
      D_RTY_I => '0');

  iram_aa  <= f_pick(cpu_enable, iram_i_adr(c_iram_addr_width-1 downto 0), cpu_csr_i.uaddr_addr_o(c_iram_addr_width-1 downto 0));
  iram_ena <= f_pick(cpu_enable, iram_i_en, '1');

  U_IRAM : wrn_cpu_iram
    generic map (
      g_size => g_iram_size / 4)
    port map (
      clk_i   => clk_sys_i,
      rst_n_i => rst_n_i,
      aa_i    => iram_aa,
      ab_i    => iram_d_adr(c_iram_addr_width-1 downto 0),
      da_i    => cpu_csr_i.udata_o,
      db_i    => iram_d_dat_out,
      qa_o    => host_rdata,
      qb_o    => iram_d_dat_in,
      ena_i   => iram_ena,
      enb_i   => iram_d_en,
      wea_i   => host_write,
      web_i   => iram_d_we);



  host_write <= not cpu_enable and cpu_csr_i.udata_load_o and core_sel_match;

  iram_i_dat <= host_rdata;

  cm_out.stb <= (cm_out.cyc and not data_was_busy) or data_remaining;

  cpu_csr_o.udata_i <= host_rdata ;
                                                                  
  
  process(clk_sys_i)
    variable data_addr : t_wishbone_address;
    
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_i = '0' or cpu_enable = '0' then
        data_was_busy  <= '0';
        data_addr_reg  <= (others => '0');
        data_remaining <= '0';
      else
        data_was_busy <= cm_out.cyc;

        -- Is this the start of a new WB cycle?
        if cm_out.cyc = '1' and data_was_busy = '0' then
          data_remaining <= '1';
          data_addr      := D_ADR;
        else
          data_addr := data_addr_reg;
        end if;

        if cm_in.stall = '0' and cm_out.stb = '1' then
          data_remaining <= '0';
        end if;


        data_addr_reg <= data_addr;
      end if;
    end if;
  end process;

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


  cm_out.ADR <= d_adr when data_was_busy = '0' else data_addr_reg;

  dwb_o <= cm_out;
  cm_in <= dwb_i;

end wrapper;
