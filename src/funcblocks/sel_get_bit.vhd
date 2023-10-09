library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.defs.all;

entity sel_get_bit is
  generic (
    DATA_WIDTH : natural := DATA_WIDTH;
    BIT_INDEX  : natural := 0
  );

  port (
    in_req  : in  std_logic;
    in_ack  : out std_logic;
    in_data : in  std_logic_vector(DATA_WIDTH-1 downto 0);

    out_req  : out std_logic;
    out_ack  : in  std_logic;
    selector : out std_logic
  );
end sel_get_bit;

architecture behav of sel_get_bit is 
begin
  
  -- size of 2 is more of a guess

  dly_req : entity work.delay_element
    generic map(
      size => 2
    )
    port map(
      d => in_req,
      z => out_req
    );
  in_ack <= out_ack;

  selector <= in_data(BIT_INDEX);

end architecture behav;
