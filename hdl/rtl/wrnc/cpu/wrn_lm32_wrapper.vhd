-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_lm32_wrapper.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-02-03
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- A small wrapper for the LM32 encompassing the internal RAM and
-- access to the RAM through CPU CSR register block.
-------------------------------------------------------------------------------
--
-- Copyright (c) 2014-2015 CERN
--
-- This source file is free software; you can redistribute it   
-- and/or modify it under the terms of the GNU Lesser General   
-- Public License as published by the Free Software Foundation; 
-- either version 2.1 of the License, or (at your option) any   
-- later version.                                               
--
-- This source is distributed in the hope that it will be       
-- useful, but WITHOUT ANY WARRANTY; without even the implied   
-- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      
-- PURPOSE.  See the GNU Lesser General Public License for more 
-- details.                                                     
--
-- You should have received a copy of the GNU Lesser General    
-- Public License along with this source; if not, download it   
-- from http://www.gnu.org/licenses/lgpl-2.1.html
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.genram_pkg.all;
use work.wishbone_pkg.all;
use work.wrn_cpu_csr_wbgen2_pkg.all;
use work.wrn_private_pkg.all;

entity wrn_lm32_wrapper is
  generic(
    g_iram_size         : integer;
    g_cpu_id            : integer;
    g_double_core_clock : boolean
    );

  port(
    clk_cpu_i : in std_logic;
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
--      clk_wb_i  : in std_logic;
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

  -- reserved for simulation purposes. firmware name
  -- will be passed through a generic
  impure function f_pick_init_file return string is
  begin
    if g_cpu_id = 0 then
--      return "rt-tdc.ram";
      return "none";
    else
      return "none";
    end if;
  end function;


  signal jtag_clk        : std_logic;
  signal jtag_update     : std_logic;
  signal jtag_reg_q      : std_logic_vector(7 downto 0);
  signal jtag_reg_addr_q : std_logic_vector(2 downto 0);
  signal jtag_reg_d      : std_logic_vector(7 downto 0);
  signal jtag_reg_addr_d : std_logic_vector (2 downto 0);

  signal cpu_reset, cpu_enable, cpu_reset_n : std_logic;
  signal host_rdata                         : std_logic_vector(31 downto 0);
  signal host_write                         : std_logic;

  signal d_adr : std_logic_vector(31 downto 0);

  signal core_sel_match : std_logic;

  signal iram_i_wr, iram_d_wr                : std_logic;
  signal iram_i_en, iram_i_en_cpu, iram_d_en : std_logic;

  signal iram_i_adr_cpu, iram_d_adr                             : std_logic_vector(31 downto 0);
  signal udata_addr, iram_i_adr, iram_i_adr_host                : std_logic_vector(f_log2_size(g_iram_size)-3 downto 0);
  signal iram_i_dat_q, iram_i_dat_d, iram_d_dat_d, iram_d_dat_q : std_logic_vector(31 downto 0);
  signal iram_d_sel                                             : std_logic_vector(3 downto 0);

  signal cpu_dwb_out, cpu_dwb_out_sys : t_wishbone_master_out;
  signal cpu_dwb_in, cpu_dwb_in_sys   : t_wishbone_master_in;
  signal bwe                          : std_logic_vector(3 downto 0);
  signal wr_d                         : std_logic_vector(3 downto 0);
  signal data_d0, iram_d_dat_out      : std_logic_vector(31 downto 0);


  signal udata_load_d0, udata_wr : std_logic;
  signal udata_out, udata_in     : std_logic_vector(31 downto 0);

  signal clk_div2, clk_div2_d0, wb_io_sync : std_logic;
  signal wb_dat_d0, wb_io_sync_ext         : std_logic_vector(31 downto 0);
  signal wb_ack_d0, wb_cyc_d0              : std_logic;
  signal iram_bwe                          : std_logic_vector(3 downto 0);

  signal dwb_out : t_wishbone_master_out;
  
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
  
begin



  gen_with_double_core_clock : if g_double_core_clock generate

    U_CPU : lm32_cpu_wr_node
      generic map (
        eba_reset => x"00000000")
      port map (
        clk_i        => clk_cpu_i,
        rst_i        => cpu_reset,
        interrupt    => x"00000000",
-- instruction bus
        iram_i_adr_o => iram_i_adr_cpu,
        iram_i_dat_i => iram_i_dat_q,
        iram_i_en_o  => iram_i_en_cpu,
-- data bus (IRAM)
        iram_d_adr_o => iram_d_adr,
        iram_d_dat_o => iram_d_dat_d,
        iram_d_dat_i => iram_d_dat_q,
        iram_d_sel_o => iram_d_sel,
        iram_d_we_o  => iram_d_wr,
        iram_d_en_o  => iram_d_en,

        D_DAT_O => cpu_dwb_out.dat,
        D_ADR_O => cpu_dwb_out.adr,
        D_CYC_O => cpu_dwb_out.cyc,
        D_SEL_O => cpu_dwb_out.sel,
        D_STB_O => cpu_dwb_out.stb,
        D_WE_O  => cpu_dwb_out.we,
        D_DAT_I => cpu_dwb_in.dat,
        D_ACK_I => cpu_dwb_in.ack,
        D_ERR_I => cpu_dwb_in.err,
        D_RTY_I => cpu_dwb_in.rty);

    -- double core clock sync logic
    process(clk_sys_i)
    begin
      if rising_edge(clk_sys_i) then
        if rst_n_i = '0' then
          clk_div2 <= '0';
        else
          clk_div2 <= not clk_div2;
        end if;
      end if;
    end process;

    process(clk_cpu_i)
    begin
      if rising_edge(clk_cpu_i) then
        if rst_n_i = '0' then
          clk_div2_d0 <= '0';
          wb_io_sync  <= '0';
          wb_cyc_d0   <= '0';
        else
          clk_div2_d0 <= clk_div2;
          wb_io_sync  <= (clk_div2_d0 xor clk_div2);
          wb_cyc_d0   <= cpu_dwb_out.cyc;

          if cpu_dwb_in_sys.ack = '1' and wb_io_sync = '0' then
            wb_ack_d0 <= '1';
            wb_dat_d0 <= cpu_dwb_in_sys.dat;
          else
            wb_ack_d0 <= '0';
            wb_dat_d0 <= (others => '0');
          end if;
          
        end if;
      end if;
    end process;


    cpu_dwb_out_sys.dat <= cpu_dwb_out.dat;
    cpu_dwb_out_sys.adr <= cpu_dwb_out.adr;
    cpu_dwb_out_sys.sel <= cpu_dwb_out.sel;
    cpu_dwb_out_sys.we  <= '0' when cpu_dwb_out.cyc = '1' and wb_cyc_d0 = '0' and wb_io_sync = '1' else cpu_dwb_out.we;
    cpu_dwb_out_sys.stb <= '0' when cpu_dwb_out.cyc = '1' and wb_cyc_d0 = '0' and wb_io_sync = '1' else cpu_dwb_out.stb;
    cpu_dwb_out_sys.cyc <= '0' when cpu_dwb_out.cyc = '1' and wb_cyc_d0 = '0' and wb_io_sync = '1' else cpu_dwb_out.cyc;

    wb_io_sync_ext <= (others => wb_io_sync);

    cpu_dwb_in.ack <= wb_ack_d0 or (cpu_dwb_in_sys.ack and wb_io_sync);
    cpu_dwb_in.dat <= wb_dat_d0 or (cpu_dwb_in_sys.dat and wb_io_sync_ext);

    cpu_dwb_in.err <= '0';
    cpu_dwb_in.rty <= '0';

    iram : generic_dpram
      generic map (
        g_data_width               => 32,
        g_size                     => g_iram_size / 4,
        g_with_byte_enable         => true,
        g_dual_clock               => false,
        g_addr_conflict_resolution => "read_first",
        g_init_file                => f_pick_init_file)
      port map (
        rst_n_i => rst_n_i,
        clka_i  => clk_cpu_i,


        wea_i => iram_i_wr,
        aa_i  => iram_i_adr,
        da_i  => iram_i_dat_d,
        qa_o  => iram_i_dat_q,

        clkb_i => clk_cpu_i,
        bweb_i => iram_d_sel,
        web_i  => iram_d_wr,
        ab_i   => iram_d_adr(f_log2_size(g_iram_size)-1 downto 2),
        db_i   => iram_d_dat_d,
        qb_o   => iram_d_dat_q
        );

    iram_i_dat_d <= udata_in;
    iram_i_wr    <= udata_wr;
    iram_i_adr   <= udata_addr when cpu_enable = '0' else
                    iram_i_adr_cpu(f_log2_size(g_iram_size)-1 downto 2);

    

    p_cpu_xfer : process(clk_cpu_i)
    begin
      if rising_edge(clk_cpu_i) then
        udata_load_d0 <= cpu_csr_i.udata_load_o and core_sel_match;

        udata_addr <= cpu_csr_i.uaddr_addr_o(f_log2_size(g_iram_size)-3 downto 0);

        if(udata_load_d0 = '1' and cpu_csr_i.udata_load_o = '0' and core_sel_match = '1') then
          udata_in <= cpu_csr_i.udata_o;
          udata_wr <= '1';
        else
          udata_wr <= '0';
        end if;
      end if;
    end process;

    p_cpu_xfer_sys : process(clk_sys_i)
    begin
      if rising_edge(clk_sys_i) then
        cpu_csr_o.udata_i <= iram_i_dat_q;
      end if;
    end process;
    
  end generate gen_with_double_core_clock;

  gen_without_double_core_clock : if not g_double_core_clock generate
    U_CPU : lm32_cpu_wr_node
      generic map (
        eba_reset => x"00000000")
      port map (
        clk_i        => clk_sys_i,
        rst_i        => cpu_reset,
        interrupt    => x"00000000",
-- instruction bus
        iram_i_adr_o => iram_i_adr_cpu,
        iram_i_dat_i => iram_i_dat_q,
        iram_i_en_o  => iram_i_en_cpu,
-- data bus (IRAM)
        iram_d_adr_o => iram_d_adr,
        iram_d_dat_o => iram_d_dat_d,
        iram_d_dat_i => iram_d_dat_q,
        iram_d_sel_o => iram_d_sel,
        iram_d_we_o  => iram_d_wr,
        iram_d_en_o  => iram_d_en,

        D_DAT_O => cpu_dwb_out.dat,
        D_ADR_O => cpu_dwb_out.adr,
        D_CYC_O => cpu_dwb_out.cyc,
        D_SEL_O => cpu_dwb_out.sel,
        D_STB_O => cpu_dwb_out.stb,
        D_WE_O  => cpu_dwb_out.we,
        D_DAT_I => cpu_dwb_in.dat,
        D_ACK_I => cpu_dwb_in.ack,
        D_ERR_I => cpu_dwb_in.err,
        D_RTY_I => cpu_dwb_in.rty);


    --chipscope_ila_1 : chipscope_ila
    --  port map (
    --    CONTROL => CONTROL,
    --    CLK     => clk_sys_i,
    --    TRIG0   => TRIG0,
    --    TRIG1   => TRIG1,
    --    TRIG2   => TRIG2,
    --    TRIG3   => TRIG3);

    --chipscope_icon_1 : chipscope_icon
    --  port map (
    --    CONTROL0 => CONTROL);

    trig0(0)  <= cpu_reset;
    trig0(1)  <= iram_i_en_cpu;
    trig0(2)  <= cpu_dwb_out.cyc;
    trig0(3)  <= cpu_dwb_out.stb;
    trig0(4)  <= cpu_dwb_out.we;
    trig0(5)  <= cpu_dwb_in.ack;
    trig0(6)  <= cpu_dwb_in.err;
    trig0(7)  <= cpu_dwb_in.rty;
    trig0(8)  <= cpu_dwb_in.stall;
    trig0(9)  <= dwb_i.ack;
    trig0(10) <= dwb_i.err;
    trig0(11) <= dwb_i.rty;
    trig0(12) <= dwb_i.stall;
    trig3     <= cpu_dwb_out.adr;
    trig1     <= iram_i_adr_cpu;
    trig2     <= iram_d_adr;



    cpu_dwb_in      <= cpu_dwb_in_sys;
    cpu_dwb_out_sys <= cpu_dwb_out;

    gen_iram_blocks : for i in 0 to 3 generate
      
      iram : generic_dpram
        generic map (
          g_data_width               => 8,
          g_size                     => g_iram_size / 4,
          g_with_byte_enable         => false,
          g_dual_clock               => false,
          g_addr_conflict_resolution => "dont_care")
        port map (
          rst_n_i => rst_n_i,
          clka_i  => clk_sys_i,

          wea_i => iram_i_wr,
          aa_i  => iram_i_adr,
          da_i  => iram_i_dat_d(8*i+7 downto 8*i),
          qa_o  => iram_i_dat_q(8*i+7 downto 8*i),

          clkb_i => clk_sys_i,
          web_i  => iram_bwe(i),
          ab_i   => iram_d_adr(f_log2_size(g_iram_size)-1 downto 2),
          db_i   => iram_d_dat_d(8*i+7 downto 8*i),
          qb_o   => iram_d_dat_q(8*i+7 downto 8*i)
          );

      iram_bwe(i) <= iram_d_sel(i) and iram_d_wr;
      
    end generate gen_iram_blocks;



    iram_i_dat_d <= cpu_csr_i.udata_o;
    iram_i_wr    <= cpu_csr_i.udata_load_o and core_sel_match;
    iram_i_adr   <= cpu_csr_i.uaddr_addr_o(f_log2_size(g_iram_size)-3 downto 0) when cpu_enable = '0' else
                    iram_i_adr_cpu(f_log2_size(g_iram_size)-1 downto 2);

    iram_i_en <= '1' when cpu_enable = '0' else iram_i_en_cpu;

    cpu_csr_o.udata_i <= iram_i_dat_q;

    
  end generate gen_without_double_core_clock;



  U_Classic2Pipe : wb_slave_adapter
    generic map (
      g_master_use_struct  => true,
      g_master_mode        => PIPELINED,
      g_master_granularity => BYTE,
      g_slave_use_struct   => true,
      g_slave_mode         => CLASSIC,
      g_slave_granularity  => BYTE)
    port map (
      clk_sys_i => clk_sys_i,
      rst_n_i   => rst_n_i,
      slave_i   => cpu_dwb_out_sys,
      slave_o   => cpu_dwb_in_sys,
      master_i  => dwb_i,
      master_o  => dwb_out);

  dwb_o <= dwb_out;
  
  core_sel_match <= '1' when unsigned(cpu_csr_i.core_sel_o) = g_cpu_id else '0';

  cpu_reset   <= not rst_n_i or (cpu_csr_i.reset_o(g_cpu_id) and not dwb_out.cyc);
  cpu_enable  <= not cpu_reset;
  cpu_reset_n <= not cpu_reset;

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
