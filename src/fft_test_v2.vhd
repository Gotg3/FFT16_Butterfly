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

entity fft_test is
end fft_test;

architecture dut of fft_test is
	
	signal str_sig:  std_logic;
	signal rst_sig:  std_logic;
	signal clk_sig:  std_logic:='0';
	--x in
	signal xin_0_sig:  signed ( 23 downto 0);
	signal xin_1_sig:  signed ( 23 downto 0);
	signal xin_2_sig:  signed ( 23 downto 0);
	signal xin_3_sig:  signed ( 23 downto 0);
	signal xin_4_sig:  signed ( 23 downto 0);
	signal xin_5_sig:  signed ( 23 downto 0);
	signal xin_6_sig:  signed ( 23 downto 0);
	signal xin_7_sig:  signed ( 23 downto 0);
	signal xin_8_sig:  signed ( 23 downto 0);
	signal xin_9_sig:  signed ( 23 downto 0);
	signal xin_10_sig:  signed ( 23 downto 0);
	signal xin_11_sig:  signed ( 23 downto 0);
	signal xin_12_sig:  signed ( 23 downto 0);
	signal xin_13_sig:  signed ( 23 downto 0);
	signal xin_14_sig:  signed ( 23 downto 0);
	signal xin_15_sig:  signed ( 23 downto 0);
	-- X out
	signal xout_0_sig:  signed(23 downto 0);
	signal xout_1_sig:  signed(23 downto 0);
	signal xout_2_sig:  signed(23 downto 0);
	signal xout_3_sig:  signed(23 downto 0);
	signal xout_4_sig:  signed(23 downto 0);
	signal xout_5_sig:  signed(23 downto 0);
	signal xout_6_sig:  signed(23 downto 0);
	signal xout_7_sig:  signed(23 downto 0);
	signal xout_8_sig:  signed(23 downto 0);
	signal xout_9_sig:  signed(23 downto 0);
	signal xout_10_sig: signed(23 downto 0);
	signal xout_11_sig: signed(23 downto 0);
	signal xout_12_sig: signed(23 downto 0);
	signal xout_13_sig: signed(23 downto 0);
	signal xout_14_sig: signed(23 downto 0);
	signal xout_15_sig: signed(23 downto 0);
	--done
	signal done_sig: std_logic;
	
	component FFT
		port(
		clk, reset, start : in std_logic;
		X_in: in input ;
		X_out: out input ;
		done: out std_logic 
		);		
	end component;
	
	begin
	
	fft16x16: FFT
	port map(
	clk=>clk_sig,
	reset=>rst_sig,
	start=>str_sig,
	--x in connections
	X_in(0)=>xin_0_sig,
	X_in(1)=>xin_1_sig,
	X_in(2)=>xin_2_sig,
	X_in(3)=>xin_3_sig,
	X_in(4)=>xin_4_sig,
	X_in(5)=>xin_5_sig,
	X_in(6)=>xin_6_sig,
	X_in(7)=>xin_7_sig,
	X_in(8)=>xin_8_sig,
	X_in(9)=>xin_9_sig,
	X_in(10)=>xin_10_sig,
	X_in(11)=>xin_11_sig,
	X_in(12)=>xin_12_sig,
	X_in(13)=>xin_13_sig,
	X_in(14)=>xin_14_sig,
	X_in(15)=>xin_15_sig,
	--X out connections
	X_out(0)=>xout_0_sig,
	X_out(1)=>xout_1_sig,
	X_out(2)=>xout_2_sig,
	X_out(3)=>xout_3_sig,
	X_out(4)=>xout_4_sig,
	X_out(5)=>xout_5_sig,
	X_out(6)=>xout_6_sig,
	X_out(7)=>xout_7_sig,
	X_out(8)=>xout_8_sig,
	X_out(9)=>xout_9_sig,
	X_out(10)=>xout_10_sig,
	X_out(11)=>xout_11_sig,
	X_out(12)=>xout_12_sig,
	X_out(13)=>xout_13_sig,
	X_out(14)=>xout_14_sig,
	X_out(15)=>xout_15_sig,
	-- done connection
	done=>done_sig
	);
	
	clk_sig <= not(clk_sig) after 20 ns;--periodo 40 ns
	
	stimuli: process
	begin
	--input inizialization, all zeros
	xin_0_sig<=(others=>'0');
	xin_1_sig<=(others=>'0');
	xin_2_sig<=(others=>'0');
	xin_3_sig<=(others=>'0');
	xin_4_sig<=(others=>'0');
	xin_5_sig<=(others=>'0');
	xin_6_sig<=(others=>'0');
	xin_7_sig<=(others=>'0');
	xin_8_sig<=(others=>'0');
	xin_9_sig<=(others=>'0');
	xin_10_sig<=(others=>'0');
	xin_11_sig<=(others=>'0');
	xin_12_sig<=(others=>'0');
	xin_13_sig<=(others=>'0');
	xin_14_sig<=(others=>'0');
	xin_15_sig<=(others=>'0');
	
	rst_sig<='1';
	str_sig<='0';
	wait for 20 ns;
	str_sig<='1';
	rst_sig<='0';
	wait for 40 ns;
	str_sig<='0';
	
-- TEST 1: DELTA DI DIRAC "1" x0=1, trasformata costante a 1
--TEST COMPLETATO
	--xin_0_sig<="000000010100011110101110"; --0.01 (83886 Scale Factor) test con una delta di dirac NB la dinamica deve essere <1/32
	--wait for 40 ns;
	--xin_0_sig<=(others=>'0');

-- TEST 2: DELTA DI DIRAC "0.75" x9=0,75, trasformata costante a 0,75 (il numero scelto è 0,0075 per rientrare nella dinamica, con lo scale factor si arriva a 62914,56, approssimato a 62915)
--TEST COMPLETATO	
	--xin_8_sig<="000000001111010111000011";
	--wait for 40 ns;
	--xin_8_sig<=(others=>'0');

--TEST 3: SEGNALE COSTANTE "-1", come per il primo test si prende il numero (cambiato di segno) -83886
-- Il protocollo di ingresso "a due a due" permette di inserire i dati reali contemporaneamente ( stessa cosa per gli immaginari)
--TEST COMPLETATO
	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<="111111101011100001010010";
	--xin_2_sig<="111111101011100001010010";
	--xin_3_sig<="111111101011100001010010"; -- mettendo 000000000010000011000000 (0.001) torna (prova 1)
	--xin_4_sig<="111111101011100001010010"; -- mettendo 000000010100011110101110 (0.01)  torna (prova 2)
	--xin_5_sig<="111111101011100001010010"; -- mettendo 111111101011100001010010 (-0.01) 
	--xin_6_sig<="111111101011100001010010";
	--xin_7_sig<="111111101011100001010010";
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<="111111101011100001010010";
	--xin_10_sig<="111111101011100001010010";
	--xin_11_sig<="111111101011100001010010";
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<="111111101011100001010010";
	--xin_14_sig<="111111101011100001010010";
	--xin_15_sig<="111111101011100001010010";

-- TEST 4: SEGNALE SINUSOUIDALE "1" e "-1" come per gli altri due
--TEST COMPLETATO
	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<="000000010100011110101110";
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<="111111101011100001010010";
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<="000000010100011110101110";
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<="000000010100011110101110";
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<="000000010100011110101110";
	--xin_15_sig<=(others=>'0');

-- TEST 5 : SEGNALE ONDA QUADRA "1" e "-1" come per gli altri due
--TEST COMPLETATO
	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<="111111101011100001010010";
	--xin_2_sig<="000000010100011110101110";
	--xin_3_sig<="000000010100011110101110";
	--xin_4_sig<="111111101011100001010010";
	--xin_5_sig<="111111101011100001010010";
	--xin_6_sig<="000000010100011110101110";
	--xin_7_sig<="000000010100011110101110";
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<="111111101011100001010010";
	--xin_10_sig<="000000010100011110101110";
	--xin_11_sig<="000000010100011110101110";
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<="111111101011100001010010";
	--xin_14_sig<="000000010100011110101110";
	--xin_15_sig<="000000010100011110101110";

--  TEST 6: SEGNALE DELTA DI DIRAC "FULL SPEED"
	--TEST COMPLETATO
	xin_0_sig<="000000010100011110101110"; --0.01 (83886 Scale Factor) test con una delta di dirac NB la dinamica deve essere <1/32
	wait for 40 ns;
	xin_0_sig<=(others=>'0');
	xin_1_sig<=(others=>'0');
	xin_2_sig<=(others=>'0');
	xin_3_sig<=(others=>'0');
	xin_4_sig<=(others=>'0');
	xin_5_sig<=(others=>'0');
	xin_6_sig<=(others=>'0');
	xin_7_sig<=(others=>'0');
	xin_8_sig<=(others=>'0');
	xin_9_sig<=(others=>'0');
	xin_10_sig<=(others=>'0');
	xin_11_sig<=(others=>'0');
	xin_12_sig<=(others=>'0');
	xin_13_sig<=(others=>'0');
	xin_14_sig<=(others=>'0');
	xin_15_sig<=(others=>'0');

	wait for 480 ns;
	str_sig<='1';
	wait for 40 ns;
	str_sig<='0';
	xin_0_sig<="000000010100011110101110";

	wait for 40 ns;
	xin_0_sig<=(others=>'0');
	xin_1_sig<=(others=>'0');
	xin_2_sig<=(others=>'0');
	xin_3_sig<=(others=>'0');
	xin_4_sig<=(others=>'0');
	xin_5_sig<=(others=>'0');
	xin_6_sig<=(others=>'0');
	xin_7_sig<=(others=>'0');
	xin_8_sig<=(others=>'0');
	xin_9_sig<=(others=>'0');
	xin_10_sig<=(others=>'0');
	xin_11_sig<=(others=>'0');
	xin_12_sig<=(others=>'0');
	xin_13_sig<=(others=>'0');
	xin_14_sig<=(others=>'0');
	xin_15_sig<=(others=>'0');

	wait for 480 ns;
	str_sig<='1';
	wait for 40 ns;
	str_sig<='0';
	xin_0_sig<="000000010100011110101110";


-- TEST 7 SINUSOIDE "FULL SPEED"
-- TEST COMPLETATO
	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<="000000010100011110101110";
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<="111111101011100001010010";
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<="000000010100011110101110";
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<="000000010100011110101110";
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<="000000010100011110101110";
	--xin_15_sig<=(others=>'0');


	--wait for 40 ns;
	--xin_0_sig<=(others=>'0');
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<=(others=>'0');
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<=(others=>'0');
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<=(others=>'0');
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<=(others=>'0');
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<=(others=>'0');
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<=(others=>'0');
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<=(others=>'0');
	--xin_15_sig<=(others=>'0');

	--wait for 480 ns;
	--str_sig<='1';
	--wait for 40 ns;
	--str_sig<='0';
	--
	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<="000000010100011110101110";
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<="111111101011100001010010";
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<="000000010100011110101110";
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<="000000010100011110101110";
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<="000000010100011110101110";
	--xin_15_sig<=(others=>'0');

	--wait for 40 ns;
	--xin_0_sig<=(others=>'0');
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<=(others=>'0');
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<=(others=>'0');
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<=(others=>'0');
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<=(others=>'0');
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<=(others=>'0');
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<=(others=>'0');
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<=(others=>'0');
	--xin_15_sig<=(others=>'0');

	--wait for 480 ns;
	--str_sig<='1';
	--wait for 40 ns;
	--str_sig<='0';
	
	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<="000000010100011110101110";
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<="111111101011100001010010";
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<="000000010100011110101110";
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<="000000010100011110101110";
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<="000000010100011110101110";
	--xin_15_sig<=(others=>'0');


-- TEST 8 SEGNALE COSTANTE (-1)
-- TEST COMPLETATO
	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<="111111101011100001010010";
	--xin_2_sig<="111111101011100001010010";
	--xin_3_sig<="111111101011100001010010"; 
	--xin_4_sig<="111111101011100001010010"; 
	--xin_5_sig<="111111101011100001010010";  
	--xin_6_sig<="111111101011100001010010";
	--xin_7_sig<="111111101011100001010010";
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<="111111101011100001010010";
	--xin_10_sig<="111111101011100001010010";
	--xin_11_sig<="111111101011100001010010";
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<="111111101011100001010010";
	--xin_14_sig<="111111101011100001010010";
	--xin_15_sig<="111111101011100001010010";

--
	--wait for 40 ns;
	--xin_0_sig<=(others=>'0');
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<=(others=>'0');
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<=(others=>'0');
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<=(others=>'0');
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<=(others=>'0');
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<=(others=>'0');
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<=(others=>'0');
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<=(others=>'0');
	--xin_15_sig<=(others=>'0');

	--wait for 480 ns;
	--str_sig<='1';
	--wait for 40 ns;
	--str_sig<='0';
--
	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<="111111101011100001010010";
	--xin_2_sig<="111111101011100001010010";
	--xin_3_sig<="111111101011100001010010"; 
	--xin_4_sig<="111111101011100001010010"; 
	--xin_5_sig<="111111101011100001010010";  
	--xin_6_sig<="111111101011100001010010";
	--xin_7_sig<="111111101011100001010010";
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<="111111101011100001010010";
	--xin_10_sig<="111111101011100001010010";
	--xin_11_sig<="111111101011100001010010";
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<="111111101011100001010010";
	--xin_14_sig<="111111101011100001010010";
	--xin_15_sig<="111111101011100001010010";

	--wait for 40 ns;
	--xin_0_sig<=(others=>'0');
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<=(others=>'0');
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<=(others=>'0');
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<=(others=>'0');
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<=(others=>'0');
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<=(others=>'0');
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<=(others=>'0');
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<=(others=>'0');
	--xin_15_sig<=(others=>'0');

	--wait for 480 ns;
	--str_sig<='1';
	--wait for 40 ns;
	--str_sig<='0';

	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<="111111101011100001010010";
	--xin_2_sig<="111111101011100001010010";
	--xin_3_sig<="111111101011100001010010"; 
	--xin_4_sig<="111111101011100001010010"; 
	--xin_5_sig<="111111101011100001010010";  
	--xin_6_sig<="111111101011100001010010";
	--xin_7_sig<="111111101011100001010010";
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<="111111101011100001010010";
	--xin_10_sig<="111111101011100001010010";
	--xin_11_sig<="111111101011100001010010";
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<="111111101011100001010010";
	--xin_14_sig<="111111101011100001010010";
	--xin_15_sig<="111111101011100001010010";

--TEST 9 ONDA QUADRA "FULL SPEED"
--TEST COMPLETATO
	--xin_0_sig<="111111101011100001010010";
--	xin_1_sig<="111111101011100001010010";
	--xin_2_sig<="000000010100011110101110";
	--xin_3_sig<="000000010100011110101110";
	--xin_4_sig<="111111101011100001010010";
	--xin_5_sig<="111111101011100001010010";
	--xin_6_sig<="000000010100011110101110";
	--xin_7_sig<="000000010100011110101110";
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<="111111101011100001010010";
	--xin_10_sig<="000000010100011110101110";
	--xin_11_sig<="000000010100011110101110";
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<="111111101011100001010010";
	--xin_14_sig<="000000010100011110101110";
	--xin_15_sig<="000000010100011110101110";
--
	--wait for 40 ns;
	--xin_0_sig<=(others=>'0');
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<=(others=>'0');
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<=(others=>'0');
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<=(others=>'0');
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<=(others=>'0');
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<=(others=>'0');
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<=(others=>'0');
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<=(others=>'0');
	--xin_15_sig<=(others=>'0');

	--wait for 480 ns;
	--str_sig<='1';
	--wait for 40 ns;
	--str_sig<='0';
--
	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<="111111101011100001010010";
	--xin_2_sig<="000000010100011110101110";
	--xin_3_sig<="000000010100011110101110";
	--xin_4_sig<="111111101011100001010010";
	--xin_5_sig<="111111101011100001010010";
	--xin_6_sig<="000000010100011110101110";
	--xin_7_sig<="000000010100011110101110";
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<="111111101011100001010010";
	--xin_10_sig<="000000010100011110101110";
	--xin_11_sig<="000000010100011110101110";
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<="111111101011100001010010";
	--xin_14_sig<="000000010100011110101110";
	--xin_15_sig<="000000010100011110101110";


	--wait for 40 ns;
	--xin_0_sig<=(others=>'0');
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<=(others=>'0');
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<=(others=>'0');
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<=(others=>'0');
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<=(others=>'0');
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<=(others=>'0');
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<=(others=>'0');
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<=(others=>'0');
	--xin_15_sig<=(others=>'0');
--
	--wait for 480 ns;
	--str_sig<='1';
	--wait for 40 ns;
	--str_sig<='0';

	--xin_0_sig<="111111101011100001010010";
	--xin_1_sig<="111111101011100001010010";
	--xin_2_sig<="000000010100011110101110";
	--xin_3_sig<="000000010100011110101110";
	--xin_4_sig<="111111101011100001010010";
	--xin_5_sig<="111111101011100001010010";
	--xin_6_sig<="000000010100011110101110";
	--xin_7_sig<="000000010100011110101110";
	--xin_8_sig<="111111101011100001010010";
	--xin_9_sig<="111111101011100001010010";
	--xin_10_sig<="000000010100011110101110";
	--xin_11_sig<="000000010100011110101110";
	--xin_12_sig<="111111101011100001010010";
	--xin_13_sig<="111111101011100001010010";
	--xin_14_sig<="000000010100011110101110";
	--xin_15_sig<="000000010100011110101110";

-- TEST 10 DELTA 0.75 XIN9
-- TEST COMPLETATO
	--xin_8_sig<="000000001111010111000011";

--	wait for 40 ns;
	--xin_0_sig<=(others=>'0');
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<=(others=>'0');
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<=(others=>'0');
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<=(others=>'0');
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<=(others=>'0');
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<=(others=>'0');
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<=(others=>'0');
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<=(others=>'0');
	--xin_15_sig<=(others=>'0');

	--wait for 480 ns;
	--str_sig<='1';
	--wait for 40 ns;
	--str_sig<='0';
	--xin_8_sig<="000000001111010111000011";
--
	--wait for 40 ns;
	--xin_0_sig<=(others=>'0');
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<=(others=>'0');
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<=(others=>'0');
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<=(others=>'0');
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<=(others=>'0');
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<=(others=>'0');
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<=(others=>'0');
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<=(others=>'0');
	--xin_15_sig<=(others=>'0');

	--wait for 480 ns;
	--str_sig<='1';
	--wait for 40 ns;
	--str_sig<='0';
	--xin_8_sig<="000000001111010111000011";

-- TEST 11 ONDA QUADRA +0.5 -0.5
-- si è scelto 0.05 convertito con 2^23-> 41943

	--xin_0_sig<="000000001010001111010111";
	--xin_1_sig<="000000001010001111010111";
	--xin_2_sig<="000000001010001111010111";
	--xin_3_sig<="000000001010001111010111";
	--xin_4_sig<="000000001010001111010111";
	--xin_5_sig<="000000001010001111010111";
	--xin_6_sig<="000000001010001111010111";
	--xin_7_sig<="000000001010001111010111";
	--xin_8_sig<="000000001010001111010111";
	--xin_9_sig<="111111110101110000101001";
	--xin_10_sig<="111111110101110000101001";
	--xin_11_sig<="111111110101110000101001";
	--xin_12_sig<="111111110101110000101001";
	--xin_13_sig<="111111110101110000101001";
	--xin_14_sig<="111111110101110000101001";
	--xin_15_sig<="111111110101110000101001";

	
	--wait for 40 ns;
	--xin_0_sig<=(others=>'0');
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<=(others=>'0');
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<=(others=>'0');
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<=(others=>'0');
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<=(others=>'0');
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<=(others=>'0');
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<=(others=>'0');
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<=(others=>'0');
	--xin_15_sig<=(others=>'0');
	
	--wait for 480 ns;
	--str_sig<='1';
	--wait for 40 ns;
	--str_sig<='0';

	--xin_0_sig<="000000001010001111010111";
	--xin_1_sig<="000000001010001111010111";
	--xin_2_sig<="000000001010001111010111";
	--xin_3_sig<="000000001010001111010111";
	--xin_4_sig<="000000001010001111010111";
	--xin_5_sig<="000000001010001111010111";
	--xin_6_sig<="000000001010001111010111";
	--xin_7_sig<="000000001010001111010111";
	--xin_8_sig<="000000001010001111010111";
	--xin_9_sig<="111111110101110000101001";
	--xin_10_sig<="111111110101110000101001";
	--xin_11_sig<="111111110101110000101001";
	--xin_12_sig<="111111110101110000101001";
	--xin_13_sig<="111111110101110000101001";
	--xin_14_sig<="111111110101110000101001";
	--xin_15_sig<="111111110101110000101001";



	--wait for 40 ns;
	--xin_0_sig<=(others=>'0');
	--xin_1_sig<=(others=>'0');
	--xin_2_sig<=(others=>'0');
	--xin_3_sig<=(others=>'0');
	--xin_4_sig<=(others=>'0');
	--xin_5_sig<=(others=>'0');
	--xin_6_sig<=(others=>'0');
	--xin_7_sig<=(others=>'0');
	--xin_8_sig<=(others=>'0');
	--xin_9_sig<=(others=>'0');
	--xin_10_sig<=(others=>'0');
	--xin_11_sig<=(others=>'0');
	--xin_12_sig<=(others=>'0');
	--xin_13_sig<=(others=>'0');
	--xin_14_sig<=(others=>'0');
	--xin_15_sig<=(others=>'0');


	
	--wait for 480 ns; 13 colpi per altro start
	--str_sig<='1';
	--wait for 40 ns;
	--str_sig<='0';

	--xin_0_sig<="000000001010001111010111";
	--xin_1_sig<="000000001010001111010111";
	--xin_2_sig<="000000001010001111010111";
	--xin_3_sig<="000000001010001111010111";
	--xin_4_sig<="000000001010001111010111";
	--xin_5_sig<="000000001010001111010111";
	--xin_6_sig<="000000001010001111010111";
	--xin_7_sig<="000000001010001111010111";
	--xin_8_sig<="000000001010001111010111";
	--xin_9_sig<="111111110101110000101001";
	--xin_10_sig<="111111110101110000101001";
	--xin_11_sig<="111111110101110000101001";
	--xin_12_sig<="111111110101110000101001";
	--xin_13_sig<="111111110101110000101001";
	--xin_14_sig<="111111110101110000101001";
	--xin_15_sig<="111111110101110000101001";



	wait for 40 ns;
	xin_0_sig<=(others=>'0');
	xin_1_sig<=(others=>'0');
	xin_2_sig<=(others=>'0');
	xin_3_sig<=(others=>'0');
	xin_4_sig<=(others=>'0');
	xin_5_sig<=(others=>'0');
	xin_6_sig<=(others=>'0');
	xin_7_sig<=(others=>'0');
	xin_8_sig<=(others=>'0');
	xin_9_sig<=(others=>'0');
	xin_10_sig<=(others=>'0');
	xin_11_sig<=(others=>'0');
	xin_12_sig<=(others=>'0');
	xin_13_sig<=(others=>'0');
	xin_14_sig<=(others=>'0');
	xin_15_sig<=(others=>'0');


	wait;
	end process;
	
	
	end dut;
