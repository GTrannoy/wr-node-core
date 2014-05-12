library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wr_node_pkg.all;
use work.wishbone_pkg.all;
use work.wrn_cpu_csr_wbgen2_pkg.all;
use work.wrn_mqueue_pkg.all;




entity wr_node_core is
  
  generic (
    g_config : t_wr_node_config := c_default_node_config);

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    sp_master_o : out t_wishbone_master_out;
    sp_master_i : in  t_wishbone_master_in := cc_dummy_master_in;

    dp_master_o : out t_wishbone_master_out_array(0 to g_config.cpu_count-1);
    dp_master_i : in  t_wishbone_master_in_array(0 to g_config.cpu_count-1) := f_dummy_master_in_array(g_config.cpu_count);

    ebm_master_o : out t_wishbone_master_out;
    ebm_master_i : in  t_wishbone_master_in := cc_dummy_master_in;

    ebs_slave_o : out t_wishbone_slave_out;
    ebs_slave_i : in  t_wishbone_slave_in := cc_dummy_slave_in;

    host_slave_i : in  t_wishbone_slave_in;
    host_slave_o : out t_wishbone_slave_out;
    host_irq_o   : out std_logic;

    tm_i : in t_wrn_timing_if
    );

end wr_node_core;

architecture rtl of wr_node_core is

  component wrn_cpu_cb
    generic (
      g_cpu_id    : integer;
      g_iram_size : integer);
    port (
      clk_sys_i   : in  std_logic;
      rst_n_i     : in  std_logic;
      tm_i        : in  t_wrn_timing_if;
      sh_master_i : in  t_wishbone_master_in;
      sh_master_o : out t_wishbone_master_out;
      dp_master_i : in  t_wishbone_master_in;
      dp_master_o : out t_wishbone_master_out;
      cpu_csr_i   : in  t_wrn_cpu_csr_out_registers;
      cpu_csr_o   : out t_wrn_cpu_csr_in_registers;
      rmq_ready_i : in  std_logic_vector(15 downto 0);
      hmq_ready_i : in  std_logic_vector(15 downto 0));
  end component;

  component wrn_cpu_csr_wb_slave
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
      regs_i     : in  t_wrn_cpu_csr_in_registers;
      regs_o     : out t_wrn_cpu_csr_out_registers);
  end component;

  component wrn_mqueue_host
    generic (
      g_config : t_wrn_mqueue_config);
    port (
      clk_i        : in  std_logic;
      rst_n_i      : in  std_logic;
      si_slave_i   : in  t_wishbone_slave_in;
      si_slave_o   : out t_wishbone_slave_out;
      host_slave_i : in  t_wishbone_slave_in;
      host_slave_o : out t_wishbone_slave_out;
      host_irq_o   : out std_logic;
      hmq_status_o : out std_logic_vector(15 downto 0));
  end component;

  component wrn_mqueue_remote
    generic (
      g_config : t_wrn_mqueue_config);
    port (
      clk_i        : in  std_logic;
      rst_n_i      : in  std_logic;
      si_slave_i   : in  t_wishbone_slave_in;
      si_slave_o   : out t_wishbone_slave_out;
      ebm_master_o : out t_wishbone_master_out;
      ebm_master_i : in  t_wishbone_master_in := cc_dummy_master_in;
      ebs_slave_o  : out t_wishbone_slave_out;
      ebs_slave_i  : in  t_wishbone_slave_in  := cc_dummy_slave_in;
      rmq_status_o : out std_logic_vector(15 downto 0));
  end component;

  constant c_hac_wishbone_masters : integer := 3;
  constant c_hac_master_hmq       : integer := 0;
  constant c_hac_master_cpu_csr   : integer := 1;
  constant c_hac_master_si        : integer := 2;

  constant c_hac_address : t_wishbone_address_array(c_hac_wishbone_masters-1 downto 0) := (
    c_hac_master_hmq     => x"00000000",  -- Host MQ
    c_hac_master_cpu_csr => x"00010000",  -- CPU CSR
    c_hac_master_si      => x"00200000"   -- shared interconnect
    );

  constant c_hac_mask : t_wishbone_address_array(c_hac_wishbone_masters-1 downto 0) := (
    c_hac_master_hmq     => x"00210000",  -- Host MQ
    c_hac_master_cpu_csr => x"00210000",  -- CPU CSR
    c_hac_master_si      => x"00200000"   -- shared interconnect
    );

  signal hac_master_out : t_wishbone_master_out_array(c_hac_wishbone_masters-1 downto 0);
  signal hac_master_in  : t_wishbone_master_in_array(c_hac_wishbone_masters-1 downto 0);

  constant c_si_wishbone_masters : integer := 4;
  constant c_si_wishbone_slaves  : integer := g_config.cpu_count + 2;
  constant c_si_master_hmq       : integer := 0;
  constant c_si_master_rmq       : integer := 1;
  constant c_si_master_smem      : integer := 2;
  constant c_si_master_sp        : integer := 3;

  constant c_si_slave_hac  : integer := 0;
  constant c_si_slave_ebs  : integer := 1;
  constant c_si_slave_cpu0 : integer := 2;
  

  constant c_si_address : t_wishbone_address_array(c_si_wishbone_masters-1 downto 0) := (
    c_si_master_hmq  => x"00010000",    -- Host MQ
    c_si_master_rmq  => x"00020000",    -- Remote MQ
    c_si_master_smem => x"00000000",    -- Shared Memory
    c_si_master_sp   => x"00100000"
    );

  constant c_si_mask : t_wishbone_address_array(c_si_wishbone_masters-1 downto 0) := (
    c_si_master_hmq  => x"001f0000",    -- Host MQ
    c_si_master_rmq  => x"001f0000",    -- Remote MQ
    c_si_master_smem => x"001f0000",    -- Shared Memory
    c_si_master_sp   => x"00100000"
    );

  signal si_slave_in  : t_wishbone_slave_in_array(c_si_wishbone_slaves-1 downto 0);
  signal si_slave_out : t_wishbone_slave_out_array(c_si_wishbone_slaves-1 downto 0);

  signal si_master_in  : t_wishbone_master_in_array(c_si_wishbone_masters-1 downto 0);
  signal si_master_out : t_wishbone_master_out_array(c_si_wishbone_masters-1 downto 0);


  signal cpu_csr_fromwb : t_wrn_cpu_csr_out_registers;
  signal cpu_csr_towb   : t_wrn_cpu_csr_in_registers;

  signal hmq_status, rmq_status : std_logic_vector(15 downto 0);

  signal timing : t_wrn_timing_if;

  signal cpu_index : integer := 0;
  
begin  -- rtl


  U_Host_Access_CB : xwb_crossbar
    generic map (
      g_num_masters => 1,
      g_num_slaves  => c_hac_wishbone_masters,
      g_registered  => true,
      g_address     => c_hac_address,
      g_mask        => c_hac_mask)
    port map (
      clk_sys_i  => clk_i,
      rst_n_i    => rst_n_i,
      slave_i(0) => host_slave_i,
      slave_o(0) => host_slave_o,
      master_i   => hac_master_in,
      master_o   => hac_master_out);


  U_Shared_Interconnect : xwb_crossbar
    generic map (
      g_num_masters => c_si_wishbone_slaves,
      g_num_slaves  => c_si_wishbone_masters,
      g_registered  => true,
      g_address     => c_si_address,
      g_mask        => c_si_mask)
    port map (
      clk_sys_i => clk_i,
      rst_n_i   => rst_n_i,
      slave_i   => si_slave_in,
      slave_o   => si_slave_out,
      master_i  => si_master_in,
      master_o  => si_master_out);

  sp_master_o                   <= si_master_out(c_si_master_sp);
  si_master_in (c_si_master_sp) <= sp_master_i;

  si_master_in(c_si_master_smem) <= cc_dummy_master_in;

  si_slave_in(c_si_slave_hac)    <= hac_master_out(c_hac_master_si);
  hac_master_in(c_hac_master_si) <= si_slave_out(c_si_slave_hac);

  si_slave_in(c_si_slave_ebs) <= cc_dummy_slave_in;
  -- fixme: bypass for EB slave
--  si_slave_in(c_si_slave_ebs) <= ebs_slave_i;
--  ebs_slave_o                 <= si_slave_out(c_si_slave_ebs);


  U_CPU_CSR : wrn_cpu_csr_wb_slave
    port map (
      rst_n_i    => rst_n_i,
      clk_sys_i  => clk_i,
      wb_adr_i   => hac_master_out(c_hac_master_cpu_csr).adr(5 downto 2),
      wb_dat_i   => hac_master_out(c_hac_master_cpu_csr).dat,
      wb_dat_o   => hac_master_in(c_hac_master_cpu_csr).dat,
      wb_cyc_i   => hac_master_out(c_hac_master_cpu_csr).cyc,
      wb_sel_i   => hac_master_out(c_hac_master_cpu_csr).sel,
      wb_stb_i   => hac_master_out(c_hac_master_cpu_csr).stb,
      wb_we_i    => hac_master_out(c_hac_master_cpu_csr).we,
      wb_ack_o   => hac_master_in(c_hac_master_cpu_csr).ack,
      wb_stall_o => hac_master_in(c_hac_master_cpu_csr).stall,
      regs_i     => cpu_csr_towb,
      regs_o     => cpu_csr_fromwb);


  cpu_index <= to_integer(unsigned(cpu_csr_fromwb.core_sel_o));

  cpu_csr_towb.app_id_i       <= g_config.app_id;
  cpu_csr_towb.core_count_i   <= std_logic_vector(to_unsigned(g_config.cpu_count, 4));
  cpu_csr_towb.core_memsize_i <= std_logic_vector(to_unsigned(g_config.cpu_memsizes(cpu_index), 16));

  gen_cpus : for i in 0 to g_config.cpu_count-1 generate

    U_CPU_Block : wrn_cpu_cb
      generic map (
        g_cpu_id    => i,
        g_iram_size => g_config.cpu_memsizes(i))
      port map (
        clk_sys_i   => clk_i,
        rst_n_i     => rst_n_i,
        tm_i        => timing,
        sh_master_i => si_slave_out(c_si_slave_cpu0 + i),
        sh_master_o => si_slave_in(c_si_slave_cpu0 + i),
        dp_master_i => dp_master_i(i),
        dp_master_o => dp_master_o(i),
        cpu_csr_i   => cpu_csr_fromwb,
        --    cpu_csr_o   => cpu_csr_towb,
        rmq_ready_i => rmq_status,
        hmq_ready_i => hmq_status);

  end generate gen_cpus;

  U_Host_MQ : wrn_mqueue_host
    generic map (
      g_config => g_config.hmq_config)
    port map (
      clk_i        => clk_i,
      rst_n_i      => rst_n_i,
      si_slave_i   => si_master_out(c_si_master_hmq),
      si_slave_o   => si_master_in(c_si_master_hmq),
      host_slave_i => hac_master_out(c_hac_master_hmq),
      host_slave_o => hac_master_in(c_hac_master_hmq),
      host_irq_o   => host_irq_o,
      hmq_status_o => hmq_status);

  U_Remote_MQ : wrn_mqueue_remote
    generic map (
      g_config => g_config.rmq_config)
    port map (
      clk_i        => clk_i,
      rst_n_i      => rst_n_i,
      si_slave_i   => si_master_out(c_si_master_rmq),
      si_slave_o   => si_master_in(c_si_master_rmq),
      ebm_master_o => ebm_master_o,
      ebm_master_i => ebm_master_i,
      ebs_slave_o  => ebs_slave_o,
      ebs_slave_i  => ebs_slave_i,
      rmq_status_o => rmq_status);

end rtl;


