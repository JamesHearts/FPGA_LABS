library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl2 is
  generic (
    width  :     positive := 16);
	
   port(clk    : in std_logic;
		rst    : in std_logic;
		x_lt_y : in std_logic;
		x_ne_y : in std_logic;
		go     : in std_logic;
		done   : out std_logic;
		selX   : out std_logic;
		selY   : out std_logic;
		selIN  : out std_logic;
		loadX   : out std_logic;
		loadY   : out std_logic;
		loadOut : out std_logic
		);
		
       
 
end ctrl2;

architecture BHV of ctrl2 is

	type STATE_FSM is (STATE_0, STATE_1, STATE_2, STATE_3);
     signal state, next_state : STATE_FSM;
	 
begin

	process(rst, clk)
	
	begin

		if(rst = '1') then
			state <= STATE_0;
		elsif(rising_edge(clk)) then
			state <= next_state;
		end if;
	
	end process;
	
	process(x_lt_y, x_ne_y, go, state)
	
	begin
	
		loadX <= '0';
		loadY <= '0';
		loadOut <= '0';
		
		selX <= '1';
		selY <= '1';
		selIN <= '1'; -- we set selIn as a default value.
	
		done <= '0';
		next_state <= state;
	
	case state is 
	
	when STATE_0 =>
	
		if(go = '0') then
			next_state <= STATE_0;
		else
			next_state <= STATE_1;
		end if;
	
	when STATE_1 =>
	
		next_state <= STATE_2;
		selX <= '0';
		selY <= '0';
		loadX <= '1';
		loadY <= '1';
		
	when STATE_2 =>
	
		if(x_ne_y ='1') then
			if(x_lt_y = '1') then
				selIN <= '0'; -- if x_lt_y we want to select 0 for y = y - x
				selY <= '1';
				loadY <= '1';
			else
				selIN <= '1';
				selX <='1'; -- if x_lt_y is not true then we select 1 for x = x - y
				loadX <= '1';
			end if;
		
		next_state <= STATE_2;
		
		else
		
		loadOut <= '1';
		next_state <= STATE_3;
		
		end if;
		
	when STATE_3 =>
	
		done <= '1';
	
		if(go = '0') then
			next_state <= STATE_0;
		end if;
		
		
		
	when others =>
		null;
		
	end case;
	
	
		
	
end process;

end BHV;
				
				
		
	
	