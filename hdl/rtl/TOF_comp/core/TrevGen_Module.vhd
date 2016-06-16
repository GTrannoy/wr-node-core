library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.TrevGen_wb_slave_pkg.vhd

entity TregGen_Module is
    port(
        -- System signals
        sys_clk_i  :  in std_logic;  
        rst_n_i    :  in std_logic;
        -- Trev module signals
        Tstamp2_i  :  in std_logic(30 downto 0);      
        Tstamp1_i  :  in std_logic(30 downto 0);      
        strobe_i_p :  in std_logic;
        B_clk_i    :  in std_logic; 
        WRcyc_i    :  in std_logic(27 downto 0); 
        Rev_clk_o  :  out std_logic ;
        -- Wishbone interface
        wb_addr_i: in std_logic_vector(31 downto 0);
	wb_data_i: in std_logic_vector(31 downto 0);
	wb_data_o: out std_logic_vector(31 downto 0);
	wb_cyc_i: in std_logic;
	wb_sel_i: in std_logic_vector(3 downto 0);
	wb_stb_i: in std_logic;
	wb_we_i: in std_logic;
	wb_ack_o: out std_logic;
	wb_stall_o : out std_logic;
        );
end entity TregGen_Module;

architecture rtl of TregGen_Module is

   component Trev_Gen is
       port ( sys_clk_i  :  in std_logic;   
              rst_n_i    :  in std_logic;
              Tstamp2_i  :  in std_logic(30 downto 0);    
              Tstamp1_i  :  in std_logic(30 downto 0);  
              strobe_i_p :  in std_logic;
              Tlatency_i :  in std_logic(19 downto 0);  
              B_clk_i    :  in std_logic;
              WRcyc_i    :  in std_logic(27 downto 0);  
              Rev_clk_o  :  out std_logic 
              ctr_regs_i :  in t_TOF_out_registers); 
   end component;

  signal regs_i: t_TOF_in_registers;
  signal regs_o: t_TOF_out_registers;

  begin

    cmp_TrevGen : TrevGen port map(
        sys_clk_i  <=  sys_clk_i;  
        Tstamp2_i  <=  Tstamp2_i;  
        Tstamp1_i  <=  Tstamp2_i;  
        strobe_i_p <=  strobe_i_p;    
        B_clk_i    <=  B_clk_i;  
        WRcyc_i    <=  WRcyc_i;  
        Rev_clk_o  <=  Rev_clk_o 
        ctr_regs_i <=  regs_o );          

    -- instantiate the wb interface generated with wbgen2
    cmp_TrevGen_wb_slave: TrevGen_wb_slave port map(
        rst_n_i     <=  rst_n_i;
        clk_sys_i   <=  clk_sys_i;
        wb_adr_i    <=  wb_addr_i;
        wb_dat_i    <=  wb_dat_i;
        wb_dat_o    <=  wb_dat_o;
        wb_cyc_i    <=  wb_cyc_i;
        wb_sel_i    <=  wb_sel_i;
        wb_sel_i    <=  wb_sel_i;
        wb_we_i     <=  wb_we_i;
        wb_ack_o    <=  wb_ack_o;
        wb_stall_o  <=  wb_stall_o;
        regs_i      <=  regs_i;
        regs_o      <=  regs_o );

