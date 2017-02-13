library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1 is

generic (
    WIDTH  :     positive := 16);
	
  port(
    rgbInput   : in  std_logic_vector(WIDTH-1 downto 0);
    zeroInput  : in  std_logic_vector(WIDTH-1 downto 0);
    sel        : in  std_logic;
    output     : out std_logic_vector(WIDTH-1 downto 0)
	);
end mux_2x1;



architecture MUX_2x1 of mux_2x1 is
begin

  process(rgbInput, zeroInput, sel)
  begin
  
    case sel is
      when '0'    => --when select is 0 we take rgbInput.
        output <= rgbInput;
      when others =>
        output <= zeroInput;
    end case;
	
  end process;
end MUX_2x1;