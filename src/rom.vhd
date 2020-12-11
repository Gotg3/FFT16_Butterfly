-----------------------------
--PROGETTO FFT 16x16
--AMATO GIOVANNI LUCA Matr.267511
--CERBAI MATILDE Matr.274908 
--CHISCIOTTI LAURA Matr.274728
--GOTI GIANLUCA Matr.269825
-----------------------------
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
entity rom is
port(
address: in signed(5 downto 0);
data: out std_logic
);
end rom;

architecture structural of rom is
begin 
process(address)
	begin
		case address is
			when "000000" =>
			   data<='0';
			when "000001" =>
   			   data<='0';
			when "000010" =>
			   data<='0';
			when "000011"=>
			   data<='0';
			when "000100"=>
			   data<='0';
			when "000101"=>
			   data<='0';
			when "000110"=>
		           data<='0';
			when "000111"=>
			   data<='0';
			when "001000"=>
			   data<='0';
			when "001001"=>
			   data<='0';
			when "001010"=>
			   data<='0';
			when "001011"=>
			   data<='0';
			when "001100"=>
			   data<='0';
			when "001101"=>
			   data<='0';
			when "001110"=>
			   data<='0';
			when "001111"=>
            		   data<='0';
	      		when "010000"=>
			   data<='1';
			when "010001"=>
			   data<='1';
			when "010010"=>
			   data<='1';
			when "010011"=>
			   data<='1';
			when "010100"=>
			   data<='1';
			when "010101"=>
			   data<='1';
			when "010110"=>
			   data<='1';
			when "010111"=>
			   data<='1';
			when "011000"=>
			   data<='1';
			when "011001"=>
			   data<='1';
			when "011010"=>
			   data<='1';
			when "011011"=>
			   data<='1';
			when "011100"=>
			   data<='1';
			when "011101"=>
			   data<='1';
			when "011110"=>
			   data<='1';
		        when "011111"=>
			   data<='1';
		   	when "100000"=>
			   data<='1';
			when "100001"=>
			   data<='1';
			when "100010"=>
			   data<='1';
			when "100011"=>
			   data<='1';
			when "100100"=>
			   data<='1';
			when "100101"=>
			   data<='1';
			when "100110"=>
			   data<='1';
			when "100111"=>
			   data<='1';
			when "101000"=>
			   data<='1';
			when "101001"=>
			   data<='1';
			when "101010"=>
			   data<='1';
			when "101011"=>
			   data<='1';
			when "101100"=>
			   data<='1';
	        	when "101101"=>
			   data<='1';
			when "101110"=>
			   data<='1';
			when "101111"=>
			   data<='1';
			when "110000"=>
			   data<='0';
			when "110001"=>
			   data<='0';
			when "110010"=>
			   data<='0';
			when "110011"=>
			   data<='0';
			when "110100"=>
			   data<='0';
			when "110101"=>
			   data<='0';
			when "110110"=>
			   data<='0';
			when "110111"=>
			   data<='0';
			when "111000"=>
			   data<='0';
			when "111001"=>
			   data<='0';
			when "111010"=>
			   data<='0';
			when "111011"=>
			   data<='0';
			when "111100"=>
			   data<='0';
			when "111101"=>
			   data<='0';
			when "111110"=>
			   data<='0';
			when others=>
			   data<='0';
		end case;
	end process;

end structural;