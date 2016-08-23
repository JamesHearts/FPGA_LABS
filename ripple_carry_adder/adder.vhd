library ieee;
use ieee.std_logic_1164.all;

-- DO NOT CHANGE ANYTHING IN THE ENTITY

entity adder is
  port (
    input1    : in  std_logic_vector(3 downto 0);
    input2    : in  std_logic_vector(3 downto 0);
    carry_in  : in  std_logic;
    sum       : out std_logic_vector(3 downto 0);
    carry_out : out std_logic);
end adder;

-- DEFINE A RIPPLE-CARRY ADDER USING A STRUCTURE DESCRIPTION THAT CONSISTS OF 4
-- FULL ADDERS

architecture STR of adder is  

	signal co1, co2, co3 : std_logic;

begin  -- STR

	U_FA1 : entity work.fa port map (
	
		input1 => input1(0),
		input2 => input2(0),
		carry_in => carry_in,
		carry_out => co1,
		sum => sum(0)	
	);
	
	U_FA2 : entity work.fa port map (
		
		input1 => input1(1),
		input2 => input2(1),
		carry_in => co1,
		carry_out => co2,
		sum => sum(1)
	);
	
	U_FA3 : entity work.fa port map (
		
		input1 => input1(2),
		input2 => input2(2),
		carry_in => co2,
		carry_out => co3,
		sum => sum(2)
	);
	
	U_FA4 : entity work.fa port map (
		input1 => input1(3),
		input2 => input2(3),
		carry_in => co3,
		carry_out => carry_out,
		sum => sum(3)
	);


end STR;