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

entity mux_zeros is
	generic ( parallelism: integer := 49 );
port(
	d1: in signed(parallelism-1 downto 0);
	d2: in signed(parallelism-1 downto 0);
	q: out signed(parallelism-1 downto 0);
	sel: in std_logic_vector(1 downto 0)
	);
end mux_zeros;
	architecture behavioural of mux_zeros is
		begin
			mux_proc:process(d1,d2,sel)
			begin
				case sel is
					when "00" =>
						q<=d1;
					when "01" =>
						q<=d2;
					when others =>
						q<=(others =>'0');
				end case;
			end process mux_proc;
	end behavioural;
			