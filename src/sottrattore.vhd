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

entity sottrattore is
generic ( parallelism: integer := 49 );
port(
	s1: in signed(parallelism -1 downto 0);
	s2: in signed(parallelism -1 downto 0);
	sub: out signed(parallelism-1 downto 0)
	);
end sottrattore;

	architecture behavioural of sottrattore is
	
	begin 
		sottrattore_process: process(s1,s2)
			begin
				sub<=signed(signed(s1)- signed(s2));
			end process sottrattore_process;
	end behavioural;
	