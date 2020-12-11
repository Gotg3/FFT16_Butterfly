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
use work.my_package.all;

entity FFT is --dichiaro tutti IN e OUT della entity che racchiude tutti i componenti
generic ( parallelism: integer := 24;
				x: integer := 16 );
	port(
		clk, reset, start : in std_logic;
		X_in: in input ;
		X_out: out input ;
		done: out std_logic 
		);
end entity FFT;

architecture structural of FFT is --l'architettura struttrale 

signal temp1, temp2, temp3: input;
signal done1, done2, done3: std_logic;
signal d1, d2, d3, d4: std_logic_vector(7 downto 0);
--segnali di appoggio per wr e wi
signal Wr0_sig: signed (23 downto 0);
signal Wi0_sig: signed (23 downto 0);
signal Wr1_sig: signed (23 downto 0);
signal Wi1_sig: signed (23 downto 0);
signal Wr2_sig: signed (23 downto 0);
signal Wi2_sig: signed (23 downto 0);
signal Wr3_sig: signed (23 downto 0);
signal Wi3_sig: signed (23 downto 0);
signal Wr4_sig: signed (23 downto 0);
signal Wi4_sig: signed (23 downto 0);
signal Wr5_sig: signed (23 downto 0);
signal Wi5_sig: signed (23 downto 0);
signal Wr6_sig: signed (23 downto 0);
signal Wi6_sig: signed (23 downto 0);
signal Wr7_sig: signed (23 downto 0);
signal Wi7_sig: signed (23 downto 0);

component butterfly is 
port(
	clk: in std_logic;
	str: in std_logic; --start
	rst: in std_logic; --reset
	data_in_A: in signed(23 downto 0); --ingresso di A 
	data_in_B: in signed(23 downto 0);
	wr_in: in signed(23 downto 0);	-- ingresso Wr
	wi_in: in signed(23 downto 0);	-- ingresso Wi
	data_out_A: out signed(23 downto 0); --uscita dati A
	data_out_B: out signed(23 downto 0); --uscita dati B
	done: out std_logic
);
end component;

--Rom per Wr e Wi
component Wrom is
port(
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
end component;


--la FFT si divide in 4 stadi di butterflies interconnessi: il primo creato con un unico generate avvendo indici consecutivi.
--Passiamo i primi 8 W e salviamo le uscite in un signal (temp1) che andrá in input allo stage 2 e cosí per i successivi.
--Gli stage successivi sono divisi in sottoblocchi non avendo indici contigui (2 generate per lo stage 2, 4 per lo stage 3,
--mentre lo stage 4 essendo formato da singole butterfly non ha bisogno di generate)
--indici di i diversi (i1,i2...) per evitare conflitti se non sono considerate vriabili locali ma globali


begin
	
	W_rom: Wrom
		port map(
		--Wr segnali di appoggio
		Wr0=>Wr0_sig,
		Wr1=>Wr1_sig,
		Wr2=>Wr2_sig,
		Wr3=>Wr3_sig,
		Wr4=>Wr4_sig,
		Wr5=>Wr5_sig,
		Wr6=>Wr6_sig,
		Wr7=>Wr7_sig,
		--Wi segnali di appoggio
		Wi0=>Wi0_sig,
		Wi1=>Wi1_sig,
		Wi2=>Wi2_sig,
		Wi3=>Wi3_sig,
		Wi4=>Wi4_sig,
		Wi5=>Wi5_sig,
		Wi6=>Wi6_sig,
		Wi7=>Wi7_sig
		);
	
			--first stage
   G_1 : for i1 in 0 to 7 generate 
		Butterfly1 : butterfly port map(
				clk, start, reset,
				X_in(i1), X_in(i1+8),
				Wr0_sig,Wi0_sig,
				temp1(i1), temp1(i1+8),
				d1(i1)
				);
         end generate;
			
			--second stage
   G_2_1 : for i2 in 0 to 3 generate 
		Butterfly2 : butterfly port map(
				clk, done1, reset, 
				temp1(i2), temp1(i2+4),
				Wr0_sig,Wi0_sig,
				temp2(i2), temp2(i2+4),
				d2(i2)
				);
         end generate;
			
   G_2_2 : for i3 in 8 to 11 generate 
		Butterfly2 : butterfly port map(
				clk, done1, reset, 
				temp1(i3), temp1(i3+4),
				Wr4_sig,Wi4_sig,
				temp2(i3), temp2(i3+4),
				d2(i3-4)
				);
         end generate;		
		 
		 --third stage
   G_3_1 : for i4 in 0 to 1 generate 
		Butterfly3 : butterfly port map(
				clk, done2, reset,
				temp2(i4), temp2(i4+2),
				Wr0_sig,Wi0_sig,
				temp3(i4), temp3(i4+2),
				d3(i4)
				);
         end generate;
			
   G_3_2 : for i5 in 4 to 5 generate 
		Butterfly3 : butterfly port map(
				clk, done2, reset,
				temp2(i5), temp2(i5+2),
				Wr4_sig,Wi4_sig,
				temp3(i5), temp3(i5+2),
				d3(i5-2)
				);
         end generate;
			
   G_3_3 : for i6 in 8 to 9 generate 
		Butterfly3 : butterfly port map(
				clk, done2, reset,
				temp2(i6), temp2(i6+2),
				Wr2_sig,Wi2_sig,
				temp3(i6), temp3(i6+2),
				d3(i6-4)
				);
         end generate;
			
	G_3_4 : for i7 in 12 to 13 generate 
		Butterfly3 : butterfly port map(
				clk, done2, reset, 
				temp2(i7), temp2(i7+2),
				Wr6_sig,Wi6_sig,
				temp3(i7), temp3(i7+2),
				d3(i7-8)
				);
         end generate;
			
			--forth stage
	G_4_1 : butterfly port map(
				clk,  done3, reset,
				temp3(0), temp3(1),
				Wr0_sig,Wi0_sig,
				X_out(0), X_out(8),
				d4(0)
				);
         
	G_4_2 : butterfly port map(
				clk, done3 ,reset, 
				temp3(2), temp3(3),
				Wr4_sig,Wi4_sig,
				X_out(4), X_out(12),
				d4(1)
				);
         
	G_4_3 : butterfly port map(
				clk,  done3 ,reset,
				temp3(4), temp3(5),
				Wr2_sig,Wi2_sig,
				X_out(2), X_out(10),
				d4(2)
				);
         
	G_4_4 : butterfly port map(
				clk,  done3, reset,
				temp3(6), temp3(7),
				Wr6_sig,Wi6_sig,
				X_out(6), X_out(14),
				d4(3)
				);
         
	G_4_5 : butterfly port map(
				clk,  done3, reset,
				temp3(8), temp3(9),
				Wr1_sig,Wi1_sig,
				X_out(1), X_out(9),
				d4(4)
				);
      
	G_4_6 : butterfly port map(
				clk,  done3, reset,
				temp3(10), temp3(11),
				Wr5_sig,Wi5_sig,
				X_out(5), X_out(13),
				d4(5)
				);
         
	G_4_7 : butterfly port map(
				clk,  done3, reset,
				temp3(12), temp3(13),
				Wr3_sig,Wi3_sig,
				X_out(3), X_out(11),
				d4(6)
				);
			
	G_4_8 : butterfly port map(
				clk,  done3, reset,
				temp3(14), temp3(15),
				Wr7_sig,Wi7_sig,
				X_out(7), X_out(15),
				d4(7)
				);
			
done1<=d1(0) and d1(1) and d1(2) and d1(3) and d1(4) and d1(5) and d1(6) and d1(7);		
done2<=d2(0) and d2(1);
done3<=d3(0) and d3(1) and d3(2) and d3(3);
done<=d4(0) and d4(1) and d4(2) and d4(3) and d4(4) and d4(5) and d4(6) and d4(7);

end structural;
			