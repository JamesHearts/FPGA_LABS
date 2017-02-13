library ieee;
use ieee.std_logic_1164.all;

entity gray1 is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        output : out std_logic_vector(3 downto 0));
end gray1;

architecture GRAY_1 of gray1 is 

	--0000 (0) 1100 (C)
	--0001 (1) 1101 (D)
	--0011 (3) 1111 (F)
	--0010 (2) 1110 (E)
	--0110 (6) 1010 (A)
	--0111 (7) 1011 (B)
	--0101 (5) 1001 (9)
	--0100 (4) 1000 (8)


	type count is (count_0, count_1, count_2, count_3, 
					count_4, count_5, count_6, count_7, 
					count_8, count_9, count_A, count_B,
					count_C, count_D, count_E, count_F);
					
	signal state : count;
	
	process(clk, rst)
	
	begin
	
		if(rst = '1') then 
			output <= "0000";
			state <= count_0;
			
		elsif(rising_edge(clk)) then
		
		case state is
		
          when count_0 =>
		
          output  <= "0000";
          state <= count_1;
          
         
		  when count_1 =>
		
          output  <= "0001";
		  state <= count_3;
         
		  
		  when count_3 =>
		
          output  <= "0011";
          state <= count_2;
         
		  
		  when count_2 =>
		
          output  <= "0010";
          state <= count_6;

		  
		  when count_6 =>
		
          output  <= "0110";
          state <= count_7;

		  
		  when count_7 =>
		
          output  <= "0111";
          state <= count_5;

		  
		  when count_5 =>
		
          output  <= "0101";
          state <= count_4;

		  
		  when count_4 =>
		
          output  <= "0100";
          state <= count_C;

		  
		  when count_C =>
		
          output  <= "1100";
		  state <= count_D;

		  
		  when count_D =>
		
          output  <= "1101";
          state <= count_F;

		  
		  when count_F =>
		
          output  <= "1111";
          state <= count_E;

		  
		  when count_E =>
		
          output  <= "1110";
          state <= count_A;

		  
		  when count_A =>
		
          output  <= "1010";
          state <= count_B;

		  
		  when count_9 =>
		
          output  <= "1001";
          state <= count_8;

		  
		  when count_8 =>
		
          output  <= "1000";
          state <= count_0;

      
		  when others => null;
      end case;
	  
	  end if;
	  
end process;

end fsm;
		