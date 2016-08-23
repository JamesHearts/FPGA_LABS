library ieee;
use ieee.std_logic_1164.all;

entity cla2 is
	generic(
		width : positive := 4
	);
	port(
	
		BP : out std_logic;
		BG : out std_logic;
	
		input1 : in std_logic_vector(1 downto 0);
		input2 : in std_logic_vector(1 downto 0);
		cin : in std_logic;
		
		cout : out std_logic;
		sum : out std_logic_vector(1 downto 0)
		
		
		
	);
end cla2;

architecture BHV of cla2 is
begin

	process(input1, input2, cin)
		
	variable P : std_logic_vector(1 downto 0);
	variable G : std_logic_vector(1 downto 0);
	variable C1 : std_logic;
	variable C2 : std_logic;

	begin
	
		P := input1 or input2;
		G := input1 and input2;
		
		C1 := G(0) or (P(0) and cin);
		C2 := G(1) or (P(1) and G(0)) or (P(1) and P(0) and cin);
		cout <=  (C1 and P(1)) or G(1);
		--sum <= carry_in xor (input1 xor input2); from fa.vhd
		sum(0) <= input1(0) xor input2(0) xor cin;
		sum(1)  <= input1(1) xor input2(1) xor C1;
		
		BP <= P(1) and P(0);
		BG <= G(1) or (P(1) and G(0));
		
	end process;
	
end BHV;