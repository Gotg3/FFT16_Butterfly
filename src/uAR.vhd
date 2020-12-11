-----------------------------
--PROGETTO FFT 16x16
--AMATO GIOVANNI LUCA Matr.267511
--CERBAI MATILDE Matr.274908 
--CHISCIOTTI LAURA Matr.274728
--GOTI GIANLUCA Matr.269825
-----------------------------
library ieee;
use ieee.std_logic_1164.all; 

entity uAR is 
generic ( parallelism: integer := 4 );
port( clk, Rst: in std_logic;
		d: in std_logic_vector(parallelism-1 downto 0);
		q: out std_logic_vector(parallelism-1 downto 0)
		);
end uAR;

architecture behavior of uAR is 
signal q_sig: std_logic_vector(parallelism-1 downto 0):="0001";
begin 
	process(clk)
	begin
			if (clk' event and clk='1') then
				if(Rst='1') then -- synchronous clear
				q_sig<=(others =>'0');
				else 
					q_sig<=d;
				end if;
			end if;
			
	end process;
q<=q_sig;
end behavior;