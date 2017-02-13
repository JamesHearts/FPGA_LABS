library ieee;
use ieee.std_logic_1164.all;

entity gray2 is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        output : out std_logic_vector(3 downto 0));
end gray2;

architecture GRAY_2 of gray2 is

	type count is (count_0, count_1, count_2, count_3, 
					count_4, count_5, count_6, count_7, 
					count_8, count_9, count_A, count_B,
					count_C, count_D, count_E, count_F);
					
	signal state, next_state : count;
	
begin
	
process(clk, rst)
begin
		if (rst = '1') then1
     
		state <= count_0;                
		elsif(rising_edge(clk)) then
		state <= next_state;
		end if;
		
end process;

process(state)

	begin
	
		next_state <= state;   
		
		case state is
		
          when count_0 =>
		
          output  <= "0000";
          next_state <= count_1;
          
         
		  when count_1 =>
		
          output  <= "0001";
		  next_state <= count_3;
         
		  
		  when count_3 =>
		
          output  <= "0011";
          next_state <= count_2;
         
		  
		  when count_2 =>
		
          output  <= "0010";
          next_state <= count_6;

		  
		  when count_6 =>
		
          output  <= "0110";
          next_state <= count_7;

		  
		  when count_7 =>
		
          output  <= "0111";
          next_state <= count_5;

		  
		  when count_5 =>
		
          output  <= "0101";
          next_state <= count_4;

		  
		  when count_4 =>
		
          output  <= "0100";
          next_state <= count_C;

		  
		  when count_C =>
		
          output  <= "1100";
		  next_state <= count_D;

		  
		  when count_D =>
		
          output  <= "1101";
          next_state <= count_F;

		  
		  when count_F =>
		
          output  <= "1111";
          next_state <= count_E;

		  
		  when count_E =>
		
          output  <= "1110";
          next_state <= count_A;

		  
		  when count_A =>
		
          output  <= "1010";
          next_state <= count_B;

		  
		  when count_9 =>
		
          output  <= "1001";
          next_state <= count_8;

		  
		  when count_8 =>
		
          output  <= "1000";
          next_state <= count_0;

      
		  when others => null;
      end case;
	  
end process;
