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

entity muxdp_6not is
	generic ( parallelism: integer := 49 );
port(
	d1: in signed(parallelism-1 downto 0);
	d2: in signed(parallelism-1 downto 0);
	q: out signed(parallelism-1 downto 0);
	sel: in std_logic
	);
end muxdp_6not;
	architecture behavioural of muxdp_6not is
	signal sel_sig: std_logic;
		begin
			mux_proc:process(d1,d2,sel_sig)
			begin
				case sel_sig is
					when '0' =>
						q<=d1;
					when others =>
						q<=d2;
				end case;
			end process mux_proc;
			
			sel_sig<=not(sel);	
			
	end behavioural;
	

	