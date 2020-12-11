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

entity flipflop_m is 
generic ( parallelism: integer := 24 );
port( clk, Rst: in std_logic;
		D: in signed(parallelism*2 downto 0);
		q: out signed(parallelism*2 downto 0)
		);
end flipflop_m;

architecture behavior of flipflop_m is 
begin 
	process(clk)
	begin
			if (clk' event and clk='1') then
				if(Rst='1') then -- synchronous clear
				q<=(others=>'0');
				else 
				q<= D;
				end if;
			end if;
	end process;
end behavior;