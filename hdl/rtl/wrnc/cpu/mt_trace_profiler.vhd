library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wr_node_pkg.all;
use work.wrn_private_pkg.all;
use work.wrn_cpu_csr_wbgen2_pkg.all;
use work.gencores_pkg.all;
use work.genram_pkg.all;

entity mt_trace_profiler is
  generic (
    g_config : t_wr_node_config);

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    cpu_pc_i       : in t_pc_array(0 to g_config.cpu_count-1);
    cpu_pc_valid_i : in std_logic_vector(g_config.cpu_count-1 downto 0);

    csr_regs_i : in  t_wrn_cpu_csr_out_registers;
    csr_regs_o : out t_wrn_cpu_csr_in_registers
    );

end mt_trace_profiler;

architecture rtl of mt_trace_profiler is

  constant c_ACTION_START_REC   : std_logic_vector(3 downto 0) := x"0";
  constant c_ACTION_STOP_REC    : std_logic_vector(3 downto 0) := x"1";
  constant c_ACTION_PROBE_START : std_logic_vector(3 downto 0) := x"2";
  constant c_ACTION_PROBE_END   : std_logic_vector(3 downto 0) := x"3";
  constant c_ACTION_DISABLED    : std_logic_vector(3 downto 0) := x"f";

  type t_channel is record
    core_id  : std_logic_vector(2 downto 0);
    pc       : std_logic_vector(c_mt_pc_bits-1 downto 0);
    pc_valid : std_logic;
    pc_match : std_logic_vector(c_mt_pc_bits-1 downto 0);
    action   : std_logic_vector(3 downto 0);
    hit      : std_logic;
    ack      : std_logic;
    ts       : unsigned(26 downto 0);
  end record;

  type t_channel_array is array(0 to g_config.tpu_channels-1) of t_channel;
  type t_state is (ST_IDLE, ST_RECORDING, ST_DONE);

  signal ts_counter : unsigned(26 downto 0);



  signal ch    : t_channel_array;
  signal state : t_state;

  signal chan_sel : integer range 0 to g_config.tpu_channels-1;

  signal start_rec_v, stop_rec_v : std_logic_vector(g_config.tpu_channels-1 downto 0);
  signal start_rec, stop_rec     : std_logic;

  constant c_mem_addr_width : integer := f_log2_size(g_config.tpu_buffer_size);

  signal arb_input_data  : std_logic_vector(32 * g_config.tpu_channels-1 downto 0);
  signal arb_input_req   : std_logic_vector(g_config.tpu_channels-1 downto 0);
  signal arb_input_valid : std_logic_vector(g_config.tpu_channels-1 downto 0);

  signal arb_out_data  : std_logic_vector(31 downto 0);
  signal arb_out_valid : std_logic;

  signal mem_addr  : unsigned(c_mem_addr_width - 1 downto 0);
  signal mem_rdata : std_logic_vector(31 downto 0);

  signal channel_id : integer range 0 to g_config.tpu_channels-1;

  
begin

  p_ts_counter : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ts_counter <= (others => '0');
      else
        ts_counter <= ts_counter + 1;
      end if;
    end if;
  end process;




  gen_channels : for i in 0 to g_config.tpu_channels-1 generate
    
    p_mux_pcs : process(clk_i)
    begin
      if rising_edge(clk_i) then
        ch(i).pc       <= cpu_pc_i(to_integer(unsigned(ch(i).core_id)));
        ch(i).pc_valid <= cpu_pc_valid_i(to_integer(unsigned(ch(i).core_id)));
      end if;
    end process;

    p_match_logic : process(clk_i)
    begin
      if rising_edge(clk_i) then
        start_rec_v(i) <= '0';
        stop_rec_v(i)  <= '0';

        if rst_n_i = '0' or ch(i).action = c_ACTION_DISABLED or ch(i).ack = '1' then
          ch(i).hit <= '0';
        elsif (ch(i).pc = ch(i).pc_match and ch(i).pc_valid = '1') then

          ch(i).ts <= ts_counter;

          if (ch(i).action = c_ACTION_START_REC) then
            start_rec_v(i) <= '1';
            ch(i).hit <= '1';
          elsif (ch(i).action = c_ACTION_STOP_REC) then
            stop_rec_v(i) <= '1';
            ch(i).hit <= '1';
          elsif ( state = ST_RECORDING ) then
            ch(i).hit <= '1';
            
          end if;
        end if;
      end if;
    end process;

    p_gen_arb_req_ack : process(state, ch, arb_input_req)
    begin
      if ( ch(i).hit = '1' ) then
        arb_input_valid(i) <= '1';
      else
        arb_input_valid(i) <= '0';
      end if;

      arb_input_data(32 * (i+1) -1 downto 32 * i) <= std_logic_vector(ch(i).ts) & std_logic_vector(to_unsigned(i, 5));
      ch(i).ack                                   <= ch(i).hit and arb_input_req(i);
    end process;

    p_channel_regs_write : process(clk_i)
    begin
      if rising_edge(clk_i) then
        if (csr_regs_i.tpu_probe_csr_pc_load_o = '1' and i = channel_id) then
          ch(i).pc_match <= csr_regs_i.tpu_probe_csr_pc_o(c_mt_pc_bits-1 downto 0);
          ch(i).core_id  <= csr_regs_i.tpu_probe_csr_core_id_o(2 downto 0);
          ch(i).action   <= csr_regs_i.tpu_probe_csr_action_o;
        end if;
      end if;
    end process;

    
  end generate gen_channels;

  start_rec <= f_reduce_or (start_rec_v);
  stop_rec  <= f_reduce_or (stop_rec_v);


  U_Arbitrate_Buffer : gc_arbitrated_mux
    generic map (
      g_num_inputs => g_config.tpu_channels,
      g_width      => 32)
    port map (
      clk_i     => clk_i,
      rst_n_i   => rst_n_i,
      d_i       => arb_input_data,
      d_valid_i => arb_input_valid,
      d_req_o   => arb_input_req,
      q_o       => arb_out_data,
      q_valid_o => arb_out_valid);

  U_Sample_Buffer : generic_dpram
    generic map (
      g_data_width       => 32,
      g_size             => g_config.tpu_buffer_size,
      g_with_byte_enable => false,
      g_dual_clock       => false)
    port map (
      rst_n_i => rst_n_i,
      clka_i  => clk_i,
      wea_i   => arb_out_valid,
      aa_i    => std_logic_vector(mem_addr),
      da_i    => arb_out_data,
      clkb_i  => clk_i,
      web_i   => '0',
      ab_i    => csr_regs_i.tpu_buf_addr_o(c_mem_addr_width-1 downto 0),
      qb_o    => mem_rdata);

  p_fsm : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' or csr_regs_i.tpu_csr_enable_o = '0' then
        state <= ST_IDLE;
        mem_addr <= (others => '0');
      else
        case state is
          when ST_IDLE =>
            csr_regs_o.tpu_csr_ready_i <= '0';
            if (start_rec = '1' or csr_regs_i.tpu_csr_force_start_o = '1') then
              state    <= ST_RECORDING;
              mem_addr <= (others => '0');
            end if;
            
          when ST_RECORDING =>
            if (arb_out_valid = '1') then
              mem_addr <= mem_addr + 1;
              if(mem_addr = g_config.tpu_buffer_size - 1) then
                state <= ST_DONE;
              end if;

            end if;

            if (stop_rec = '1') then
              state <= ST_DONE;
            end if;

          when ST_DONE =>
            csr_regs_o.tpu_csr_ready_i <= '1';
        end case;
      end if;
    end if;
  end process;

  channel_id <= to_integer(unsigned(csr_regs_i.tpu_csr_probe_sel_o));

  p_channel_regs_read : process(clk_i)
  begin
    if rising_edge(clk_i) then
      csr_regs_o.tpu_probe_csr_pc_i      <= std_logic_vector(resize (unsigned(ch(channel_id).pc_match), 24));
      csr_regs_o.tpu_probe_csr_action_i  <= ch(channel_id).action;
      csr_regs_o.tpu_probe_csr_core_id_i <= '0'&ch(channel_id).core_id;
    end if;
  end process;


  csr_regs_o.tpu_buf_count_i       <= std_logic_vector (resize(mem_addr, 16));
  csr_regs_o.tpu_buf_size_i        <= std_logic_vector (to_unsigned(g_config.tpu_buffer_size, 16));
  csr_regs_o.tpu_csr_probe_count_i <= std_logic_vector(to_unsigned (g_config.tpu_channels, 5));
  csr_regs_o.tpu_buf_data_id_i     <= mem_rdata(31 downto 27);
  csr_regs_o.tpu_buf_data_tstamp_i <= mem_rdata(26 downto 0);



end rtl;

