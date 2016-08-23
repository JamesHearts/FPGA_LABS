library ieee;
use ieee.std_logic_1164.all;

entity datapath2 is
  generic (
    width  :     positive := 16);
  port (
    
	clk    : in std_logic;
	rst    : in std_logic;
    inX    : in std_logic_vector(width-1 downto 0);
    inY    : in std_logic_vector(width-1 downto 0);
	selX   : in std_logic;
	selY   : in std_logic;
	selIN  : in std_logic;
	loadX  : in std_logic;
	loadY  : in std_logic;
	loadOut: in std_logic;
	x_lt_y : out std_logic;
	x_ne_y : out std_logic;
	output : out std_logic_vector(width-1 downto 0)
	);
 
end datapath2;

architecture STRUCT of datapath2 is -- the biggest difference in this datapath2 is the addition of selIN.
	
  signal muxX, muxY : std_logic_vector(width-1 downto 0);
  signal regX, regY : std_logic_vector(width-1 downto 0);
  signal sub1 : std_logic_vector(width-1 downto 0);
  
  component reg
    generic (width    :     positive := 16);
    port(clk, rst, load : in  std_logic;
         input          : in  std_logic_vector(width-1 downto 0);
         output         : out std_logic_vector(width-1 downto 0));
  end component;
  
  component mux_2x1
    generic (width    :     positive := 16);
    port(sel    : in  std_logic;
         in1    : in  std_logic_vector(width-1 downto 0);
		 in2    : in std_logic_vector(width -1 downto 0);
         output : out std_logic_vector(width-1 downto 0));
  end component;
  
  component comparator
    generic (width    :     positive := 16);
    port(x       : in  std_logic_vector(width-1 downto 0);
         y       : in  std_logic_vector(width-1 downto 0);
         x_lt_y  : out std_logic;
		 x_ne_y  : out std_logic);
  end component;
		 
  component subtractor2 -- we must declare selIn in the port list.
    generic (width    :     positive := 16);
    port(selIN  : in std_logic;
		 in1    : in  std_logic_vector(width-1 downto 0);
         in2    : in  std_logic_vector(width-1 downto 0);
         output : out std_logic_vector(width-1 downto 0));
  end component;
  
begin

	U_MUX_X : entity work.mux_2x1
	generic map(
		width => width)
		
	port map(
		in1 => inX,
		in2 => sub1, --the subtractor feeds the in2 for muxX and muxY.
		sel => selX,
		output => muxX
	);
	
	U_MUX_Y : entity work.mux_2x1
	generic map(
		width => width)
		
	port map(
		in1 => inY,
		in2 => sub1,
		sel => selY,
		output => muxY
	);
	
	U_REG_X : entity work.reg
	generic map(
		width => width)
		
	port map(
		input => muxX,
		clk => clk,
		rst => rst,
		load => loadX,
		output => regX
	);
	
	U_REG_Y : entity work.reg
	generic map(
		width => width)
		
	port map(
		input => muxY,
		clk => clk,
		rst => rst,
		load => loadY,
		output => regY
	);
	
	U_REG_OUT : entity work.reg
	generic map(
		width => width)
		
	port map(
		input => regX,
		clk => clk,
		rst => rst,
		load => loadOut,
		output => output
	);
	
	U_COMPARATOR : entity work.comparator
	generic map(
		width => width)
  
	port map(
	x	=> regX,
	y   => regY,
	x_lt_y => x_lt_y,
	x_ne_y => x_ne_y
	);
	
	U_SUB1 : entity work.subtractor2 -- we only need one subtractor.
	generic map(
		width => width)
  
	port map(
	selIN => selIN,
	in1 => regX,
	in2 => regY,
	output => sub1
	);
	

end STRUCT;
	