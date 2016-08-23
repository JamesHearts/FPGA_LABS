library ieee;
use ieee.std_logic_1164.all;

entity adder is
    generic (
        WIDTH : positive := 8); 
    port (
        x, y : in  std_logic_vector(WIDTH-1 downto 0);
        cin  : in  std_logic;
        s    : out std_logic_vector(WIDTH-1 downto 0);
        cout : out std_logic);
end adder;

architecture RIPPLE_CARRY of adder is
	
	signal carry_sig: std_logic_vector(WIDTH downto 0);
begin  -- RIPPLE_CARRY

	U_RCA : for i in 0 to WIDTH-1 generate

	U_FA1 : entity work.fa 
	port map(
		input1 => x(i),
		input2 => y(i),
		carry_in => carry_sig(i),
		sum => s(i),
		carry_out => carry_sig(i + 1)
	);
		
	end generate U_RCA;
	
	carry_sig(0) <= cin;
	cout <= carry_sig(WIDTH);


end RIPPLE_CARRY;


architecture CARRY_LOOKAHEAD of adder is

begin  -- CARRY_LOOKAHEAD

    process(x, y, cin)

        -- generate and propagate bits
        variable g, p : std_logic_vector(WIDTH-1 downto 0);

        -- internal carry bits
        variable carry : std_logic_vector(WIDTH downto 0);

        -- and'd p sequences
        variable p_ands : std_logic_vector(WIDTH-1 downto 0);

    begin

        -- calculate generate (g) and propogate (p) values

        for i in 0 to WIDTH-1 loop
		
		-- code that defines each g and p bit
		-- from our derived equations we can see that p is equal to x or y;
		-- from our derived equations we can see that g is equal to x and y;
		p(i) := x(i) or y(i);
		g(i) := x(i) and y(i);
        
        end loop;  -- i

        carry(0) := cin;

        -- calculate each carry bit

        for i in 1 to WIDTH loop

            -- calculate and'd p terms for ith carry logic      
            -- the index j corresponds to the lowest Pj value in the sequence
            -- e.g., PiPi-1...Pj

            for j in 0 to i-1 loop
                p_ands(j) := '1';

                -- and everything from Pj to Pi-1
                for k in j to i-1 loop
				-- Because the most significant bit is present in all combinations of "P-and terms". J will increment causing the least significant bits...
				-- to fall out every interation. Thus the most most significant bit is left in each interation.
				p_ands(j) := p_ands(j) and p(k);
                end loop;
            end loop;

			-- Because c-1 = G(previous) or [p(i-1) and c-1] we are always storing G(previous) into the carry.
            carry(i) := g(i-1);

            -- handling all of the pg minterms
            for j in 1 to i-1 loop
			
			carry(i) := carry(i) or (p_ands(j) and g(j-1));
            -- fill in code
            end loop;

            -- handle the final propagate of the carry in
            carry(i) := carry(i) or (p_ands(0) and cin);
        end loop;  -- i

        -- set the outputs
        for i in 0 to WIDTH-1 loop
		-- this is he generic equation for the sum of an adder.
		s(i) <= x(i) xor y(i) xor carry(i);
        -- fill in code
        end loop;  -- i

        cout <= carry(WIDTH);

    end process;

end CARRY_LOOKAHEAD;


-- You don't have to change any of the code for the following
-- architecture. However, read the lab instructions to create
-- an RTL schematic of this entity so you can see how the
-- synthesized circuit differs from the previous carry
-- lookahead circuit.

architecture CARRY_LOOKAHEAD_BAD_SYNTHESIS of adder is
begin  -- CARRY_LOOKAHEAD_BAD_SYNTHESIS

    process(x, y, cin)

        -- generate and propagate bits
        variable g, p : std_logic_vector(WIDTH-1 downto 0);

        -- internal carry bits
        variable carry : std_logic_vector(WIDTH downto 0);

    begin

        -- calculate generate (g) and propogate (p) values

        for i in 0 to WIDTH-1 loop
            g(i) := x(i) and y(i);
            p(i) := x(i) or y(i);
        end loop;  -- i

        -- calculate carry bits (the order here is very important)
        -- Problem: defining the carries this way causes the synthesis
        -- tool to chain everything together like a ripple carry.
        -- See RTL view in synthesis tool.

        carry(0) := cin;
        for i in 0 to WIDTH-1 loop
            carry(i+1) := g(i) or (p(i) and carry(i));
        end loop;  -- i

        -- set the outputs

        for i in 0 to WIDTH-1 loop
            s(i) <= x(i) xor y(i) xor carry(i);
        end loop;  -- i

        cout <= carry(WIDTH);

    end process;

end CARRY_LOOKAHEAD_BAD_SYNTHESIS;



architecture HIERARCHICAL of adder is

	signal C1, P0, P1, G0, G1 : std_logic;

begin  -- HIERARCHICAL

	CLA4_1 : entity work.cla4
	port map(
	
		input1 => x(3 downto 0),
		input2 => y(3 downto 0),
		cin => cin,
		cout => open,
		sum => s(3 downto 0),
		
		BP => P0,
		BG => G0
	);
	
	CLA4_2 : entity work.cla4
	port map(
		input1 => x(7 downto 4),
		input2 => y(7 downto 4),
		cin => C1,
		cout => open,
		sum => s(7 downto 4),
		
		BP => P1,
		BG => G1
	);
	
	CGEN : entity work.cgen2
	port map(
	
		cin => cin, 
		
		P0 => P0,
		G0 => G0,
		
		P1 => P1,
		G1 => G1,
		
		Ci1 => C1,
		Ci2 => cout,
		
		BP => open,
		BG => open
	);

end HIERARCHICAL;