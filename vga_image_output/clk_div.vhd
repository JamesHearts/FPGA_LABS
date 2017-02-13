library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_div is
    generic(clk_in_freq  : natural := 50000;
            clk_out_freq : natural := 25000); -- the ratio of frequencies is 2:1
    port (
        clk_in  : in  std_logic;
        clk_out : out std_logic;
        rst     : in  std_logic
		);
end clk_div;

architecture BHV of clk_div is

	constant ratio_freq : natural  := clk_in_freq / clk_out_freq; -- We use this formula to calculate any ratio given.
	
	--this is the count total, it has a width calculated by the formula below using the ratio.
	--we use this signal to see what the count is after every interation. 
	signal count_total: unsigned(integer(ceil(log2(real(ratio_freq))))-1 downto 0);

begin

	process(rst, clk_in)
	
	--this count has the same width calculated above. We will use this to keep the actual count after every clock edge.
	variable count : unsigned(integer(ceil(log2(real(ratio_freq))))-1 downto 0) := (others => '0');
	
	begin
	
	if(rst = '1') then	-- if reset is 1 we reset count and output 0 from the clk.
		count := (others => '0');
		clk_out <= '0';
	
	elsif(rising_edge(clk_in)) then	-- on rising edge we test to see where count is and take into account our duty cycle.
		
		if count = 0 then 
				clk_out <= '1'; -- we make the clock high default.
			
			elsif count = ratio_freq / 2 then --clk_out is high until 50% duty cycle then toggles to low.
				clk_out <= '0';
			
			-- we might not need to do this if we make the clk_out a default 0.
			elsif count = ratio_freq - 1 then --we need to make the last iteration make count all 1s so that the next count will make it reset to 0.
				count := (others => '1');
		
		end if;
		
		count := count+1; --we increment count after every cycle.
		count_total <= count; --we update the count_total after every increment.
	
	end if;
		
	end process;


end BHV;