library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.wr_node_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.etherbone_pkg.all;
use work.genram_pkg.all;

entity wrn_mqueue_etherbone_output is
  
  generic (
    g_config : t_wrn_mqueue_config);

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    slots_i : in  t_slot_bus_out_array(0 to g_config.out_slot_count-1);
    slots_o : out t_slot_bus_in_array(0 to g_config.out_slot_count-1);

    stat_i    : in  t_slot_status_out_array(0 to g_config.out_slot_count-1);
    discard_o : out std_logic_vector(g_config.out_slot_count-1 downto 0);

    ebm_o : out t_wishbone_master_out;
    ebm_i : in  t_wishbone_master_in := cc_dummy_master_in;

    host_slave_i : in  t_wishbone_slave_in;
    host_slave_o : out t_wishbone_slave_out
    );

end wrn_mqueue_etherbone_output;

architecture rtl of wrn_mqueue_etherbone_output is
  function f_prio_encode (x : std_logic_vector) return std_logic_vector is
    variable rv : std_logic_vector(f_log2_size(x'length) -1 downto 0);
  begin
    rv := (others => '0');
    for i in 0 to x'length-1 loop
      if x(i) = '1' then
        rv := std_logic_vector(to_unsigned(i, f_log2_size(x'length)));
        return rv;
      end if;
    end loop;  -- i 
    return rv;
  end function;

  type t_wishbone_op is (INACTIVE, NO_XFER, READ, WRITE);
  
  procedure f_wishbone_op (signal master : out t_wishbone_master_out;
                           op            :     t_wishbone_op;
                           addr          :     unsigned         := x"00000000";
                           data          :     std_logic_vector := x"00000000") is
  begin
    if(op = INACTIVE) then
      master.cyc <= '0';
    else
      master.cyc <= '1';
    end if;

    if(op = NO_XFER or op = INACTIVE) then
      master.stb <= '0';
    else
      master.stb <= '1';
    end if;

    master.adr <= std_logic_vector(resize(addr, 32));
    master.dat <= data;
    master.sel <= "1111";
    if(op = WRITE) then
      master.we <= '1';
    else
      master.we <= '0';
    end if;
  end procedure;

  procedure f_wishbone_op (signal master : out t_wishbone_master_out;
                           op            :     t_wishbone_op;
                           addr          :     natural;
                           data          :     std_logic_vector := x"00000000") is
  begin
    f_wishbone_op(master, op, to_unsigned(addr, 24), data);
  end procedure;



  constant c_CLEAR        : natural := 0;                  --wo    00
  constant c_FLUSH        : natural := c_CLEAR +4;         --wo    04
  constant c_STATUS       : natural := c_FLUSH +4;         --rw    08
  constant c_SRC_MAC_HI   : natural := c_STATUS +4;        --rw    0C
  constant c_SRC_MAC_LO   : natural := c_SRC_MAC_HI +4;    --rw    10 
  constant c_SRC_IPV4     : natural := c_SRC_MAC_LO +4;    --rw    14 
  constant c_SRC_UDP_PORT : natural := c_SRC_IPV4 +4;      --rw    18
  constant c_DST_MAC_HI   : natural := c_SRC_UDP_PORT +4;  --rw    1C
  constant c_DST_MAC_LO   : natural := c_DST_MAC_HI +4;    --rw    20
  constant c_DST_IPV4     : natural := c_DST_MAC_LO +4;    --rw    24
  constant c_DST_UDP_PORT : natural := c_DST_IPV4 +4;      --rw    28
  constant c_PAC_LEN      : natural := c_DST_UDP_PORT +4;  --rw    2C
  constant c_ADR_HI       : natural := c_PAC_LEN +4;       --rw    30
  constant c_OPS_MAX      : natural := c_ADR_HI +4;        --rw    34
  constant c_EB_OPT       : natural := c_OPS_MAX +4;       --rw    40

  constant c_STAT_CONFIGURED : t_wishbone_data := x"00000001";
  constant c_STAT_BUSY       : t_wishbone_data := x"00000002";
  constant c_STAT_ERROR      : t_wishbone_data := x"00000004";
  constant c_STAT_EB_SENT    : t_wishbone_data := x"FFFF0000";


  type t_arb_state is (ARB_IDLE, ARB_SEND);

  constant c_slot_index_size : integer := f_log2_size(g_config.out_slot_count);


  signal arb_state : t_arb_state;

  signal slot_ready : std_logic;
  signal slot_sel   : std_logic_vector(c_slot_index_size-1 downto 0);
  signal slot_done  : std_logic;

  signal slot_req : std_logic_vector(g_config.out_slot_count-1 downto 0);


  signal slot_in      : t_slot_bus_out;
  signal slot_stat    : t_slot_status_out;
  signal slot_out     : t_slot_bus_in;
  signal slot_discard : std_logic;

  type t_eb_state is (EB_WAIT_SLOT,
                      EB_SET_TARGET_IP,
                      EB_SET_TARGET_PORT,
                      EB_SET_TARGET_BASE,
                      EB_SET_XFER_SIZE,
                      EB_WRITE_DATA,
                      EB_FLUSH_XFER,
                      EB_READ_STATUS,
                      EB_SEND_CLAIM,
                      EB_SEND_READY,
                      EB_WAIT_XFER_DONE,
                      EB_SET_MAX_OPS,
                      EB_DUMMY_WAIT);

  signal eb_state : t_eb_state;

  signal eb_write_addr           : unsigned(23 downto 0);
  signal eb_write_start          : unsigned(23 downto 0);
  signal msg_size, msg_remaining : unsigned(7 downto 0);

  signal ack_count : unsigned(7 downto 0);


signal ebm_out : t_wishbone_master_out;
  signal slot_addr : unsigned(9 downto 0);
  
begin  -- rtl

  gen_slot_status : for i in 0 to g_config.out_slot_count-1 generate
    slot_req(i) <= stat_i(i).ready;
  end generate gen_slot_status;

  p_arbitrate_slots : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        arb_state  <= ARB_IDLE;
        slot_ready <= '0';
        slot_sel   <= (others => '0');
      else
        case arb_state is
          when ARB_IDLE =>
            if unsigned(slot_req) /= 0 then
              slot_sel   <= f_prio_encode(slot_req);
              slot_ready <= '1';
              arb_state  <= ARB_SEND;
            end if;

          when ARB_SEND =>
            if(slot_done = '1') then
              slot_ready <= '0';
              arb_state  <= ARB_IDLE;
            end if;
        end case;
      end if;
    end if;
  end process;

  p_pick_slot : process(slots_i, stat_i, slot_out, slot_sel, slot_ready, slot_discard)
    variable idx : integer;
    variable tmp : std_logic_vector(g_config.out_slot_count-1 downto 0);
    
  begin
    idx := to_integer(unsigned(slot_sel));
    if(slot_ready = '1') then
      slot_in   <= slots_i(idx);
      slot_stat <= stat_i(idx);
    else
      slot_in   <= c_dummy_slot_bus_in;
      slot_stat <= c_dummy_status_out;
    end if;

    tmp := (others => '0');
    if (slot_ready = '1') then
      tmp (idx) := slot_discard;
    end if;
    discard_o <= tmp;

    for i in 0 to g_config.out_slot_count-1 loop
      slots_o(i) <= slot_out;
    end loop;  -- i
    
  end process;


  p_eb_fsm_seq : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        eb_state     <= EB_WAIT_SLOT;
        slot_discard <= '0';
        slot_done    <= '0';
      else
        case eb_state is
          when EB_WAIT_SLOT =>
            slot_done    <= '0';
            slot_discard <= '0';
            slot_addr    <= to_unsigned(8, 10);

            if(slot_ready = '1') then
              eb_state      <= EB_SET_TARGET_IP;
              msg_size      <= unsigned(slot_stat.current_size) - 2;  -- fixme
              msg_remaining <= unsigned(slot_stat.current_size) - 3;
            end if;
            
          when EB_SET_TARGET_IP =>
            if(ebm_i.stall = '0') then
              eb_state  <= EB_SET_TARGET_PORT;
              slot_addr <= slot_addr + 4;
            end if;

          when EB_SET_TARGET_PORT =>
            if(ebm_i.stall = '0') then
              eb_state <= EB_SET_MAX_OPS;
            end if;

          when EB_SET_MAX_OPS =>
            if(ebm_i.stall = '0') then
              eb_state  <= EB_SET_TARGET_BASE;
              slot_addr <= slot_addr + 4;
            end if;

            
          when EB_SET_TARGET_BASE =>
            eb_write_addr  <= unsigned(slot_in.dat(23 downto 0)) + 8;
            eb_write_start <= unsigned(slot_in.dat(23 downto 0));
            eb_state       <= EB_SET_XFER_SIZE;

          when EB_SET_XFER_SIZE =>
            if(ebm_i.stall = '0') then
              eb_state <= EB_SEND_CLAIM;
            end if;


          when EB_SEND_CLAIM =>
            if(ebm_i.stall = '0') then
              slot_addr <= slot_addr + 4;
              eb_state  <= EB_WRITE_DATA;
            end if;
            

          when EB_WRITE_DATA =>
            if(ebm_i.stall = '0') then
              if(msg_remaining = 1) then
                eb_state <= EB_SEND_READY;
              else
                msg_remaining <= msg_remaining - 1;
                eb_write_addr <= eb_write_addr + 4;
                eb_state <= EB_DUMMY_WAIT;

              end if;
            end if;

          when EB_DUMMY_WAIT =>
            eb_state <= EB_WRITE_DATA;
            slot_addr     <= slot_addr + 4;
            
            
          when EB_SEND_READY =>
            if(ebm_i.stall = '0') then
              eb_state <= EB_FLUSH_XFER;
            end if;
            
          when EB_FLUSH_XFER =>
            if(ebm_i.stall = '0') then
              --  slot_discard <= '1';
              eb_state <= EB_READ_STATUS;
            end if;

          when EB_READ_STATUS =>
            if(ebm_i.stall = '0') then
              eb_state     <= EB_WAIT_XFER_DONE;
              slot_done    <= '1';
              slot_discard <= '1';
            end if;
            
          when EB_WAIT_XFER_DONE =>
            slot_done    <= '0';
            slot_discard <= '0';
            if(ack_count = 0) then
              eb_state <= EB_WAIT_SLOT;
            end if;
            
            
        end case;

      end if;
      
    end if;
  end process;



  p_eb_fsm_comb : process(eb_state, slot_in, slot_out, eb_write_addr, msg_size)
  begin
    
    case eb_state is
      when EB_WAIT_SLOT =>
        f_wishbone_op(ebm_out, INACTIVE);
      when EB_SET_TARGET_IP =>
        f_wishbone_op(ebm_out, WRITE, c_DST_IPV4, slot_in.dat);
      when EB_SET_TARGET_PORT =>
        f_wishbone_op(ebm_out, WRITE, c_DST_UDP_PORT, slot_in.dat);
      when EB_SET_TARGET_BASE =>
        f_wishbone_op(ebm_out, NO_XFER);
      when EB_SET_MAX_OPS =>
        f_wishbone_op(ebm_out, WRITE, c_OPS_MAX, std_logic_vector (resize(msg_size + 2, 32)));
      when EB_SET_XFER_SIZE =>
        f_wishbone_op(ebm_out, WRITE, c_PAC_LEN, x"00000080" ); --std_logic_vector (resize(msg_size, 32)));
      when EB_SEND_CLAIM =>
        f_wishbone_op(ebm_out, WRITE, resize(eb_write_start, 32) or x"03000000", x"01000000");
      when EB_WRITE_DATA =>
        f_wishbone_op(ebm_out, WRITE, resize(eb_write_addr, 32) or x"03000000", std_logic_vector (slot_in.dat));
      when EB_SEND_READY =>
        f_wishbone_op(ebm_out, WRITE, resize(eb_write_start, 32) or x"03000000", x"04000000" or std_logic_vector(resize(msg_size,32)));
      when EB_FLUSH_XFER =>
        f_wishbone_op(ebm_out, WRITE, c_FLUSH, x"00000001");
      when EB_READ_STATUS =>
        f_wishbone_op(ebm_out, READ, c_STATUS);
      when EB_WAIT_XFER_DONE =>
        f_wishbone_op(ebm_out, NO_XFER);
      when EB_DUMMY_WAIT =>
        f_wishbone_op(ebm_out, NO_XFER);
      when others =>
        f_wishbone_op(ebm_out, INACTIVE);
    end case;
    

  end process;

  p_slot_output_address : process(eb_state, ebm_i, slot_addr)
  begin
    case eb_state is
      when EB_WAIT_SLOT =>
        slot_out.adr <= std_logic_vector(to_unsigned(8, 10));

      when EB_SET_TARGET_IP =>
        if(ebm_i.stall = '0') then
          slot_out.adr <= std_logic_vector(slot_addr + 4);
        else
          slot_out.adr <= std_logic_vector(slot_addr);
        end if;
        
      when EB_SET_TARGET_PORT =>
        if(ebm_i.stall = '0') then
          slot_out.adr <= std_logic_vector(slot_addr + 4);
        else
          slot_out.adr <= std_logic_vector(slot_addr);
        end if;
        
      when EB_SET_TARGET_BASE =>
        if(ebm_i.stall = '0') then
          slot_out.adr <= std_logic_vector(slot_addr + 4);
        else
          slot_out.adr <= std_logic_vector(slot_addr);
        end if;

      when EB_SET_MAX_OPS =>
        if(ebm_i.stall = '0') then
          slot_out.adr <= std_logic_vector(slot_addr + 4);
        else
          slot_out.adr <= std_logic_vector(slot_addr);
        end if;
        
      when EB_WRITE_DATA =>
        if(ebm_i.stall = '0') then
          slot_out.adr <= std_logic_vector(slot_addr + 4);
        else
          slot_out.adr <= std_logic_vector(slot_addr);
        end if;

      when EB_SET_XFER_SIZE =>
        if(ebm_i.stall = '0') then
          slot_out.adr <= std_logic_vector(slot_addr + 4);
        else
          slot_out.adr <= std_logic_vector(slot_addr);
        end if;

        
      when EB_SEND_CLAIM =>
        if(ebm_i.stall = '0') then
          slot_out.adr <= std_logic_vector(slot_addr + 4);
        else
          slot_out.adr <= std_logic_vector(slot_addr);
        end if;


      when EB_DUMMY_WAIT =>
        if(ebm_i.stall = '0') then
          slot_out.adr <= std_logic_vector(slot_addr + 4);
        else
          slot_out.adr <= std_logic_vector(slot_addr);
        end if;
        
        
      when others =>
        slot_out.adr <= (others => '0');
    end case;
  end process;

  p_count_acks : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if(ebm_out.cyc = '0') then
        ack_count <= (others => '0');
      elsif(ebm_out.cyc = '1' and ebm_out.stb = '1' and ebm_i.stall = '0' and ebm_i.ack = '0') then
        ack_count <= ack_count + 1;
      elsif(ebm_out.cyc = '1' and (ebm_out.stb = '0' or ebm_i.stall = '1') and ebm_i.ack = '1') then
        ack_count <= ack_count - 1;
      end if;
      
    end if;
  end process;

  ebm_o <= ebm_out;
  
end rtl;
