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

entity dp_butterfly is --dichiaro tutti IN e OUT della entity che racchiude tutti i componenti
generic ( parallelism: integer := 24 );
	port(
		ck,reset,ctr_in,en_FF1_in,en_FF2_in,en_FF3_in,en_FF4_in,en_FF5_in,R_enAB_in,R_enW_in,W_enAB_in,W_enW_in : in std_logic;
		R_addressA_in,R_addressB_in,R_addressW_in,W_addressAB_in,W_addressWr_in : in std_logic_vector(2 downto 0); 
		B_in: in signed(parallelism-1 downto 0);
		A_in: in signed(parallelism-1 downto 0);
		Wr_in: in signed(parallelism-1 downto 0);
		Wi_in: in signed(parallelism-1 downto 0);
		A_out: out signed(parallelism-1 downto 0); --uscita da dove escono A 
		B_out: out signed(parallelism-1 downto 0); --uscita da dove escono B
		sel1,sel2,sel3,sel4,sel5_6,sel7,sel8,sel_demux_out: in std_logic --ATTENZIONE sel5_6 é il controllo del MUX5, ma se viene negato funge anche da controllo per il MUX6
		);
end entity dp_butterfly;

architecture structural of dp_butterfly is --l'architettura é struttrale 
signal mux2_sig,mux3_sig,mux4_sig,mux5_sig,mux6_sig,mux7_sig,FF1_sig,FF2_sig,FF3_sig,FF4_sig,M_sig,M_shift_sig,sum_sig,sot_sig: signed (parallelism*2 downto 0); --segnale di appoggio per i collegamenti interni
signal A_sig,B_sig,W_sig,mux1_sig: signed(parallelism-1 downto 0);
signal rounder_out_sig: std_logic;--l=6, d=5, quindi in uscita abbiamo un bit
signal A_B_in_sig: signed(parallelism-1 downto 0); -- questo è l'uscita del registro al RR
signal Wr_in_sig: signed(parallelism-1 downto 0); -- collega l'uscita del registro al RF 
signal Wi_in_sig: signed(parallelism-1 downto 0); -- collega l'uscita del registro al RF 
--signal mux_in_sig: signed(parallelism-1 downto 0); --collega il mux al registro prima del RR
--signal FF5_in_sig: std_logic_vector ( parallelism-1 downto 0);--segnale che unifica i bit buoni con i bit arrotondati
signal  A_q_sig: signed(parallelism-1 downto 0); -- uscita dal regsitro di ingresso
signal B_q_sig: signed(parallelism-1 downto 0); -- uscita dal regsitro di ingresso
signal W_addressWi_in_sig: std_logic_vector(2 downto 0); --segnale di appoggio, prende il 5 e lo fa diventare 6
signal A_demux_sig: signed(parallelism-1 downto 0); -- segnale di appoggio da demux a reg per uscite A
signal B_demux_sig: signed(parallelism-1 downto 0); -- segnale di appoggio da demux a reg per uscite B
signal B_in_sig: signed(parallelism-1 downto 0); -- segnale di appoggio dal registro di entrata di B al RF 
signal q0shift_sig:signed(parallelism-1 downto 0); -- sgnali di appoggio per uscita shift register
signal q1shift_sig:signed(parallelism-1 downto 0);
signal q2shift_sig:signed(parallelism-1 downto 0);
signal q3shift_sig:signed(parallelism-1 downto 0);
signal q1_custom_sig:signed(parallelism-1 downto 0); -- segnali di appoggio per il blocco custom
signal q2_custom_sig:signed(parallelism-1 downto 0);
signal A_B_muxR_sig: signed(parallelism -1 downto 0);-- sgnale di appoggio dopo il mux che lo collega al registro
signal add_custom_sig: std_logic_vector( 2 downto 0); -- segnale di appoggio per il secondo address del canale B
component multi_pipe 
--generic ( parallelism: integer := 24 );
		port(
			clk: in std_logic;
			rst: in std_logic;
			ctr: in std_logic;
			m1: in signed( parallelism -1 downto 0);
			m2: in  signed( parallelism -1 downto 0); -- é la porta a destra nel datapath, dove c'é il mux Mx
			AxB: out signed(parallelism*2  downto 0); --la moltiplicazione rende in uscita 2*n bit
			x2: out signed(parallelism*2 downto 0)
			);
end component multi_pipe;

component mux_zeros
	port(
			d1: in signed(parallelism*2 downto 0);
			d2: in signed(parallelism*2 downto 0);
			q: out signed(parallelism*2 downto 0);
			sel: in std_logic_vector(1 downto 0)
			);	
	end component mux_zeros;	

component mux_n
--generic ( parallelism: integer := 49 );
	port(
			d1: in signed(parallelism*2 downto 0);
			d2: in signed(parallelism*2 downto 0);
			q: out signed(parallelism*2 downto 0);
			sel: in std_logic
			);			
end component mux_n;

component mux1dp
--generic ( parallelism: integer := 24 );
	port(
			d1: in signed(parallelism-1 downto 0);
			d2: in signed(parallelism-1 downto 0);
			q: out signed(parallelism-1 downto 0);
			sel: in std_logic
			);			
end component mux1dp ;

component mux3dp
	--generic ( parallelism: integer := 24 );
port(
	d1: in signed(parallelism-1 downto 0);
	d2: in signed(parallelism*2 downto 0);
	q: out signed(parallelism*2 downto 0);
	sel: in std_logic
	);
end component mux3dp;

component flipflop
--generic ( parallelism: integer := 49 );
	port (clk, Rst: in std_logic;
		D: in signed(parallelism*2 downto 0);
		q: out signed(parallelism*2 downto 0);
		en: in std_logic
	);
end component flipflop;

component flipflop5
--generic ( parallelism: integer := 24 );
	port (clk, Rst: in std_logic;
		D: in signed(parallelism-1 downto 0);
		q: out signed(parallelism-1 downto 0);
		en: in std_logic
	);
end component flipflop5;

component flipflop_out
		port (clk, Rst: in std_logic;
		D: in signed(parallelism-1 downto 0);
		q: out signed(parallelism-1 downto 0);
		en: in std_logic
	);
end component flipflop_out;
	
component sommatore
--generic ( parallelism: integer := 49 );
	port(
	s1: in signed(parallelism*2 downto 0);
	s2: in signed(parallelism*2 downto 0);
	sum: out signed(parallelism*2 downto 0)
	);	
end component sommatore;

component sottrattore
--generic ( parallelism: integer := 49 );
   port(
	s1: in signed(parallelism*2 downto 0);
	s2: in signed(parallelism*2 downto 0);
	sub: out signed(parallelism*2 downto 0)
	);
end component sottrattore;

component register_file
--generic ( parallelism: integer := 24 );
		port(
		clk: in std_logic;
		rst: in std_logic;
		--write commands
		write_enAB: in std_logic;
		write_addA: in std_logic_vector(2 downto 0); -- sdoppiamento ingressi per A e B
		write_addB: in std_logic_vector(2 downto 0);
		write_addWr: in std_logic_vector(2 downto 0); 
		write_addWi: in std_logic_vector(2 downto 0);
		write_enW: in std_logic;
		--data in
		write_dataA: in signed(parallelism-1 downto 0); -- sdoppiamento ingressi per A e B
		write_dataB: in signed(parallelism-1 downto 0);
		write_dataWr: in signed(parallelism-1 downto 0); 
		write_dataWi: in signed(parallelism-1 downto 0);
		-- read commands
		read_enAB: in std_logic;
		read_enW: in std_logic;
		read_addA: in std_logic_vector(2 downto 0);
		read_addB: in std_logic_vector(2 downto 0);
		read_addW: in std_logic_vector(2 downto 0);
		-- data out
		out_A: out signed(parallelism-1 downto 0);
		out_B: out signed(parallelism-1 downto 0);
		out_W: out signed(parallelism-1 downto 0)
	);
end component register_file;

component rom
		port(
		address: in signed(5 downto 0);
		data: out std_logic
		);
end component rom;

	
component in_register --registri di inteermezzo ingresso uscita
	port( clk, Rst: in std_logic;
		D: in signed(parallelism-1 downto 0);
		q: out signed(parallelism-1 downto 0)
	);
	end component;
	
--component demux
	--port(
		--input: in signed(parallelism-1 downto 0);
		--out1: out signed(parallelism-1 downto 0);
		--out2: out signed(parallelism-1 downto 0);
		--sel: in std_logic
		--);
	--end component;
	
component custom_block
	port(
	d0: in signed(parallelism-1 downto 0);
	d1: in signed(parallelism-1 downto 0);
	d2: in signed(parallelism-1 downto 0);
	q1: out signed(parallelism-1 downto 0);
	q2: out signed(parallelism-1 downto 0);
	sel: in std_logic
	);
end component;
	
component shift_register
	port(
	clk: in std_logic;
	d: in signed(23 downto 0); 
	q0: out signed(23 downto 0);
	q1: out signed(23 downto 0);
	q2: out signed(23 downto 0);
	q3: out signed(23 downto 0);
	rst: in std_logic
	);
end component;

component custom_add -- serve a modificare l'address del secondo canale salvando tre bit di address
	port(
	add_in: in std_logic_vector(2 downto 0);
	add_out: out std_logic_vector( 2 downto 0)
	);
end component;	

begin

	--MUX_IN: component mux1dp -- abbiamo due registri in ingresso e il mux dopo tra registri e register file
		--port map(
			--d1=>A_q_sig,
			--d2=>B_q_sig,
			--q=>A_B_muxR_sig, 
			--sel=>sel_mux_in
		--	);
			
	--IN_REGISTER_MUX: component in_register --gli ingressi al RF non rimangono il tempo necessario, inserisco un registro
		--port map(
		--clk=>ck,
		--rst=>reset,
		--D=>A_B_muxR_sig,
		--q=>A_B_in_sig
		--);
  
	
	MUX1: component mux1dp
		port map(
			d1=>B_sig,
			d2=>A_sig,
			q=>mux1_sig,
			sel=>sel1
		);
		
	MUX2: component mux_n
		port map(
			--d1=>M_shift_sig, -- scambio le connessioni, il comando prima è 0 poi 1, prima deve prendere la moltiplicazione
			--d2=>M_sig,
			d1=>M_sig,
			d2=>M_shift_sig,
			q=>mux2_sig,
			sel=>sel2
		);
	
	MUX3: component mux3dp
		port map(
			d1=>A_sig,
			d2=>FF3_sig,
			q=>mux3_sig,
			sel=>sel3
		);
	
	MUX4: component mux_n
		port map(
			d1=>FF4_sig,
			d2=>FF3_sig,
			q=>mux4_sig,
			sel=>sel4
		);
		
	MUX5: component mux_n
		port map(
			d1=>mux4_sig,
			d2=>FF2_sig,
			q=>mux5_sig,
			sel=>sel5_6
		);
		
	MUX6: component mux_n
		port map(
			d1=>FF2_sig,
			d2=>mux4_sig,
			q=>mux6_sig,
			sel=>sel5_6
		);
				

	MUX7: component  mux_zeros
		port map(
			d1=>FF3_sig,
			d2=>FF4_sig,
			q=>mux7_sig,
			sel(0)=>sel7,
			sel(1)=>sel8
		);
				
	FF1: component flipflop
		port map(
		clk=>ck,
		Rst=>reset,
		D=>M_sig,
		q=>FF1_sig,
		en=>en_FF1_in
		);
		
	FF2: component flipflop
		port map(
		clk=>ck,
		Rst=>reset,
		D=>mux2_sig,
		q=>FF2_sig,
		en=>en_FF2_in
		);
		
	FF3: component flipflop
		port map(
		clk=>ck,
		Rst=>reset,
		D=>sum_sig,
		q=>FF3_sig,
		en=>en_FF3_in
		);
	
	FF4: component flipflop
		port map(
		clk=>ck,
		Rst=>reset,
		D=>sot_sig,
		q=>FF4_sig,
		en=>en_FF4_in
		);
		
	REG_OUT_A: component flipflop_out  --è uno dei registri di uscita, esce A
		port map(
		clk=>ck,
		Rst=>reset,
		D=>q2_custom_sig, 
		q=>A_out,
		en=>en_FF5_in -- lasciandolo sempre attivo arriva dato, dato, zero
		);
		
	REG_OUT_B: component flipflop_out  --è uno dei registri di uscita, esce B
		port map(
		clk=>ck,
		Rst=>reset,
		D=>q1_custom_sig, 
		q=>B_out, 
		en=>en_FF5_in --lasciandolo sempre attivo arriva dato, dato, zero
		);
		
	MLY: component  multi_pipe
	   port map(
		clk=>ck,
		rst=>reset,
	   ctr=>ctr_in,
		m1=>W_sig,
		m2=>mux1_sig,
		AxB=>M_sig,
		x2=>M_shift_sig
		);
	SUM: component sommatore
	   port map(
	   s1=>FF1_sig,
	   s2=>mux3_sig,
	   sum=>sum_sig
	   );
			
	SOT: component sottrattore
	   port map(
		s1=>mux5_sig,
	   s2=>mux6_sig,
      sub=>sot_sig
		);
		
	IN_A_REGISTER: component in_register
		port map(
		clk=>ck,
		rst=>reset,
		D=>A_in,
		q=>A_q_sig
		);
		
	IN_B_REGISTER: component in_register
		port map(
		clk=>ck,
		rst=>reset,
		D=>B_in,
		q=>B_q_sig
		);
		
	--IN_B_REGISTER_PIPE: component in_register
		--port map(
		--clk=>ck,
		--rst=>reset,
		--D=>B_in,
		--q=>B_in_sig
		--);
		
	IN_WR_REGISTER: component in_register
		port map(
		clk=>ck,
		rst=>reset,
	   D=>Wr_in,
		q=>Wr_in_sig
		
		);
		
			
	IN_WI_REGISTER: component in_register
		port map(
		clk=>ck,
		rst=>reset,
	   D=>Wi_in,
		q=>Wi_in_sig
		
		);
		
	CUST_ADD: component custom_add
		port map(
		add_in=>W_addressAB_in,
		add_out=>add_custom_sig
		);
		
	RF: component register_file
	   port map(
		clk=>ck,
		rst=>reset,
		--write commands
		write_enAB=>W_enAB_in,
		write_addA=>W_addressAB_in,
		write_addB=>add_custom_sig, -- Uscita del custom add, va solo a incrementare di 1 l'add (è combinatorio)
		write_addWr=>W_addressWr_in,
		write_addWi=>W_addressWi_in_sig,
		write_enW=>W_enW_in,
		--data in
		write_dataA=>A_q_sig, -- Sono le uscite dei due registri di ingresso
		write_dataB=>b_q_sig,
		write_dataWr=>Wr_in_sig,
		write_dataWi=>Wi_in_sig,
		-- read commands
		read_enAB=>R_enAB_in,
		read_enW=>R_enW_in,
		read_addA=>R_addressA_in,
		read_addB=>R_addressB_in,
		read_addW=>R_addressW_in,
		-- data out
		out_A=>A_sig,
		out_B=>B_sig,
		out_W=>W_sig
		);
	
   RR: component rom
	   port map(
		address=>mux7_sig(25 downto 20),
		data=>rounder_out_sig
		);
		
		
	CUSTOM: component custom_block -- è come un selettore a due ingressi e a due uscite
		port map(
		sel=>sel_demux_out,
		d0=>q0shift_sig,
		d1=>q1shift_sig,
		d2=>q2shift_sig,
		q1=>q1_custom_sig,
		q2=>q2_custom_sig
		
		);
		
	SHIFT_REG: component shift_register
		port map(
		clk=>ck,
		rst=>reset,
		d(23 downto 1)=>mux7_sig(48 downto 26),
		d(0)=>rounder_out_sig,
		q0=>q0shift_sig,
		q1=>q1shift_sig,
		q2=>q2shift_sig,
		q3=>q3shift_sig -- questo è lasciato scollegato
		);

		
		W_addressWi_in_sig<= ( NOT(W_addressWr_in(0)) &  (W_addressWr_in(1))  & (W_addressWr_in(2))); 
																																    -- all'address di Wi, viene salvato contemporaneamente a Wr
	
	end structural;
			