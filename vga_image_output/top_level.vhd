-- Greg Stitt
-- University of Florida

-- The following entity is the top-level entity for lab 4. No changes are
-- required, but you need to map the I/O to the appropriate pins on the DE0
-- board.

-- I/O Explanation (assumes the switches are on side of the
--                  DE0 board that is closest to you)
-- switch(9) is the leftmost switch
-- button(2) is the leftmost button
-- led3 is the leftmost 7-segment LED
-- ledx_dp is the decimal point on the 7-segment LED for LED x (active low)

-- Note: this code will cause a harmless synthesis warning because not all
-- the switches are used and because some output pins are always '0' or '1'

library ieee;
use ieee.std_logic_1164.all;

entity top_level is
    port (
        clk      : in  std_logic;
		X        : in  std_logic_vector(7 downto 0);
        Y        : in  std_logic_vector(7 downto 0);
        go       : in  std_logic;
        rst      : in  std_logic;
        led0     : out std_logic_vector(6 downto 0);
        led0_dp  : out std_logic;
        led1     : out std_logic_vector(6 downto 0);
        led1_dp  : out std_logic;
        led2     : out std_logic_vector(6 downto 0);
        led2_dp  : out std_logic;
        led3     : out std_logic_vector(6 downto 0);
        led3_dp  : out std_logic);
end top_level;

architecture STR of top_level is

    component decoder7seg
        port (
            input  : in  std_logic_vector(3 downto 0);
            output : out std_logic_vector(6 downto 0));
    end component;

    component gcd
        
       	generic(WIDTH : positive := 8);
        port (
			  clk    : in  std_logic;
			  rst    : in  std_logic;
			  go     : in  std_logic;
			  done   : out std_logic;
			  x      : in  std_logic_vector(WIDTH-1 downto 0);
			  y      : in  std_logic_vector(WIDTH-1 downto 0);
			  output : out std_logic_vector(WIDTH-1 downto 0));
    end component;


     signal tempDone : std_logic;
	 signal tempResult : std_logic_vector(7 downto 0);
	 
	 signal tempX : std_logic_vector(7 downto 0);
	 signal tempY : std_logic_vector(7 downto 0);
	 
	 constant const : std_logic_vector := "0000";
    
begin  -- STR

	 

    U_GCD_1 : gcd
		generic map(
        WIDTH => 8
		  )
		  
		port map(
        clk => clk,
        rst => not(rst), --we not these so that a button press will assert these inputs.
        go  => not(go),
        done  => tempDone,
        x  => tempX,
        y  => tempY,
        output => tempResult(7 downto 0)
		  );

    U_LED3 : decoder7seg port map (
        input  => tempResult(7 downto 4),
        output => led3);

    U_LED2 : decoder7seg port map (
        input  => tempResult(3 downto 0),
        output => led2);

    U_LED1 : decoder7seg port map (
        input  => const,
        output => led1);

    U_LED0 : decoder7seg port map (
        input  => const,
        output => led0);

    led3_dp <= not(tempDone);
    led2_dp <= not(tempDone);
    led1_dp <= '0';
    led0_dp <= '0';
	
	tempX <= "000" & X(4 downto 0); --since there are only 10 switches we will use 5 for each input and have their highest 3 bits be zero.
	tempY <= "000" & Y(4 downto 0);

end STR;

configuration top_level_cfg of top_level is
    for STR
        for U_GCD_1 : gcd
            use entity work.gcd(FSM_D1);  -- change this line for other
                                                  -- architectures 
        end for;
    end for;
end top_level_cfg;