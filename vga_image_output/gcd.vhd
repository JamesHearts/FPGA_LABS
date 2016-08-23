library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gcd is
    generic (
        WIDTH : positive := 16);
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        go     : in  std_logic;
        done   : out std_logic;
        x      : in  std_logic_vector(WIDTH-1 downto 0);
        y      : in  std_logic_vector(WIDTH-1 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0));
end gcd;

architecture FSMD of gcd is


	type STATE_FSM is (STATE_0, STATE_1, STATE_2, STATE_3 );
					
	signal state : STATE_FSM;
	
	signal tmpX : std_logic_vector(WIDTH-1 downto 0);
	signal tmpY : std_logic_vector(WIDTH-1 downto 0);
	
begin -- FSMD
	
	process(clk, rst)
		
		
	
	begin
	
		if(rst = '1') then 
			output <= (others => '0');
			state <= STATE_0;
			
		elsif(rising_edge(clk)) then
		
		
		case state is
		
			when STATE_0 =>
				
				if(go = '0') then
					output <= (others => '0');
					done <= '1';
					state <= STATE_0;
				else 
					output <= (others => '0');
					done <= '0';
					state <= STATE_1;
				end if;
          
			when STATE_1 =>
					
					tmpX <= x;
					tmpY <= y;
					output <= (others =>'0');
					done <= '0';
					state <= STATE_2;
					
			when STATE_2 =>
					
					if(tmpX /= tmpY) then
						
						state <= STATE_2;
						done <= '0';
						output <= (others => '0');
						
						if(tmpX < tmpY) then
							tmpY <= std_logic_vector(unsigned(tmpY) - unsigned(tmpX));
							
						else
							tmpX <= std_logic_vector(unsigned(tmpX) - unsigned(tmpY));
						end if;
						
					else
						done <= '0';
						output <= (others => '0');
						state <= STATE_3;
					end if;
						
						
			when STATE_3 =>
			
						state <= STATE_0;
						done <= '1';
						output <= tmpX;
			
      
		  when others => null;
      end case;
	  
	  end if;
	  
end process;


end FSMD;

architecture FSM_D1 of gcd is

      signal selX, selY      	   : std_logic;
      signal loadX, loadY, loadOut : std_logic; 
      signal x_lt_y, x_ne_y        : std_logic;
	  
begin  -- FSM_D1

U_DATA : entity work.datapath1
	generic map(
		width => width
	)

	port map(
		clk => clk,
		rst => rst,
		inX => x,
		inY => y,
		output => output,
	
		selX => selX,
		selY => selY,
		
		loadX => loadX,
		loadY => loadY,
		loadOut => loadOut,
	
		x_lt_y => x_lt_y,
		x_ne_y => x_ne_y
);

U_CTRL : entity work.ctrl1

	port map(
		clk => clk,
		rst => rst,
		go => go,
		done => done,
	
		selX => selX,
		selY => selY,
		
		loadX => loadX,
		loadY => loadY,
		loadOut => loadOut,
	
		x_lt_y => x_lt_y,
		x_ne_y => x_ne_y
);



end FSM_D1;

architecture FSM_D2 of gcd is

	  signal selX, selY , selIN    : std_logic;
      signal loadX, loadY, loadOut : std_logic; 
      signal x_lt_y, x_ne_y        : std_logic;

begin  -- FSM_D2

U_DATA : entity work.datapath2
	generic map(
		width => width
	)

	port map(
		clk => clk,
		rst => rst,
		inX => x,
		inY => y,
		output => output,
	
		selX => selX,
		selY => selY,
		selIN => selIN,
		
		loadX => loadX,
		loadY => loadY,
		loadOut => loadOut,
	
		x_lt_y => x_lt_y,
		x_ne_y => x_ne_y
);

U_CTRL : entity work.ctrl2

	port map(
		clk => clk,
		rst => rst,
		go => go,
		done => done,
	
		selX => selX,
		selY => selY,
		selIN => selIN,
		
		loadX => loadX,
		loadY => loadY,
		loadOut => loadOut,
	
		x_lt_y => x_lt_y,
		x_ne_y => x_ne_y
);

end FSM_D2;


-- EXTRA CREDIT
architecture FSMD2 of gcd is

begin  -- FSMD2



end FSMD2;