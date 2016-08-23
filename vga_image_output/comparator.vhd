library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
  generic (
    width  :     positive := 16);
  port (
    
    y  : in std_logic_vector(width-1 downto 0);
    x  : in  std_logic_vector(width-1 downto 0);
	x_ne_y : out std_logic;
	x_lt_y : out std_logic
	);
 
end comparator;

architecture BHV of comparator is

begin
	-- instead of using an if statement we can use this when else statement.
	  x_lt_y <= '1' when unsigned(x) < unsigned(y) else '0';
      x_ne_y <= '1' when unsigned(x) /= unsigned(y) else '0';


end BHV;