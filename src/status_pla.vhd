-----------------------------
--PROGETTO FFT 16x16
--AMATO GIOVANNI LUCA Matr.267511
--CERBAI MATILDE Matr.274908 
--CHISCIOTTI LAURA Matr.274728
--GOTI GIANLUCA Matr.269825
-----------------------------
library ieee;
use ieee.std_logic_1164.all; 

entity status_pla is
port(
address: in std_logic_vector(2 downto 0);
data: out std_logic --0 vai in sequenza & 1 salta
);
end status_pla;

architecture structural of status_pla is
signal data_sig: std_logic;
begin 

	process(address)
	begin
		case address is
			when "000" =>
				data_sig<='1';
			when "001" =>
				data_sig<='0'; -- salta perchè sente lo start, che è selezionato dal cc=0
			when "010" =>
				data_sig<='1';
			when "011" =>
				data_sig<='1';
			when "100" =>
				data_sig<='0';
			when "101" =>
				data_sig<='0';
			when "110" =>
				data_sig<='1';
			when others =>
				data_sig<='1';
			
		end case;
	end process;
data<=data_sig;
end structural;