library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.vga_lib.all;

entity row_col_dec_128 is
	port(
		Vcount 		: in std_logic_vector(9 downto 0);
		Hcount 		: in std_logic_vector(9 downto 0);	
		buttons 	: in std_logic_vector(4 downto 0);
		
		AddrEn  	: out std_logic;
		rowAddr 	: out std_logic_vector(ROW_ADDR_WIDTH-1 downto 0);
		colAddr 	: out std_logic_vector(COL_ADDR_WIDTH-1 downto 0)
		
	);
end row_col_dec_128;

architecture BHV of row_col_dec_128 is
begin

	process(buttons, Hcount, Vcount)
	
		variable rowTemp : unsigned(9 downto 0);
		variable colTemp : unsigned(9 downto 0);
		
	begin
	
	AddrEn <= '0';
	rowAddr <= (others => '0');
	colAddr <= (others => '0');
	
		if(buttons(0) = '1') then --When this button is asserted the center will display the image.
			if(unsigned(Hcount) >= CENTERED_X_START and unsigned(Hcount) <= CENTERED_X_END) then 
				if(unsigned(Vcount) >= CENTERED_Y_START and unsigned(Vcount) <= CENTERED_Y_END) then
					AddrEn <= '1';
				
					colTemp := (unsigned(Vcount) - CENTERED_Y_START);
					rowAddr <= std_logic_vector(colTemp(ROW_ADDR_WIDTH-1 downto 0));
				
					rowTemp := (unsigned(Hcount) - CENTERED_X_START);
					colAddr <= std_logic_vector(rowTemp(COL_ADDR_WIDTH-1 downto 0));
				
				else
					AddrEn <= '0';
				end if;
			else
				AddrEn <= '0';
			end if;
		
		
	
		elsif(buttons(1) = '1') then --When this button is asserted the top left will display the image.
			if(unsigned(Hcount) >= TOP_LEFT_X_START and unsigned(Hcount) <= TOP_LEFT_X_END) then 
				if(unsigned(VCount) >= TOP_LEFT_Y_START and unsigned(VCount) <= TOP_LEFT_Y_END) then
					AddrEn <= '1';
				
					colTemp := (unsigned(Vcount) - TOP_LEFT_Y_START);
					rowAddr <= std_logic_vector(colTemp(ROW_ADDR_WIDTH-1 downto 0));
				
					rowTemp := (unsigned(Hcount) - TOP_LEFT_X_START);
					colAddr <= std_logic_vector(rowTemp(COL_ADDR_WIDTH-1 downto 0));
				
				else
					AddrEn <= '0';
				end if;
			
			else
				AddrEn <= '0';
			end if;
		
		
		
		elsif(buttons(2) = '1') then --When this button is asserted top right will display the image.
			if(unsigned(Hcount) >= TOP_RIGHT_X_START and unsigned(Hcount) <= TOP_RIGHT_X_END) then 
				if(unsigned(Vcount) >= TOP_RIGHT_Y_START and unsigned(Vcount) <= TOP_RIGHT_Y_END) then
					AddrEn <= '1';
				
					colTemp := (unsigned(Vcount) - TOP_RIGHT_Y_START);
					rowAddr <= std_logic_vector(colTemp(ROW_ADDR_WIDTH-1 downto 0));
				
					rowTemp := (unsigned(Hcount) - TOP_RIGHT_X_START);
					colAddr <= std_logic_vector(rowTemp(COL_ADDR_WIDTH-1 downto 0));
				
				else
					AddrEn <= '0';
				end if;
			else
				AddrEn <= '0';
			end if;
		
		
		
		elsif(buttons(3) = '1') then --When this button is asserted the bottom left will display the image.
			if(unsigned(Hcount) >= BOTTOM_LEFT_X_START and unsigned(Hcount) <= BOTTOM_LEFT_X_END) then 
				if(unsigned(Vcount) >= BOTTOM_LEFT_Y_START and unsigned(Vcount) <= BOTTOM_LEFT_Y_END) then
					AddrEn <= '1';
				
					colTemp := (unsigned(Vcount) - BOTTOM_LEFT_Y_START);
					rowAddr <= std_logic_vector(colTemp(ROW_ADDR_WIDTH-1 downto 0));
				
					rowTemp := (unsigned(Hcount) - BOTTOM_LEFT_X_START);
					colAddr <= std_logic_vector(rowTemp(COL_ADDR_WIDTH-1 downto 0));
				
				else
					AddrEn <= '0';
				end if;
			else
				AddrEn <= '0';
			end if;
		
		
		
		elsif(buttons(4) = '1') then -- When this button is asserted the bottom right will display image.
			if(unsigned(Hcount) >= BOTTOM_RIGHT_X_START and unsigned(Hcount) <= BOTTOM_RIGHT_X_END) then 
				if(unsigned(Vcount) >= BOTTOM_RIGHT_Y_START and unsigned(Vcount) <= BoTTOM_RIGHT_Y_END) then
					AddrEn <= '1';
				
					colTemp := (unsigned(Vcount) - BOTTOM_RIGHT_Y_START);
					rowAddr <= std_logic_vector(colTemp(ROW_ADDR_WIDTH-1 downto 0));
				
					rowTemp := (unsigned(Hcount) - BOTTOM_RIGHT_X_START);
					colAddr <= std_logic_vector(rowTemp(COL_ADDR_WIDTH-1 downto 0));
				
				else
					AddrEn <= '0';
				end if;
			else
				AddrEn <= '0';
			end if;
		
		end if;
	
		
	
	end process;
	


end BHV;