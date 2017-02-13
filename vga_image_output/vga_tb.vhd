library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.VGA_LIB.all;

entity vga_tb is
end vga_tb;

architecture TB of vga_tb is

  -- MODIFY TO MATCH YOUR TOP LEVEL
  component top_level
    port ( 
	       rst				: in std_logic;
		   clk              : in  std_logic;
           buttons_n        : in  std_logic_vector(9 downto 0);
           red, green, blue : out std_logic_vector(3 downto 0);
           h_sync, v_sync   : out std_logic);
  end component;

  signal clk              : std_logic := '0';
  signal rst              : std_logic := '1';
  signal buttons_n        : std_logic_vector(9 downto 0);
  signal red, green, blue : std_logic_vector(3 downto 0);
  signal h_sync, v_sync   : std_logic;

begin  -- TB

  -- MODIFY TO MATCH YOUR TOP LEVEL
  UUT : top_level port map (
    clk       => clk,
    buttons_n => buttons_n,
    red       => red,
    green     => green,
    blue      => blue,
    h_sync    => h_sync,
    v_sync    => v_sync,
	rst => rst
	);
  
	clk <= not clk after 10 ns;
  
  process
  begin
	rst <= '0';
	 

    buttons_n <= "0000000010";
    wait for 5 ms;
	 
    buttons_n <= "0000000100";
	 wait for 5 ms; 
	 
	 buttons_n <= "0000001000";
	 wait for 5 ms;
	 
	 buttons_n <= "0000010000";
	 wait for 5 ms;
	 
	 report "done";
	
  end process;

end TB;