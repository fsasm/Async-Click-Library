library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.defs.all;

entity sel_a_not_0 is
  generic (
    DATA_WIDTH : natural := DATA_WIDTH
  );

  port (
    in_req  : in  std_logic;
    in_ack  : out std_logic;
    in_data : in  std_logic_vector(DATA_WIDTH-1 downto 0);

    out_req  : out std_logic;
    out_ack  : in  std_logic;
    selector : out std_logic
  );
end sel_a_not_0;

architecture behav of sel_a_not_0 is 
  attribute dont_touch : string;
begin
  
  dly_req : entity work.delay_element
    generic map(
      size => ADD_DELAY+1
    )
    port map(
      d => in_req,
      z => out_req
    );
  in_ack <= out_ack;

  -- FIXME what should be '0' and what '1'?
  selector <= '0' when unsigned(in_data) /= 0
    else '1';

end architecture behav;
