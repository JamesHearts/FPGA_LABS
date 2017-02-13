library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity vga_sync_gen_tb is
end vga_sync_gen_tb;

architecture TB of vga_sync_gen_tb is

  -- MODIFY TO MATCH YOUR TOP LEVEL
  component vga_sync_gen
    port (  clk     : in std_logic;
			rst     : in std_logic;
			Hcount  : out std_logic_vector(9 downto 0);
			Vcount  : out std_logic_vector(9 downto 0);
			Hsync   : out std_logic;
			Vsync   : out std_logic;
			VideoOn : out std_logic
			);
  end component;

	signal  clk     : std_logic := '0';
	signal	rst     : std_logic := '1';
	signal	Hcount  : std_logic_vector(9 downto 0);
	signal	Vcount  : std_logic_vector(9 downto 0);	
	signal	Hsync   : std_logic;
	signal  Vsync   : std_logic;
	signal  VideoOn : std_logic;

begin  -- TB

  -- MODIFY TO MATCH YOUR TOP LEVEL
  UUT : vga_sync_gen port map (
    clk => clk,
	rst => rst,    
	Hcount => Hcount,
	Vcount => Vcount,
	Hsync  => Hsync, 
	Vsync  => Vsync,
	VideoOn => VideoOn
	);


  clk <= not clk after 10 ns;
  
  process
  begin
	 rst <= '0';
	 
    wait for 100 us;

 
	
  end process;

end TB;