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


entity shift_register is --parallel in serial out
generic (parallelism: integer :=24);
port(
	--se: in std_logic;
	--le: in std_logic;
	
	clk: in std_logic;
	d: in signed(23 downto 0); 
	q0: out signed(23 downto 0);
	q1: out signed(23 downto 0);
	q2: out signed(23 downto 0);
	q3: out signed(23 downto 0);
	rst: in std_logic
	);
end shift_register;

architecture behavioural of shift_register is

--signal tmp_sig, temp: std_logic_vector(parallelism-1 downto 0):="00000000";
type tmp_array is array (3 downto 0) of signed(23 downto 0);
type temp_array is array (3 downto 0) of signed(23 downto 0);

signal tmp: tmp_array:= (others=>(others=>'0'));
signal temp: temp_array:= (others=>(others=>'0'));
begin 

process(clk)

	begin
	
		if (clk' event and clk='1') then
		
			if (rst = '1') then
			
				for i in 0 to 3 loop
			
				tmp(i)<= (others=>'0');
				
				end loop;
			
		--	elsif (se = '1') then
				
				--tmp_sig <= D_out;
				
					
			else 
				
				for i in 0 to 2 loop  
					
					tmp(i+1) <= tmp(i);	
					
				end loop;
					
					tmp(0)<=d;  
			
			end if;

				--if (	oe='1') then
				
					--for i in 0 to 3 loop
						
							--temp(i)<=tmp(i);
					
							
					--end loop;
					
				--else 
							--for i in 0 to 3 loop
		
							--temp(i)<= (others => '0');
							--end loop;


				--end if;
				
		end if;
		
end process;



q0<=tmp(0);
q1<=tmp(1);
q2<=tmp(2);
q3<=tmp(3);

	
end behavioural;
				
					
			
			
			
			
			
			
			
			
			
			