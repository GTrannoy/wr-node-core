library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.gencores_pkg.all;
use work.wishbone_pkg.all;
use work.genram_pkg.all;

use work.acq_wbgen2_pkg.all;


entity d3s_acq_buffer is
  generic (
    g_data_width : integer;
    g_size       : integer);
  port (
    rst_n_sys_i : in std_logic;
    clk_sys_i   : in std_logic;
    clk_acq_i   : in std_logic;

    data_i : in std_logic_vector(g_data_width-1 downto 0);
    
	 freeze_i: in std_logic; -- Signal for freeezing a circular buffer
	 
    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out
    );
end d3s_acq_buffer;

architecture rtl of d3s_acq_buffer is
  component d3s_acq_buffer_wb is
    port (
      rst_n_i    : in  std_logic;
      clk_sys_i  : in  std_logic;
      wb_adr_i   : in  std_logic_vector(1 downto 0);
      wb_dat_i   : in  std_logic_vector(31 downto 0);
      wb_dat_o   : out std_logic_vector(31 downto 0);
      wb_cyc_i   : in  std_logic;
      wb_sel_i   : in  std_logic_vector(3 downto 0);
      wb_stb_i   : in  std_logic;
      wb_we_i    : in  std_logic;
      wb_ack_o   : out std_logic;
      wb_stall_o : out std_logic;
      clk_acq_i  : in  std_logic;
      regs_i     : in  t_acq_in_registers;
      regs_o     : out t_acq_out_registers);
  end component d3s_acq_buffer_wb;

  constant c_addr_bits : integer := f_log2_size(g_size);

  signal wr_addr : unsigned(c_addr_bits-1 downto 0);
  signal done    : std_logic;

  signal regs_in  : t_acq_in_registers;
  signal regs_out : t_acq_out_registers;

  signal acq_in_progress : std_logic;
  signal rst_n_acq : std_logic;
  
begin

    U_Sync_Reset : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_acq_i,
      rst_n_i  => '1',
      data_i   => rst_n_sys_i,
      synced_o => rst_n_acq);
    
  U_Wb : d3s_acq_buffer_wb
    port map (
      rst_n_i    => rst_n_sys_i,
      clk_sys_i  => clk_sys_i,
      wb_adr_i   => slave_i.adr(3 downto 2),
      wb_dat_i   => slave_i.dat,
      wb_dat_o   => slave_o.dat,
      wb_cyc_i   => slave_i.cyc,
      wb_sel_i   => slave_i.sel,
      wb_stb_i   => slave_i.stb,
      wb_we_i    => slave_i.we,
      wb_ack_o   => slave_o.ack,
      wb_stall_o => slave_o.stall,
      clk_acq_i  => clk_acq_i,
      regs_i     => regs_in,
      regs_o     => regs_out);

  slave_o.err <= '0';
  slave_o.rty <= '0';

  U_Buffer : generic_dpram
    generic map (
      g_data_width       => g_data_width,
      g_size             => g_size,
      g_with_byte_enable => false,
      g_dual_clock       => true)
    port map (
      rst_n_i => rst_n_sys_i,
      clka_i  => clk_acq_i,
      wea_i   => acq_in_progress,
      aa_i    => std_logic_vector(wr_addr),
      da_i    => data_i,
      clkb_i  => clk_sys_i,
      web_i   => '0',
      ab_i    => regs_out.addr_o(c_addr_bits-1 downto 0),
      qb_o    => regs_in.data_i(g_data_width-1 downto 0));

  
  p_counter : process(clk_acq_i)
  begin
    if rising_edge(clk_acq_i) then
      if rst_n_acq = '0' then
        acq_in_progress <= '0';
        wr_addr         <= (others => '0');
      else
        if(regs_out.cr_start_o = '1') then
          wr_addr         <= (others => '0');
          acq_in_progress <= '1';
        elsif (freeze_i = '1') then  -- new freeze feature
		    acq_in_progress <= '0';     -- new
		  elsif (acq_in_progress = '1') then
          if (wr_addr = g_size-2) then    -- changed g_size-1 by g_size-2
			   wr_addr  <= (others => '0');  -- Let's make the buffer circular till a 'freeze' signal is received
            -- acq_in_progress <= '0';
          end if;

          wr_addr <= wr_addr + 1;
        end if;
      end if;
    end if;
  end process;

  regs_in.cr_ready_i <= not acq_in_progress and freeze_i;
  
end rtl;
