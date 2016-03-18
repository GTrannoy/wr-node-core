library ieee;
use ieee.std_logic_1164.all;

entity vector_fifo is
    generic (
        VECTOR_WIDTH: natural := 14;
        FIFO_DEPTH: natural := 32  );
    port (
        clk_i: 	in std_logic;
        rst_n_i: 	in std_logic;
        x_i: 		in std_logic_vector(VECTOR_WIDTH-1 downto 0);
	x_valid_i: 	in std_logic;
        y_o: 		out std_logic_vector(VECTOR_WIDTH-1 downto 0);
	y_valid_o: 	out std_logic  );
end;

architecture rtl of vector_fifo is
    type fifo_memory_type is array (natural range <>) of std_logic_vector(VECTOR_WIDTH-1 downto 0);
    signal fifo_memory: fifo_memory_type(0 to FIFO_DEPTH-1);
    signal fifo_valid: std_logic_vector(0 to FIFO_DEPTH-1);

begin
    process (clk_i, rst_n_i) begin
        if (rst_n_i = '0') then
            fifo_memory <= (others => (others => '0'));
        elsif rising_edge(clk_i) then
            fifo_memory <= x_i & fifo_memory(0 to FIFO_DEPTH-2);
        end if;
    end process;

    y_o <= fifo_memory(FIFO_DEPTH-1);

    process (clk_i, rst_n_i) begin
        if (rst_n_i = '0') then
            fifo_valid <= (others => '0');
        elsif rising_edge(clk_i) then
            fifo_valid <= x_valid_i & fifo_valid(0 to FIFO_DEPTH-2);
        end if;
    end process;

    y_valid_o <= fifo_valid(FIFO_DEPTH-1);

end;
