library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu_sla_tb is
end alu_sla_tb;

architecture TB of alu_sla_tb is

    component alu_sla

        generic (
            WIDTH : positive := 16
            );
        port (
            input1   : in  std_logic_vector(WIDTH-1 downto 0);
            input2   : in  std_logic_vector(WIDTH-1 downto 0);
            sel      : in  std_logic_vector(3 downto 0);
            output   : out std_logic_vector(WIDTH-1 downto 0);
            overflow : out std_logic
            );

    end component;

    constant WIDTH  : positive                           := 8;
    signal input1   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal input2   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal sel      : std_logic_vector(3 downto 0)       := (others => '0');
    signal output   : std_logic_vector(WIDTH-1 downto 0);
    signal overflow : std_logic;

begin  -- TB

    UUT : alu_sla
        generic map (WIDTH => WIDTH)
        port map (
            input1   => input1,
            input2   => input2,
            sel      => sel,
            output   => output,
            overflow => overflow);

    process
    	
    
    
    begin

        -- test 2+6 (no overflow)
        sel    <= "0000";
        input1 <= conv_std_logic_vector(2, input1'length);
        input2 <= conv_std_logic_vector(6, input2'length);
        wait for 40 ns;
        assert(output = conv_std_logic_vector(8, output'length)) report "Error : 2+6 = " & integer'image(conv_integer(output)) & " instead of 8" severity warning;
        assert(overflow = '0') report "Error                                   : overflow incorrect for 2+8" severity warning;

        -- test 250+50 (with overflow)
        sel    <= "0000";
        input1 <= conv_std_logic_vector(250, input1'length);
        input2 <= conv_std_logic_vector(50, input2'length);
        wait for 40 ns;
        assert(output = conv_std_logic_vector(300, output'length)) report "Error : 250+50 = " & integer'image(conv_integer(output)) & " instead of 44" severity warning;
        assert(overflow = '1') report "Error                                     : overflow incorrect for 250+50" severity warning;

        -- test 5*6
        sel    <= "0010";
        input1 <= conv_std_logic_vector(5, input1'length);
        input2 <= conv_std_logic_vector(6, input2'length);
        wait for 40 ns;
        assert(output = conv_std_logic_vector(30, output'length)) report "Error : 5*6 = " & integer'image(conv_integer(output)) & " instead of 30" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 5*6" severity warning;

        -- test 50*60
        sel    <= "0010";
        input1 <= conv_std_logic_vector(50, input1'length);
        input2 <= conv_std_logic_vector(60, input2'length);
        wait for 40 ns;
        assert(output = conv_std_logic_vector(3000, output'length)) report "Error : 50*60 = " & integer'image(conv_integer(output)) & " instead of 0" severity warning;
        assert(overflow = '1') report "Error                                      : overflow incorrect for 50*60" severity warning;

        -- add many more tests
		
		-- test sub 20-13
		sel <= "0001";
		input1 <= conv_std_logic_vector(20, input1'length);
		input2 <= conv_std_logic_vector(13, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(7, output'length)) report "Error : 20 - 13 = " & integer'image(conv_integer(output)) & " instead of 7" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 20-13" severity warning;
        
        -- test sub 82-90
		sel <= "0001";
		input1 <= conv_std_logic_vector(82, input1'length);
		input2 <= conv_std_logic_vector(90, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(-8, output'length)) report "Error : 82 - 90 = " & integer'image(conv_integer(output)) & " instead of -8" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 82-90" severity warning;
 
		-- test 10 and 10
		sel <= "0011";
		input1 <= conv_std_logic_vector(10, input1'length);
		input2 <= conv_std_logic_vector(10, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(10, output'length)) report "Error : 10 and 10 = " & integer'image(conv_integer(output)) & " instead of 10" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 10 and 10" severity warning;     
  
		-- test 82 and 90
		sel <= "0011";
		input1 <= conv_std_logic_vector(82, input1'length);
		input2 <= conv_std_logic_vector(90, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(82, output'length)) report "Error : 82 and 90 = " & integer'image(conv_integer(output)) & " instead of 82" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 82 and 90" severity warning;      
      
		-- test 5 and 10
		sel <= "0011";
		input1 <= conv_std_logic_vector(5, input1'length);
		input2 <= conv_std_logic_vector(10, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(0, output'length)) report "Error : 5 and 10 = " & integer'image(conv_integer(output)) & " instead of 0" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 5 and 10" severity warning;
        
		-- test 10 or 10
		sel <= "0100";
		input1 <= conv_std_logic_vector(10, input1'length);
		input2 <= conv_std_logic_vector(10, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(10, output'length)) report "Error : 10 or 10 = " & integer'image(conv_integer(output)) & " instead of 10" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 10 or 10" severity warning;     
  
		-- test 13 or 43
		sel <= "0100";
		input1 <= conv_std_logic_vector(13, input1'length);
		input2 <= conv_std_logic_vector(43, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(47, output'length)) report "Error : 13 or 43 = " & integer'image(conv_integer(output)) & " instead of 47" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 13 or 43" severity warning;      
      
		-- test 5 or 10
		sel <= "0100";
		input1 <= conv_std_logic_vector(5, input1'length);
		input2 <= conv_std_logic_vector(10, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(15, output'length)) report "Error : 5 or 10 = " & integer'image(conv_integer(output)) & " instead of 15" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 5 or 10" severity warning;
 
 		-- test 10 xor 10
		sel <= "0101";
		input1 <= conv_std_logic_vector(10, input1'length);
		input2 <= conv_std_logic_vector(10, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(0, output'length)) report "Error : 10 xor 10 = " & integer'image(conv_integer(output)) & " instead of 0" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 10 xor 10" severity warning;     
  
		-- test 82 xor 90
		sel <= "0101";
		input1 <= conv_std_logic_vector(82, input1'length);
		input2 <= conv_std_logic_vector(90, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(8, output'length)) report "Error : 82 xor 90 = " & integer'image(conv_integer(output)) & " instead of 8" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 82 xor 90" severity warning;      
      
		-- test 5 xor 11
		sel <= "0101";
		input1 <= conv_std_logic_vector(5, input1'length);
		input2 <= conv_std_logic_vector(11, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(14, output'length)) report "Error : 5 xor 10 = " & integer'image(conv_integer(output)) & " instead of 14" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 5 xor 10" severity warning;

		-- test 10101011 nor 10101010
		sel <= "0110";
		input1 <= conv_std_logic_vector(171, input1'length);
		input2 <= conv_std_logic_vector(170, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(84, output'length)) report "Error : 171 nor 170 = " & integer'image(conv_integer(output)) & " instead of 84" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 10 nor 10" severity warning;     
  
		-- test 11001101 nor 10101010
		sel <= "0110";
		input1 <= conv_std_logic_vector(205, input1'length);
		input2 <= conv_std_logic_vector(170, input2'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(16, output'length)) report "Error : 205 nor 170 = " & integer'image(conv_integer(output)) & " instead of 16" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 13 nor 43" severity warning;      
      
		-- test NOT 0x55
		sel <= "0111";
		input1 <= conv_std_logic_vector(85, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(170, output'length)) report "Error : not 0x55 = " & integer'image(conv_integer(output)) & " instead of 170" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 0x55" severity warning;
        
		-- test NOT 0xAA
		sel <= "0111";
		input1 <= conv_std_logic_vector(170, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(85, output'length)) report "Error : not 0xAA = " & integer'image(conv_integer(output)) & " instead of 85" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for not 0xAA" severity warning;
        
		-- test NOT 0
		sel <= "0111";
		input1 <= conv_std_logic_vector(255, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(0, output'length)) report "Error : not 255 = " & integer'image(conv_integer(output)) & " instead of 0" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for not 0xFF" severity warning;

		-- test shift left ob 01010101, c = 0, result = ob 10101010
		sel <= "1000";
		input1 <= conv_std_logic_vector(85, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(170, output'length)) report "Error : shift left 85 = " & integer'image(conv_integer(output)) & " instead of 170" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for shift left 85" severity warning;

		-- test shift left ob 10101010, c = 1, result = ob 01010100
		sel <= "1000";
		input1 <= conv_std_logic_vector(170, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(84, output'length)) report "Error : shift left 170 = " & integer'image(conv_integer(output)) & " instead of 84" severity warning;
        assert(overflow = '1') report "Error                                    : overflow incorrect for shift left 170" severity warning;

		-- test shift right ob 01010101, c = 0, result = ob 00101010
		sel <= "1001";
		input1 <= conv_std_logic_vector(85, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(42, output'length)) report "Error : shift right 85 = " & integer'image(conv_integer(output)) & " instead of 42" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for shift right 85" severity warning;

		-- test shift right ob 10101010, c = 0, result = ob 01010101
		sel <= "1001";
		input1 <= conv_std_logic_vector(170, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(85, output'length)) report "Error : shift right 170 = " & integer'image(conv_integer(output)) & " instead of 85" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for shift right 170" severity warning;
    
		-- test swap ob 0000 1110 
		sel <= "1010";
		input1 <= conv_std_logic_vector(14, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(224, output'length)) report "Error : swap ob 0000 1110 = " & integer'image(conv_integer(output)) & " instead of 0b 1110 0000" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for swap ob 0000 1110" severity warning;
      
		-- test Swap ob 1010 0100 
		sel <= "1010";
		input1 <= conv_std_logic_vector(164, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(74, output'length)) report "Error : swap ob 1010 0100 = " & integer'image(conv_integer(output)) & " instead of 0b 0100 1010" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for swap ob 1010 0100" severity warning;

		-- test reverse ob 0000 1110 
		sel <= "1011";
		input1 <= conv_std_logic_vector(14, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(112, output'length)) report "Error : reverse ob 0000 1110 = " & integer'image(conv_integer(output)) & " instead of 0b 0111 0000" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for reverse ob 0000 1110" severity warning;                                        

		-- test reverse ob 1010 1111, result is 1111 0101 
		sel <= "1011";
		input1 <= conv_std_logic_vector(175, input1'length);
		wait for 40 ns;
		assert(output = conv_std_logic_vector(245, output'length)) report "Error : swap ob 1010 1111 = " & integer'image(conv_integer(output)) & " instead of 0b 1111 0101" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for swap ob 1010 1111" severity warning;


        wait;

    end process;



end TB;