-----------------------------
--PROGETTO FFT 16x16
--AMATO GIOVANNI LUCA Matr.267511
--CERBAI MATILDE Matr.274908 
--CHISCIOTTI LAURA Matr.274728
--GOTI GIANLUCA Matr.269825
-----------------------------
library ieee;
use ieee.std_logic_1164.all;

entity fflop is  --flip flip per lo start
	port
	(
		clk: in std_logic;
		--nrst: in std_logic;
		d_str: in std_logic;
		q_str: out std_logic
	);
end fflop;

architecture behavioral of fflop is
begin

	dff_process: process(clk) -- ff con reset sincrono
	begin
		if (clk'event and clk = '1') then
			--if(nrst = '0') then
				q_str <= '0';
			--else
				q_str <= d_str;
			--end if;
		end if;
	end process dff_process;

end behavioral;
