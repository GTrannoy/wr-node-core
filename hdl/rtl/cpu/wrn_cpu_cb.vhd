library ieee;
use ieee.std_logic_1164.all;

use work.wishbone_pkg.all;
--use work.wrcore_pkg.all;

use work.wrn_cpu_csr_wbgen2_pkg.all;
use work.wrn_cpu_lr_wbgen2_pkg.all;

use work.wr_node_pkg.all;

entity wrn_cpu_cb is
  
  generic (
    g_cpu_id    : integer;
    g_iram_size : integer
    );

  port (
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;

    tm_i : in t_wrn_timing_if;

    sh_master_i : in  t_wishbone_master_in;
    sh_master_o : out t_wishbone_master_out;

    dp_master_i : in  t_wishbone_master_in;
    dp_master_o : out t_wishbone_master_out;

    cpu_csr_i : in  t_wrn_cpu_csr_out_registers;
    cpu_csr_o : out t_wrn_cpu_csr_in_registers := c_wrn_cpu_csr_in_registers_init_value;

    rmq_ready_i : in std_logic_vector(15 downto 0);
    hmq_ready_i : in std_logic_vector(15 downto 0)
    );


end wrn_cpu_cb;

architecture rtl of wrn_cpu_cb is

  component wrn_cpu_lr_wb_slave
    port (
      rst_n_i             : in  std_logic;
      clk_sys_i           : in  std_logic;
      wb_adr_i            : in  std_logic_vector(2 downto 0);
      wb_dat_i            : in  std_logic_vector(31 downto 0);
      wb_dat_o            : out std_logic_vector(31 downto 0);
      wb_cyc_i            : in  std_logic;
      wb_sel_i            : in  std_logic_vector(3 downto 0);
      wb_stb_i            : in  std_logic;
      wb_we_i             : in  std_logic;
      wb_ack_o            : out std_logic;
      wb_stall_o          : out std_logic;
      tai_cycles_rd_ack_o : out std_logic;
      regs_i              : in  t_wrn_cpu_lr_in_registers;
      regs_o              : out t_wrn_cpu_lr_out_registers);
  end component;

  component wrn_lm32_wrapper
    generic (
      g_iram_size : integer;
      g_cpu_id    : integer);
    port (
      clk_sys_i : in  std_logic;
      rst_n_i   : in  std_logic;
      irq_i     : in  std_logic_vector(31 downto 0) := x"00000000";
      dwb_o     : out t_wishbone_master_out;
      dwb_i     : in  t_wishbone_master_in;
      cpu_csr_i : in  t_wrn_cpu_csr_out_registers;
      cpu_csr_o : out t_wrn_cpu_csr_in_registers);
  end component;

  constant c_local_wishbone_masters : integer := 3;

  signal cnx_master_in  : t_wishbone_master_in_array(c_local_wishbone_masters-1 downto 0);
  signal cnx_master_out : t_wishbone_master_out_array(c_local_wishbone_masters-1 downto 0);

  constant c_slave_lr : integer := 0;
  constant c_slave_dp : integer := 1;
  constant c_slave_si : integer := 2;
  
  constant c_cnx_address : t_wishbone_address_array(2 downto 0) := (
    c_slave_lr => x"00100000",                        -- local regs
    c_slave_dp => x"00200000",                        -- dedicated peripheral port
    c_slave_si => x"40000000"                         -- shared interconnect
    );

  constant c_cnx_mask : t_wishbone_address_array(2 downto 0) := (
    c_slave_lr => x"fff00000",
    c_slave_dp => x"fff00000",
    c_slave_si => x"c0000000"
    );

  signal tai_cycles_rd_ack : std_logic;
  signal local_regs_in     : t_wrn_cpu_lr_in_registers;
  signal local_regs_out    : t_wrn_cpu_lr_out_registers;

  signal cpu_dwb_out : t_wishbone_master_out;
  signal cpu_dwb_in  : t_wishbone_master_in;
  
  
begin  -- rtl

  U_TheCoreCPU : wrn_lm32_wrapper
    generic map (
      g_iram_size => g_iram_size,
      g_cpu_id    => g_cpu_id)
    port map (
      clk_sys_i => clk_sys_i,
      rst_n_i   => rst_n_i,
      irq_i     => x"00000000",  -- no irqs, we want to be deterministic...
      dwb_o     => cpu_dwb_out,
      dwb_i     => cpu_dwb_in,
      cpu_csr_i => cpu_csr_i,
      cpu_csr_o => cpu_csr_o);


  U_Local_Registrers : wrn_cpu_lr_wb_slave
    port map (
      rst_n_i             => rst_n_i,
      clk_sys_i           => clk_sys_i,
      wb_adr_i            => cnx_master_out(c_slave_lr).adr(4 downto 2),
      wb_dat_i            => cnx_master_out(c_slave_lr).dat,
      wb_dat_o            => cnx_master_in(c_slave_lr).dat,
      wb_cyc_i            => cnx_master_out(c_slave_lr).cyc,
      wb_sel_i            => cnx_master_out(c_slave_lr).sel,
      wb_stb_i            => cnx_master_out(c_slave_lr).stb,
      wb_we_i             => cnx_master_out(c_slave_lr).we,
      wb_ack_o            => cnx_master_in(c_slave_lr).ack,
      wb_stall_o          => cnx_master_in(c_slave_lr).stall,
      tai_cycles_rd_ack_o => tai_cycles_rd_ack,
      regs_i              => local_regs_in,
      regs_o              => local_regs_out);

  cnx_master_in(c_slave_lr).err <= '0';
  cnx_master_in(c_slave_lr).rty <= '0';

  local_regs_in.poll_hmq_i <= hmq_ready_i;
  local_regs_in.poll_rmq_i <= rmq_ready_i;
  

  U_Local_Interconnect : xwb_crossbar
    generic map (
      g_num_masters => 1,
      g_num_slaves  => c_local_wishbone_masters,
      g_registered  => true,
      g_address     => c_cnx_address,
      g_mask        => c_cnx_mask)
    port map (
      clk_sys_i  => clk_sys_i,
      rst_n_i    => rst_n_i,
      slave_i(0) => cpu_dwb_out,
      slave_o(0) => cpu_dwb_in,
      master_i   => cnx_master_in,
      master_o   => cnx_master_out);

  dp_master_o <= cnx_master_out(c_slave_dp);
  cnx_master_in(c_slave_dp) <= dp_master_i;

  sh_master_o <= cnx_master_out(c_slave_si);
  cnx_master_in(c_slave_si) <= sh_master_i;

  
end rtl;
