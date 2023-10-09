library ieee;
use ieee.std_logic_1164.all;

entity LUT1 is
  generic (INIT : bit_vector := "10");
  port (I0 : in std_ulogic; O : out std_ulogic);
end entity LUT1;

architecture rtl of LUT1 is
  signal o_intermediate : std_ulogic;
  constant init_slv : std_logic_vector := to_stdlogicvector(INIT);
begin
  output : process(I0)
  begin
    case I0 is
      when '0' => O_intermediate <= init_slv(0);
      when '1' => O_intermediate <= init_slv(1);
      when others => O_intermediate <= 'X';
    end case;
  end process;

  -- TODO do we need an after-delay here? maybe even a device specific?
  --O <= o_intermediate after 5 ps;
  O <= o_intermediate;
end architecture rtl;
