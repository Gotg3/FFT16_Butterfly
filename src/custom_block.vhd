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

entity custom_block is
	generic ( parallelism: integer := 24 );
port(
	d0: in signed(parallelism-1 downto 0);
	d1: in signed(parallelism-1 downto 0);
	d2: in signed(parallelism-1 downto 0);
	q1: out signed(parallelism-1 downto 0);
	q2: out signed(parallelism-1 downto 0);
	sel: in std_logic
	);
end custom_block;
	architecture behavioural of custom_block is
		begin
			castom_proc:process(d0,d1,d2,sel)
			begin
				case sel is
					when '0' =>
						q2<=d1;
						q1<=d0;
					when others =>
						q2<=d2;
						q1<=d1;
				end case;
			end process castom_proc;
	end behavioural;
			