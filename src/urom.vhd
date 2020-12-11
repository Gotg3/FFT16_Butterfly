-----------------------------
--PROGETTO FFT 16x16
--AMATO GIOVANNI LUCA Matr.267511
--CERBAI MATILDE Matr.274908 
--CHISCIOTTI LAURA Matr.274728
--GOTI GIANLUCA Matr.269825
-----------------------------
library ieee;
use ieee.std_logic_1164.all; 

entity urom is
port(
address: in std_logic_vector(3 downto 0);
data: out std_logic_vector(40 downto 0) 
-- 42°bit al 41° per CC; da 40° a 36° per JUMP ADDRESS; da 35° a 1° per CONTROLLI
);
end urom;

architecture structural of urom is
begin 

	process(address)
	begin
		case address is
			when "0000" =>--Reset
				data<="10000110000000000000000000000000000001010"; --
		   when "0001" =>--Idle
			   data<="00000110000000000000000000000000000001000"; --
			when "0010" =>--Save1
			   data<="10000110110010000000000000000000000001000";  --
			when "0011" =>--Save2
			   data<="10000110000010100000000000000000000001000"; --
			when "0100" =>--Save3
			   data<="10000110000000001100100000100000000001000";--
			when "0101" =>--Save4
			   data<="10000110000000001101100001100000000001000";--
			when "0110" =>--Stato1
			   data<="10000110000000001101100000100000000001000";--
			when "0111" =>--Stato2
			   data<="10000110000000001100100001100010000001000";--
			when "1000" =>--Stato3
			   data<="10000110000000000000100000000010100101000";--
			when "1001" =>--Stato4
			   data<="10000110000000000000101000011110010111000";--
			when "1010" =>--Stato5
			   data<="10000100000000000000000000011110101111000";-- 
			when "1011" =>--Stato6
			   data<="10000100000000000000000000000001101001000";-- 
			when "1100" =>--Stato7
			   data<="10000100000000000000000000000000011010000";--
			when "1101" =>--Stato8
			   data<="00111101000000000000000000000000000001101";-- qui c'è Il DONE
			when "1110" =>--Save1_output1
			   data<="11001110110010000000000000000000000001100"; --
			when "1111" =>--Output1
			   data<="11000110000000000000000000000000000001100";--
			when others =>
				data<="11000010000000000000000000000000000001000"; 
			-- è lo stessa codifica che si ha per lo stato IDLE per quanto riguarda la parte dei controlli
			
		end case;
	end process;

end structural;





