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

entity flipflop5 is 
generic ( parallelism: integer := 24 );
port( clk, Rst: in std_logic;
		D: in signed(parallelism-1 downto 0);
		q: out signed(parallelism-1 downto 0);
		en: in std_logic --per ora é nella versione dove en basso fa mantenere il dato vecchio
		);
end flipflop5;

architecture behavior of flipflop5 is 
signal q_sig: signed(parallelism-1 downto 0):=(others=>'0');
begin 
	process(clk)
	begin
			if (clk' event and clk='1') then
				if(Rst='1') then -- synchronous clear
				q_sig<=(others =>'0');
				else 
					if(en='1') then
						q_sig<= D;
				else
						q_sig<=q_sig;
					end if;
				end if;
			end if;
	end process;
q<=q_sig;
end behavior;