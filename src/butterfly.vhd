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

entity butterfly is 
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
end entity;

architecture structural of butterfly is

signal dp_commands_sig: std_logic_vector(33 downto 0); --sarebbero 35 segnali ma uno è il done che
-- viene collegato direttamente in uscita
signal str_sig: std_logic; -- per collegare i due flip flop e ritardare lo start
--signal rst_sig: std_logic;

	component fflop
	port(
		clk: in std_logic;
		--nrst: in std_logic;
		d_str: in std_logic;
		q_str: out std_logic
	);
	end component;
	
	component control_unit
	port(
	clk: in std_logic;
	rst: in std_logic;
	status: in std_logic; --segnale di start 
	dp_commands: out std_logic_vector(34 downto 0) --modificato per aggiungere il done (sono 33 comandi)
																  --modificato 9-1-2020 per aggiungere sel mux e demux
	);
	end component;
	
	component dp_butterfly
	generic ( parallelism: integer := 24 );
	port(
		ck,reset,ctr_in,en_FF1_in,en_FF2_in,en_FF3_in,en_FF4_in,en_FF5_in,R_enAB_in,R_enW_in,W_enAB_in,W_enW_in : in std_logic;
		R_addressA_in,R_addressB_in,R_addressW_in,W_addressAB_in,W_addressWr_in : in std_logic_vector(2 downto 0);
		B_in: in signed(parallelism-1 downto 0);
		A_in: in signed(parallelism-1 downto 0);
		Wr_in: in signed(parallelism-1 downto 0);
		Wi_in: in signed(parallelism-1 downto 0);
		A_out: out signed(parallelism-1 downto 0);
		B_out: out signed(parallelism-1 downto 0);
		sel1,sel2,sel3,sel4,sel5_6,sel7,sel8,sel_demux_out: in std_logic 
		--ATTENZIONE sel5_6 il controllo del MUX5, ma se viene negato funge anche da controllo per il MUX6
		);
	end component;

begin

	str_reg: fflop
		port map(
			clk=>clk,
			d_str=>str,
			q_str=>str_sig
		);
		
		

	cu: control_unit
		port map(
			clk=>clk,
			rst=> rst,  --collegato al reset del uAR
			status=>str_sig, 
			dp_commands(34 downto 1)=>dp_commands_sig, -- i dp_commands_sig vanno da 0 a 35, aggiunti sel custom e OE shift reg
			dp_commands(0)=>done
		);

		
	dp: dp_butterfly 
		port map(
			ck=>clk,
			reset=>dp_commands_sig(0), 
			ctr_in=>dp_commands_sig(11),
			en_FF1_in=>dp_commands_sig(9),
			en_FF2_in=>dp_commands_sig(4),
			en_FF3_in=>dp_commands_sig(7),
			en_FF4_in=>dp_commands_sig(3),
			en_FF5_in=>dp_commands_sig(1),
			R_enAB_in=>dp_commands_sig(19),
			R_enW_in=>dp_commands_sig(23),
			W_enAB_in=>dp_commands_sig(27),
			W_enW_in=>dp_commands_sig(31),
			R_addressA_in=>dp_commands_sig(18 downto 16),
			R_addressB_in=>dp_commands_sig(15 downto 13),
			R_addressW_in=>dp_commands_sig(22 downto 20),
			W_addressAB_in=>dp_commands_sig(26 downto 24),
			W_addressWr_in=>dp_commands_sig(30 downto 28),
			--A_B_in=>data_in,
			Wr_in=>wr_in,
			Wi_in=>wi_in,
			A_out=>data_out_A,
			B_out=>data_out_B,
			sel1=>dp_commands_sig(12),
			sel2=>dp_commands_sig(10),
			sel3=>dp_commands_sig(8),
			sel4=>dp_commands_sig(6),
			sel5_6=>dp_commands_sig(5),
			sel7=>dp_commands_sig(2),
			sel8=>dp_commands_sig(33), -- sel mux7 
			sel_demux_out=> dp_commands_sig(32), --sel demux uscita sdoppiata 
			A_in=>data_in_A,
			B_in=>data_in_B
			
	);
			

end structural;
	