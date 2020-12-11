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

entity Wrom is
	port
	(
		--Wr outputs
		Wr0: out SIGNED(23 downto 0);
		Wr1: out SIGNED(23 downto 0);
		Wr2: out SIGNED(23 downto 0);
		Wr3: out SIGNED(23 downto 0);
		Wr4: out SIGNED(23 downto 0);
		Wr5: out SIGNED(23 downto 0);
		Wr6: out SIGNED(23 downto 0);
		Wr7: out SIGNED(23 downto 0);
		--Wi outputs
		Wi0: out SIGNED(23 downto 0);
		Wi1: out SIGNED(23 downto 0);
		Wi2: out SIGNED(23 downto 0);
		Wi3: out SIGNED(23 downto 0);
		Wi4: out SIGNED(23 downto 0);
		Wi5: out SIGNED(23 downto 0);
		Wi6: out SIGNED(23 downto 0);
		Wi7: out SIGNED(23 downto 0)
	);
end Wrom;

	architecture behavioural of Wrom is
	begin
		Wr0<="011111111111111111111111";--others =>'0'); 
		--Wr e Wi stanno sulla circonferenza unitaria, il loro modulo deve dare  1, sono parte Re e Im del vettore W
		Wr1<="011101100100000110101111";--(others =>'0');
		Wr2<="010110101000001001111001";--(others =>'1');
		Wr3<="001100001111101111000101";--(others =>'0');
		Wr4<="000000000000000000000000";--(others =>'0');
		Wr5<="110011110000010000111011";--(others =>'0');
		Wr6<="101001010111110110000111";--(others =>'0');
		Wr7<="100010011011111001010001";--(others =>'0');
		--
		Wi0<="000000000000000000000000";--(others =>'0'); 
		Wi1<="110011110000010000111011";--(others =>'0');
		Wi2<="101001010111110110000111";--(others =>'1');
		Wi3<="100010011011111001010001";--(others =>'0');
		Wi4<="100000000000000000000000";--(others =>'0');
		Wi5<="100010011011111001010001";--(others =>'0');
		Wi6<="101001010111110110000111";--(others =>'0');
		Wi7<="110011110000010000111011";--(others =>'0');
		
	end behavioural;	
