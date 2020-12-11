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

entity sommatore is
generic ( parallelism: integer := 49 );
port(
	s1: in signed(parallelism -1 downto 0);
	s2: in signed(parallelism -1 downto 0);
	sum: out signed(parallelism-1 downto 0) --poichè con gli ingressi che gli diamo non arriverà mai a 50 bit
	);
end sommatore;
	architecture behavioural of sommatore is
	
	begin 
		sommatore_process: process(s1,s2)
			begin
			   sum<=signed(signed(s1)+ signed(s2));
				-- prima era così sum<=std_logic_vector(resize((signed(s1)+ signed(s2)),25));
			end process sommatore_process;
	end behavioural;
	