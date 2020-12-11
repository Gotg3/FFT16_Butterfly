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

entity incrementatore is
generic(parallelism: integer:=4);
port(
data_in: in std_logic_vector(parallelism-1 downto 0);
data_out: out std_logic_vector(parallelism-1 downto 0)
);
end incrementatore;

architecture behavioural of incrementatore is
constant one: std_logic_vector(parallelism-1 downto 0):= "0001";

begin
		
	data_out<=std_logic_vector(unsigned(data_in)+unsigned(one));

end behavioural;