library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu_sla is
generic (
WIDTH : positive := 16
);

port (
input1 : in std_logic_vector(WIDTH-1 downto 0);
input2 : in std_logic_vector(WIDTH-1 downto 0);
sel : in std_logic_vector(3 downto 0);
output : out std_logic_vector(WIDTH-1 downto 0);
overflow : out std_logic
);
end alu_sla; 

architecture ALU of alu_sla is

begin

process (input1, input2)

	
	variable temp_result : std_logic_vector(WIDTH downto 0);
	--variable temp_mult : unsigned((WIDTH * 2)-1 downto 0);
	variable temp_mult : std_logic_vector((WIDTH * 2)-1 downto 0);
	variable temp_evenupper : std_logic_vector((WIDTH/2)-1 downto 0);
	variable temp_evenlower : std_logic_vector((WIDTH/2)-1 downto 0);
	variable temp_oddupper : std_logic_vector(((WIDTH-1)/2)-1 downto 0);
	variable temp_oddlower : std_logic_vector((WIDTH-1) downto (WIDTH-1)/2);
	variable temp_ccresult : std_logic_vector(WIDTH-1 downto 0);
	
	
	
	begin
		
		case sel is
		
			when "0000" => 
				temp_result := (('0' & input1) + ('0' & input2));
		
				--temp_result := std_logic_vector(resize(unsigned(input1), WIDTH+1) + resize(unsigned(input2), WIDTH+1));
				output <= temp_result(WIDTH-1 downto 0);
				overflow <= temp_result(WIDTH);
			when "0001" =>
				temp_result := ('0' & input1) - ('0' & input2);
				--temp_result := std_logic_vector(resize(unsigned(input1), WIDTH+1) - resize(unsigned(input2), WIDTH+1));
				output <= temp_result(WIDTH-1 downto 0);
				overflow <= '0';
			when "0010" =>
				temp_mult := input1 * input2;
				--temp_mult := unsigned(input1) * unsigned(input2);
				--output <= std_logic_vector(temp_mult((WIDTH-1) downto 0));
				output <= (temp_mult((WIDTH-1) downto 0));
				overflow <= temp_result(WIDTH/2);
				
				if(temp_mult(WIDTH*2 - 1 downto WIDTH) = 0) then
				overflow <= '0';
				else
				overflow <= '1';
				end if;
				
			when "0011" =>
				output <= input1 and input2;
				overflow <= '0';
			when "0100" =>
				output <= input1 or input2;
				overflow <= '0';
			when "0101" =>
				output <= input1 xor input2;
				overflow <= '0';
			when "0110" =>
				output <= not(input1 or input2);
				overflow <= '0';
			when "0111" =>
				output <= not(input1);
				overflow <= '0';
			when "1000" =>
				overflow <= input1(WIDTH-1);
				--output <= std_logic_vector(shift_left(unsigned(input1), 1));
				output <= shl(input1, "1");
			when "1001" =>
				--output <= std_logic_vector(shift_right(unsigned(input1), 1));
				output <= shr(input1, "1");
				overflow <= '0';
			when "1010" =>
				if (WIDTH mod 2 = 0)  then
					temp_evenupper := input1((WIDTH/2)-1 downto 0);
					temp_evenlower := input1((WIDTH-1) downto (WIDTH/2));
					temp_ccresult := temp_evenupper & temp_evenlower;
					output <= temp_ccresult(WIDTH-1 downto 0);
					overflow <= '0';
				else
					temp_oddupper := input1(((WIDTH-1)/2)-1 downto 0);
					temp_oddlower := input1((WIDTH-1) downto (WIDTH-1)/2);
					temp_ccresult := temp_oddupper & temp_oddlower;
					output <= temp_ccresult(WIDTH-1 downto 0);
					overflow <= '0';
				end if;	
			when "1011" =>
			
				for i in 0 to (WIDTH-1) loop
				temp_ccresult(i) := input1(WIDTH-1 - i);
				end loop;
				
				output <= temp_ccresult;
				--output <= std_logic_vector(temp_ccresult);
				overflow <= '0';
			when "1100" =>
				--output <='0';
				overflow <='0';
			when "1101" =>
				--output <='0';
				overflow <='0';
			when "1110" =>
				--output <='0';
				overflow <='0';
			when "1111" =>
				--output <='0';
				overflow <='0';
			when others  =>
				--output <='0';
				overflow <='0';
		
		end case;
		
end process;

end ALU;