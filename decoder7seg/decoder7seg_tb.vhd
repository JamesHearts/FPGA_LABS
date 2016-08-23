library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity decoder7seg_tb is
end decoder7seg_tb;

architecture TB of decoder7seg_tb is

  component decoder7seg
    port(
      
	  input : in std_logic_vector(3 downto 0);
      output : out std_logic_vector(6 downto 0)
	  );
	  
  end component;
  
   signal input : std_logic_vector(3 downto 0);
   signal output : std_logic_vector(6 downto 0);
   
 begin 
 
	 U_DEC1 : entity work.decoder7seg(dec1)
    port map (
      input   => input,
      output  => output
	  );
	  
process
begin

		input <= "0000";
		wait for 10 ns;
		input <= "0001";
		wait for 10 ns;
		input <= "0010";
		wait for 10 ns;
		input <= "0011";
		wait for 10 ns;
		input <= "0100";
		wait for 10 ns;
		input <= "0101";
		wait for 10 ns;
		input <= "0110";
		wait for 10 ns;
		input <= "0111";
		wait for 10 ns;
		input <= "1000";
		wait for 10 ns;
		input <= "1001";
		wait for 10 ns;
		input <= "1010";
		wait for 10 ns;
		input <= "1011";
		wait for 10 ns;
		input <= "1100";
		wait for 10 ns;
		input <= "1101";
		wait for 10 ns;
		input <= "1110";
		wait for 10 ns;
		input <= "1111";
		wait for 10 ns;
		wait;
		

end process;

end TB;
