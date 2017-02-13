library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_gen is
    generic (
        ms_period : positive := 1000);  -- amount of ms for button to be pressed before creating clock pulse
    port (
        clk50MHz : in  std_logic;
        rst      : in  std_logic;
        button_n : in  std_logic;
        clk_out  : out std_logic);
end clk_gen;

architecture BHV of clk_gen is

	signal clk_1kHz : std_logic; -- we will use this signal as an output of clk_div
	
	-- using the math_real package we can initialize a constant that will be the required amount of bits to divide the clock signal correctly.
	constant button_count_total : natural := integer(ceil(log2(real(ms_period+1))));

begin
	CLK_DIV : entity work.clk_div	
	
	 generic map(clk_in_freq => 50000000, clk_out_freq => 1000)
    
	-- We map our signals to the entities inputs and outputs using a signal clk_1kHz has a temporary variable.
	
	 port map(
        clk_in  => clk50MHz,
        clk_out => clk_1kHz, -- the output of clk_div is fed into clk_1kHz
        rst => rst
		  );

	process(rst, clk_1kHz)
	
	variable button_count : unsigned((button_count_total - 1) downto 0); -- this variable will count the time that the button is being pressed down.

	begin 
	
	if(rst = '1') then -- if reset is high then we set the output to 0 and reset button_count to 0
		clk_out <= '0';
		button_count := (others => '0');
	
	elsif(rising_edge(clk_1kHz)) then -- on the rising edge of clk_1kHz we check the different states of the button.
	
		if(button_n = '1') then -- THE BUTTON ON THE FPGA IS ACTIVE LOW. When not pressed the button is a 1. We reset button_count to 0 and clk_out to 0.
		
			button_count := (others => '0');
			clk_out <= '0';
	
		elsif(button_n = '0') then -- When the button is being pressed we start a count.
			
			if (button_count = ms_period)then -- When the count is equal to the ms_period we output a high clk_out and reset button_count
			
				button_count := (others => '0'); 
				clk_out <= '1';
			else							-- When it isn't we output a 0.
				clk_out <= '0'; 
						
			end if;
				button_count := button_count + "1";	-- Making sure to increment count.
		
		end if;
	
	end if;	
		
	
	end process;


end BHV;