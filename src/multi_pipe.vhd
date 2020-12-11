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

entity multi_pipe is
	generic ( parallelism: integer := 24 );
	port(
		clk: in std_logic;
		rst: in std_logic;
		ctr: in std_logic;
		m1: in signed( parallelism -1 downto 0);
		m2: in  signed( parallelism -1 downto 0); --é la porta a destra nel datapath, dove c'é il mux Mx
		AxB: out signed(parallelism*2  downto 0); --la moltiplicazione rende in uscita 2*n bit
		x2: out signed(parallelism*2 downto 0) -- lo shift rende n+1 bit, ma moltiplicando *2 redne 49 it
		);
end multi_pipe;

architecture structural of multi_pipe is
	signal AxB_sig: signed(parallelism*2 downto 0);
	signal pipe_sig: signed(parallelism*2 downto 0);

	component moltiplicatore is 
	generic ( parallelism: integer := 24 );
		port(
		
			ctr: in std_logic;
			m1: in signed( parallelism -1 downto 0);
			m2: in  signed( parallelism -1 downto 0); -- é la porta a destra nel datapath, dove c'é il mux Mx
			AxB_comb: out signed(parallelism*2 downto 0); --la moltiplicazione rende in uscita 2*n bit
			x2: out signed(parallelism*2 downto 0) -- lo shift rende n+1 bit, ma moltiplicando *2 redne 49 it
			);
	end component;
	
	component flipflop_m is
		port(	
				clk, Rst: in std_logic;
				D: in  signed(parallelism*2  downto 0);
				q: out  signed(parallelism*2  downto 0)
			);
		end component;
		
	begin
	
	multi: moltiplicatore
		port map(
			ctr=> ctr,
			m1=>m1,
			m2=>m2,
			AxB_comb=>AxB_sig,
			x2=>x2
		);
		
	pipe1: flipflop_m
		port map(
			clk=>clk,
			Rst=>rst,
			d=>AxB_sig,
			q=>pipe_sig
		);
		
	pipe2: flipflop_m
		port map(
			clk=>clk,
			Rst=>rst,
			d=>pipe_sig,
			q=>AxB
		);
		
end structural;

	