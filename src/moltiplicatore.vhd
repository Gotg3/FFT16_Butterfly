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

entity moltiplicatore is
generic ( parallelism: integer := 24 );
port(
	ctr: in std_logic;
	m1: in signed( parallelism-1  downto 0);
	m2: in  signed( parallelism -1 downto 0); --é la porta a destra nel datapath, dove c'é il mux Mx
	AxB_comb: out signed(parallelism*2 downto 0); --la moltiplicazione rende in uscita 2*n bit
	x2: out signed(parallelism*2 downto 0) -- lo shift rende n+1 bit
	-- i dati in ingresso e in uscita sono sempre su std_logic_vector perché tanto sono una sequenza di bit,
	-- il comando "signed" fa interpretare quella sequenza dibit
	-- con una logica (in questo caso C2 con segno)
	--x2: out std_logic_vector(parallelism*2-1 downto 0)
	);
end moltiplicatore;

architecture behavioural of moltiplicatore is
--signal AxB_sig: std_logic_vector (parallelism-1 downto 0);
--signal x2_sig: std_logic_vector (parallelism-1 downto 0);
constant two: signed(parallelism-1 downto 0):="000000000000000000000010";
signal AxB_comb_sig: signed (parallelism*2 downto 0);
--signal due: std_logic_vector(parallelism*2 downto 0):="10";
--constant due: signed:="2";

begin
	multiplier_process: process(ctr,m1,m2) --ATTENZIONE va fatto resize per m2
	begin
		
			case ctr is --scegli AxB o x2
				when '0'=>	--AxB shift_left(resize(m1*m2,49),1)
							AxB_comb<=shift_left(resize(m1*m2,49),2);
					--AxB_comb<=signed(resize(signed(m2)*signed(m1),49)); --AxB length is m1 length + m2 length
					--AxB_comb_sig<=std_logic_vector(resize(signed(m2)*signed(m1),49)); --AxB length is m1 length + m2 length
					--AxB_comb<=std_logic_vector(signed(AxB_comb_sig)*signed(due));
					x2<=(others =>'0');
					--AxB<=shift_left(AxB_sig, 49); --divido per 2^49
				when others=> --x2
					x2<=shift_left(resize(m2*2,49),25); -- messo a due così abbiamo due bit di segno
					AxB_comb<=(others=>'0');
					--x2<=shift_left(x2_sig,49); --divido per 2^49
			end case;
		
	end process multiplier_process;
end behavioural;