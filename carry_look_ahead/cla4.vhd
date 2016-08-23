library ieee;
use ieee.std_logic_1164.all;

entity cla4 is
	port(
	
		BP : out std_logic;
		BG : out std_logic;
	
		input1 : in std_logic_vector(3 downto 0);
		input2 : in std_logic_vector(3 downto 0);
		cin : in std_logic;
		
		cout : out std_logic;
		sum : out std_logic_vector(3 downto 0)
	);
end cla4;

architecture STRUCTURE of cla4 is

	signal P1, G1, P0, G0, C1 : std_logic;
begin

	CLA2_1 : entity work.cla2
	
	port map(
		input1 => input1(1 downto 0),
		input2 => input2(1 downto 0),
		cin => cin,
		cout => open,
		sum => sum(1 downto 0),
		
		BP => P0,
		BG => G0
		
	);
	
	CLA2_2 : entity work.cla2
	
	port map(
		input1 => input1(3 downto 2),
		input2 => input2(3 downto 2),
		cin => C1,
		cout => open,
		sum => sum(3 downto 2),
		
		BP => P1,
		BG => G1
	);
	
	CGEN2 : entity work.cgen2
	port map(
		cin => cin, 
		
		P0 => P0,
		G0 => G0,
		
		P1 => P1,
		G1 => G1,
		
		Ci1 => C1,
		Ci2 => cout,
		
		BP => BP,
		BG => BG
	
	);
	
end STRUCTURE;
