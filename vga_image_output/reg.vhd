library ieee;
use ieee.std_logic_1164.all;

entity reg is
  generic (
    width  :     positive := 16);
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    load   : in  std_logic;
    input  : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0));
end reg;

architecture BHV of reg is
begin

  process(clk, rst)
  begin
   
    if (rst = '1') then
      output   <= (others => '0');
    elsif (rising_edge(clk)) then
 
      if (load = '1') then -- if load is true then we take an input in. load is the enable.
        output <= input;
      end if;
   
   end if;
  end process;
end BHV;