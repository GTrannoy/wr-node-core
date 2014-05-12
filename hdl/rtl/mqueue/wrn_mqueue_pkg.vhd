library ieee;
use ieee.std_logic_1164.all;

use work.wrn_private_pkg.all;
use work.wishbone_pkg.all;

package wrn_mqueue_pkg is

  type t_wrn_mqueue_slot_config is record
    width   : integer;
    entries : integer;
  end record;

  type t_wrn_mqueue_slot_config_array is array(integer range<>) of t_wrn_mqueue_slot_config;

  type t_wrn_mqueue_config is record
    in_slot_count   : integer;
    out_slot_count  : integer;
    in_slot_config  : t_wrn_mqueue_slot_config_array(0 to 15);
    out_slot_config : t_wrn_mqueue_slot_config_array(0 to 15);
  end record;

  constant c_wrn_default_mqueue_config : t_wrn_mqueue_config :=
    (2,
     2,
     ((16, 128), (64, 16),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0)),

     ((16, 128), (64, 16),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0)));

  type t_slot_bus_in is record
    sel : std_logic;
    dat : std_logic_vector(31 downto 0);
    adr : std_logic_vector(9 downto 0);
    we  : std_logic;
  end record;

  type t_slot_bus_out is record
    dat : std_logic_vector(31 downto 0);
  end record;

  type t_slot_status_out is record
    full         : std_logic;
    empty        : std_logic;
    count        : std_logic_vector(7 downto 0);
    current_size : std_logic_vector(7 downto 0);
    ready        : std_logic;
  end record;

  type t_slot_bus_in_array is array(integer range <>) of t_slot_bus_in;
  type t_slot_bus_out_array is array(integer range <>) of t_slot_bus_out;
  type t_slot_status_out_array is array(integer range <>) of t_slot_status_out;
 

  type t_wrn_irq_config is record
    mask_in   : std_logic_vector(15 downto 0);
    mask_out  : std_logic_vector(15 downto 0);
    threshold : std_logic_vector(7 downto 0);
    timeout   : std_logic_vector(7 downto 0);
  end record;

  constant c_dummy_status_out : t_slot_status_out := (
    '0', '0', x"00", x"00", '0');

  constant c_dummy_slot_bus_in : t_slot_bus_out := (
    dat => x"00000000"
  );

 
  -----------------------------------------------------------------------------
  -- Components
  -----------------------------------------------------------------------------

  component wrn_mqueue_slot
    generic (
      g_entries : integer;
      g_width   : integer);
    port (
      clk_i         : in  std_logic;
      rst_n_i       : in  std_logic;
      stat_o        : out t_slot_status_out;
      inb_i         : in  t_slot_bus_in;
      inb_o         : out t_slot_bus_out;
      outb_i        : in  t_slot_bus_in;
      outb_o        : out t_slot_bus_out;
      out_discard_i : in  std_logic := '0');
  end component;

  component wrn_mqueue_wishbone_slave
    generic (
      g_with_gcr : boolean;
      g_config   : t_wrn_mqueue_config);
    port (
      clk_i             : in  std_logic;
      rst_n_i           : in  std_logic;
      incoming_status_i :     t_slot_status_out_array(0 to g_config.in_slot_count-1);
      outgoing_status_i :     t_slot_status_out_array(0 to g_config.out_slot_count-1);
      incoming_o        : out t_slot_bus_in_array(0 to g_config.in_slot_count-1);
      incoming_i        : in  t_slot_bus_out_array(0 to g_config.in_slot_count-1);
      outgoing_o        : out t_slot_bus_in_array(0 to g_config.out_slot_count-1);
      outgoing_i        : in  t_slot_bus_out_array(0 to g_config.out_slot_count-1);
      slave_i           : in  t_wishbone_slave_in;
      slave_o           : out t_wishbone_slave_out;
      irq_config_o      : out t_wrn_irq_config);
  end component;

  component wrn_mqueue_irq_unit
    generic (
      g_config : t_wrn_mqueue_config);
    port (
      clk_i             : in  std_logic;
      rst_n_i           : in  std_logic;
      incoming_status_i :     t_slot_status_out_array(0 to g_config.in_slot_count-1);
      outgoing_status_i :     t_slot_status_out_array(0 to g_config.out_slot_count-1);
      irq_o             : out std_logic);
  end component;
  

end wrn_mqueue_pkg;

