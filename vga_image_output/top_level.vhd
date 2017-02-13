library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity top_level is 
port
(
	clk                : in std_logic;
	rst 			   : in std_logic;
	buttons_n          : in std_logic_vector(9 downto 0);
	red,green,blue     : out std_logic_vector(3 downto 0);
	v_sync,h_sync	   : out std_logic
);
end top_level;

architecture BHV of top_level is

signal Hcount, Vcount : std_logic_vector(9 downto 0);
signal raw_rgb : std_logic_vector(11 downto 0);
signal rom_address : std_logic_vector(13 downto 0);
signal pixel_clk : std_logic;
signal video_en, address_en : std_logic;


begin
	
	U_PIXEL : entity work.clk_div
		generic map(
			clk_in_freq 	=> 50000,
			clk_out_freq 	=> 25000
		)
		port map(
			clk_in 	=> clk, 
			rst 		=> rst,
			clk_out 	=> pixel_clk
		);
	
	U_VGA_SYNC_GEN: entity work.vga_sync_gen
	port map
	(
		clk => pixel_clk,
		rst => rst,
		Hcount => Hcount,
		Vcount => Vcount,
		Hsync => h_sync,
		Vsync => v_sync,
		VideoOn => video_en
	);
	
	U_ADDR_LOGIC: entity work.row_col_dec_128
	port map
	(
		
		rowAddr => rom_address(13 downto 7),
		colAddr => rom_address(6 downto 0),
		buttons => buttons_n(4 downto 0),
		Hcount => Hcount,
		Vcount => Vcount,
		AddrEn => address_en
		
	);
	
	U_ROM: entity work.rom_128
	port map
	(
		data => (others => '0'),
		wren => '0',
		address => rom_address(13 downto 0),
		clock => pixel_clk,
		q => raw_rgb(11 downto 0)
	);
	
	process(pixel_clk,raw_rgb, address_en, video_en)
	begin
		if(address_en = '1' and video_en = '1') then
			red <= raw_rgb(11 downto 8);
			green <= raw_rgb(7 downto 4);
			blue <= raw_rgb(3 downto 0);
		else
			red <= x"0";
			green <= x"0";
			blue <= x"0";
		end if;
	end process;
end BHV;