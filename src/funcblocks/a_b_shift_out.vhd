library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.defs.all;

entity a_b_shift_out is
  generic (
    DATA_WIDTH : natural := DATA_WIDTH
  );

  port (
    in_req  : in  std_logic;
    in_ack  : out std_logic;
    in_data : in  std_logic_vector(DATA_WIDTH-1 downto 0);

    out_req  : out std_logic;
    out_ack  : in  std_logic;
    out_data : out std_logic_vector(DATA_WIDTH-1 downto 0)
  );
end a_b_shift_out;

architecture behav of a_b_shift_out is 
  constant OPERAND_WIDTH : integer := DATA_WIDTH / 2;

  signal a : std_logic_vector(OPERAND_WIDTH-1 downto 0);
  signal b : std_logic_vector(OPERAND_WIDTH-1 downto 0);

  -- results of the shift operations
  signal a_res : std_logic_vector(OPERAND_WIDTH-1 downto 0);
  signal b_res : std_logic_vector(OPERAND_WIDTH-1 downto 0);

  -- from add_block.vhd
  signal connect: std_logic := '0'; -- signal for constraining i/o (needed only for post-timing simulation)

  attribute DONT_TOUCH : string;
  attribute DONT_TOUCH of a, b : signal is "TRUE";
  attribute DONT_TOUCH of connect : signal is "TRUE";
begin
  
  dly_req : entity work.delay_element
    generic map(
      size => ADD_DELAY
    )
    port map(
      d => in_req,
      z => out_req
    );
  -- from add_block.vhd
  connect <= out_ack;
  in_ack <= connect;
  --in_ack <= out_ack;

  a <= in_data(DATA_WIDTH-1 downto OPERAND_WIDTH);
  b <= in_data(OPERAND_WIDTH-1 downto 0);

  a_res <= std_logic_vector(shift_left(unsigned(a), 1));
  b_res <= std_logic_vector(shift_right(unsigned(b), 1));

  out_data <= a_res & b_res after ADDER_DELAY;
  
end architecture behav;
