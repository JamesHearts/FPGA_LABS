library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity row_col_dec_tb is
end row_col_dec_tb;

architecture TB of row_col_dec_tb is

  -- MODIFY TO MATCH YOUR TOP LEVEL
  component row_col_dec
    port ( 
			
			Vcount 		: in std_logic_vector(9 downto 0);
			Hcount 		: in std_logic_vector(9 downto 0);	
			buttons 	: in std_logic_vector(4 downto 0);
		
			AddrEn  	: out std_logic;
			rowAddr 	: out std_logic_vector(ROW_ADDR_WIDTH-1 downto 0);
			colAddr 	: out std_logic_vector(COL_ADDR_WIDTH-1 downto 0)
			);
  end component;

	signal	Vcount 		: std_logic_vector(9 downto 0);
	signal	Hcount 		: std_logic_vector(9 downto 0);	
	signal	buttons 	: std_logic_vector(4 downto 0);
		
	signal	AddrEn  	: std_logic;
	signal	rowAddr 	: std_logic_vector(ROW_ADDR_WIDTH-1 downto 0);
	signal	colAddr 	: std_logic_vector(COL_ADDR_WIDTH-1 downto 0);

begin  -- TB

  -- MODIFY TO MATCH YOUR TOP LEVEL
  UUT : row_col_dec port map (
		Vcount => Vcount,
		Hcount => Hcount,		
		buttons => buttons,
		
		AddrEn  =>	AddrEn,
		rowAddr =>	rowAddr,
		colAddr =>	colAddr
	);
	
  process
  begin
	 
    buttons <= "00001";
    wait for 100 us;

    buttons <= "00010";
    wait for 100 us;
	 
    buttons <= "00100";
	 wait for 100 us; 
	 
	 buttons <= "01000";
	 wait for 5 ms;
	 
	 buttons <= "10000";
	 wait for 5 ms;
	 
	 report "done";
	
  end process;
	 

 
	
  

end TB;