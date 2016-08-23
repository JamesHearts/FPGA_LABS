library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtractor is
  generic (
    width  :     positive := 16);
  port (
    
    in1  : in std_logic_vector(width-1 downto 0);
    in2  : in  std_logic_vector(width-1 downto 0);
	output : out std_logic_vector(width-1 downto 0)
	);
 
end subtractor;

architecture BHV of subtractor is

begin 

	process(in1, in2)
    begin
    output <= std_logic_vector(unsigned(in1)-unsigned(in2)); -- Subtract in1 - in2.
    end process;

end BHV;