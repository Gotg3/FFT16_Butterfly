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

entity control_unit is
generic(parallelism: integer:=4);
port(
clk: in std_logic;
rst: in std_logic;
status: in std_logic; --segnale di start 
dp_commands: out std_logic_vector(34 downto 0) --modificato per aggiungere il done (da 6 a 38)
															  --modificato 9-01-20 per aggiungere sel mux e demux
															  --modificato 31-01-20 per aggiungere sel custom e OE shift reg
															  -- è stato aggiunto un bit in più, lo lasciamo, per eventuali bisogni, si riutilizza OE5 per OE
);
end control_unit;

architecture structural of control_unit is

signal uAR_sig: std_logic_vector(parallelism-1 downto 0);
signal inc_sig: std_logic_vector(parallelism-1 downto 0);
signal outMux_sig: std_logic_vector(parallelism-1 downto 0);
signal sel_sig: std_logic;
signal uIR_sig: std_logic_vector(40 downto 0); --modificato per aggiungere il done
															  --modificato 9-01-19 per aggiungere sel mux e demux
															  --modificato 31-01-20 per aggiungere sel custom e OE shift reg

signal uRom_data_sig: std_logic_vector(40 downto 0); --modificato per aggiungere il done
signal rst_sig: std_logic:='0'; --i lreset del uIR è scollegato, lo mettiamo a 0 così non è mai attivo

	component uAR is
	generic ( parallelism: integer := 4 );
	port( clk, Rst: in std_logic;
			d: in std_logic_vector(parallelism-1 downto 0);
			q: out std_logic_vector(parallelism-1 downto 0)
			);
	end component;

	component incrementatore is
	generic(parallelism: integer:=4);
	port(
	data_in: in std_logic_vector(parallelism-1 downto 0);
	data_out: out std_logic_vector(parallelism-1 downto 0)
	);
	end component;

	component mux_1x2 is
	generic ( parallelism: integer := 4 );
	port(
	d1: in std_logic_vector(parallelism-1 downto 0);
	d2: in std_logic_vector(parallelism-1 downto 0):=(others=>'0');
	q: out std_logic_vector(parallelism-1 downto 0);
	sel: in std_logic:='1'
	);
	end component;
	
	component status_pla
	port(
	address: in std_logic_vector(2 downto 0);
	data: out std_logic --0 vai in sequenza & 1 salta
	);
	end component;
	
	component uIR
	generic ( parallelism: integer := 41 ); --modificato per aggiungere il segnale DONE

	port(
		clk, Rst: in std_logic;
		d: in std_logic_vector(parallelism-1 downto 0);
		q: out std_logic_vector(parallelism-1 downto 0)
	);
	end component;
	
	component uRom --ha 44 bit di campo
	port(
	address: in std_logic_vector(3 downto 0);
	data: out std_logic_vector(40 downto 0)
	);
	end component;
	
begin

	uARegister: uAR	
	port map(
		clk=>clk,
		Rst=>rst, 
		d=>outMux_sig,
		q=>uAR_sig
		);
		
	uIRegister: uIR
	port map(
		clk=>clk,
		Rst=>rst_sig,  -- IL RESET DEL uIR è SCOLLEGATO, è un filo che non va a niente, il reset del uAR provvede a tutto
		d=>uRom_data_sig,
		q=>uIR_sig
	);
		
	incr: incrementatore
	port map(
		data_in=>uAR_sig,
		data_out=>inc_sig
	);
	
	mux: mux_1x2
	port map(
		d1=>inc_sig,
		d2=> uIR_sig(38 downto 35),  --jmp address
		sel=> sel_sig,
		q=>outMux_sig
	);
		
		
	st_pla: status_pla
	port map(
		data=>sel_sig,
		address(2)=> uIR_sig(40), --cc MSB
		address(1)=> uIR_sig(39), --cc LSB
		address(0)=> status --str
		
	);
	
	ur: uRom --modificato 9-01-19 per aggiungere sel mux e demux 
	port map(
		address=>uAR_sig,
		data=>uRom_data_sig
	);
	
	--connessione comandi al datapath
	dp_commands<=uIR_sig(34 downto 0);	
	rst_sig<='0'; --metto il reset del uIR a 0
end structural;