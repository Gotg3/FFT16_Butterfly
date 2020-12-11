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

entity mux_n is
	generic ( parallelism: integer := 49 );
port(
	d1: in signed(parallelism-1 downto 0);
	d2: in signed(parallelism-1 downto 0);
	q: out signed(parallelism-1 downto 0);
	sel: in std_logic
	);
end mux_n;
	architecture behavioural of mux_n is
		begin
			mux_proc:process(d1,d2,sel)
			begin
				case sel is
					when '0' =>
						q<=d1;
					when others =>
						q<=d2;
				end case;
			end process mux_proc;
	end behavioural;
			