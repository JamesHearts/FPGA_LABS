library ieee;
use ieee.std_logic_1164.all;

-- DO NOT CHANGE ANYTHING IN THE ENTITY

entity fa is
  port (
    input1    : in  std_logic;
    input2    : in  std_logic;
    carry_in  : in  std_logic;
    sum       : out std_logic;
    carry_out : out std_logic);
end fa;

-- DEFINE THE FULL ADDER HERE

architecture BHV of fa is
begin 
  
  sum <= carry_in xor (input1 xor input2);
  carry_out <= (input1 and input2) or (carry_in and (input1 xor input2));
  
end BHV;