library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.vga_lib.all;

entity vga_sync_gen is
port
(
	clk     : in std_logic;
	rst     : in std_logic;
	Hcount  : out std_logic_vector(9 downto 0);
	Vcount  : out std_logic_vector(9 downto 0);
	Hsync   : out std_logic;
	Vsync   : out std_logic;
	VideoOn : out std_logic
);
end vga_sync_gen;

architecture BHV of vga_sync_gen is

	signal HcountTemp : unsigned(9 downto 0); --We create all these variables so we can update the count without finishing the process.
	signal VcountTemp : unsigned(9 downto 0);

begin 
	
	
	Hcount <= std_logic_vector(HcountTemp); --We set the default values of Hcount and Vcount to be supplied by their temporary counterparts.
	Vcount <= std_logic_vector(VcountTemp);
	
	process(clk, rst)

	begin
	
		if(rst = '1') then
			HcountTemp <= (others => '0');
			VcountTemp <= (others => '0');
			
		elsif(rising_edge(clk)) then
			if(HcountTemp = H_MAX) then --We want to keep counting Hcount as long as it does not equal the max value.
				HcountTemp <= (others => '0');
			else
				HcountTemp <= HcountTemp + 1;
			end if;
			
			if(VcountTemp = V_MAX) then --We want to keep counting Vcount as long as it does not equal the max value.
				VcountTemp <= (others => '0');
			elsif(HcountTemp = H_VERT_INC) then --However we only increment Vcount if Hcount = H_VERT_INC.
				VcountTemp <= VcountTemp + 1;
			end if;
		
		end if;
			
	end process;
	
	process(HcountTemp, VcountTemp) --These are the control values for the mux. These keep the mux drawing RGB values from the rom as long as they are enabled.
	begin
		if((HcountTemp >= 0 and HcountTemp <= H_DISPLAY_END) and (VcountTemp >= 0 and VcountTemp <= V_DISPLAY_END)) then
			VideoOn <= '1'; 
		else
			VideoOn <= '0';
		end if;
		
		if(HcountTemp >= HSYNC_BEGIN and HcountTemp <= HSYNC_END) then --Note that Hsync and Vsync are active-low.
			Hsync <= '0'; 
		else
			Hsync <= '1';
		end if;
		
		if(VcountTemp >= VSYNC_BEGIN and VcountTemp <= VSYNC_END) then
			Vsync <= '0'; 
		else
			Vsync <= '1';
		end if;	
	
	end process;
			

end BHV;