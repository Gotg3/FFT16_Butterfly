-----------------------------
--PROGETTO FFT 16x16
--AMATO GIOVANNI LUCA Matr.267511
--CERBAI MATILDE Matr.274908 
--CHISCIOTTI LAURA Matr.274728
--GOTI GIANLUCA Matr.269825
-----------------------------
--------------------------------------------
-- Register File composed of 6 registers 
-- each one having 24 bits. Three read	  
-- ports and two write port.		 
-- 2 enable for Channels A & B 		  	  
-- 2 enable for Channel W 		
--------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is	
	generic( parallelism: integer:= 24);
	--generic( bit_add: integer:= 3); 
	port(
		clk: in std_logic;
		rst: in std_logic;
		--write commands
		write_enAB: in std_logic;
		write_addA: in std_logic_vector(2 downto 0); -- sdoppiamento ingressi per A e B
		write_addB: in std_logic_vector(2 downto 0);
		write_addWr: in std_logic_vector(2 downto 0); -- sdoppiamento ingressi W
		write_addWi: in std_logic_vector(2 downto 0);
		write_enW: in std_logic;
		--data in
		write_dataA: in signed(parallelism-1 downto 0); -- sdoppiamento ingressi per A e B
		write_dataB: in signed(parallelism-1 downto 0);
		write_dataWr: in signed(parallelism-1 downto 0); -- sdoppiamento ingressi W
		write_dataWi: in signed(parallelism-1 downto 0);
		-- read commands
		--read_enA: in std_logic;
		--read_enB: in std_logic;
		--read_enW: in std_logic;
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
end register_file;

architecture behavioural of register_file is
	type regs is array ( 0 to 5) of signed(parallelism -1 downto 0);
	signal registers: regs; -- crea un signal (array) di appoggio per fare tutte le operaziono
--il nostro register file é tutto sincrono
	begin
	reg_proc: process(clk)
	begin
		if(clk'event and clk = '1') then
		--reset routine
			if(rst='1') then 
				for i in 0 to 5 loop
					registers(i)<=(others=>'0');
					out_W<=(others=>'0');
					out_A<=(others=>'0');
					out_B<=(others=>'0');
				end loop;
			else
		
		--read A&B routine with bypass
		--se si cerca di scrivere nello stesso registro in cui si vuole leggere
		--metti in uscita il dato che si sta scrivendo
				if (read_enAB = '1') then

					--Channel B bypass
					if((read_addB = write_addB) and ( write_enAB = '1')) then
						out_B<=write_dataB;
					else
						out_B<=registers(to_integer(unsigned(read_addB)));
					end if;					

					--Channel A bypass
					if((read_addA = write_addA) and ( write_enAB = '1')) then
						out_A<=write_dataA;
					else
						out_A<=registers(to_integer(unsigned(read_addA)));
					end if;
					
				
					
				else
				-- se l'enable non é attivo metti a 0 la linea se non é attivo l'enable non fai niente
					--out_A<=(others=>'0');
					--out_B<=(others=>'0');
				end if;
			--read Wr and Wi routine 
				if (read_enW = '1') then
						--Channel W bypass
					--if((read_addW = write_addW) and ( write_enW = '1')) then
					--	out_W<=write_dataW;
					--else
						out_W<=registers(to_integer(unsigned(read_addW)));
					--end if;
				else
					out_W<=(others=>'0');
				end if;
						
		--write routine 
			--write A&B
				if (write_enAB = '1') then
					registers(to_integer(unsigned(write_addA))) <= write_dataA; --fa un casting del write addr da uns a integer
					registers(to_integer(unsigned(write_addB))) <= write_dataB;
				end if;
			--write W
				if (write_enW = '1') then
					registers(to_integer(unsigned(write_addWr))) <= write_dataWr; --fa un casting del write addr da uns a integer
					registers(to_integer(unsigned(write_addWi))) <= write_dataWi; --fa un casting del write addr da uns a integer
				
				end if;
				end if;
			end if;
	end process reg_proc;
end behavioural;
				
				
				
		
		
		
		
	
		