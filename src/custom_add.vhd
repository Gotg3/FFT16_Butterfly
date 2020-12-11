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

entity custom_add is
port(
add_in: in std_logic_vector(2 downto 0);
add_out: out std_logic_vector( 2 downto 0)
);

end custom_add;

architecture behavioural of custom_add is
	begin
		c_add_proc: process (add_in)
		begin
			case add_in is
				when "000" =>
					add_out<="001";
				when "010" =>
					add_out<="011";
				when others =>
					add_out<="000";
			end case;
		end process;
	end behavioural;
			