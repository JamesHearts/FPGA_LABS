library ieee;
use ieee.std_logic_1164.all;

entity cgen2 is
	port(

		BP : out std_logic;
		BG : out std_logic;
		Ci1 : out std_logic;
		Ci2 : out std_logic;
		
		cin : in std_logic;
		G0 : in std_logic;
		P0 : in std_logic;
		
		G1 : in std_logic;
		P1 : in std_logic

		
	);
end cgen2;

architecture BHV of cgen2 is
	begin
	
	process(cin, P0, G0, P1, G1)
	begin
	
	Ci1 <= G0 or (P0 and cin);
	Ci2 <= G1 or (P1 and G0) or (P1 and G0 and cin);
	
	BP <= P0 and P1;
	
	BG <= G1 or (G0 and P1); 
	end process;
	
end BHV;