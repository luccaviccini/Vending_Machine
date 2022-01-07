library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Máquina que vende água por 0.25 centavo 
-- Aceita 0.25, 0.1 e  0.05 centavo
-- As  entradas seriam moeda 25 cent, moeda10cent, moeda5cent.

entity Maquina_Vendas is 
	port(
		-- ENTRADAS
		Clk, Reset 			     		     : in std_logic;
		moeda5cent, moeda10cent, moeda25cent : in boolean;
		-- SAIDAS (agua + troco quando necessário)
		saida_agua, saida10cent,saida5cent   : out std_logic);

end Maquina_Vendas;

architecture mef of Maquina_Vendas is 

	type estado is (e0, e5, e10, e15, e20, e25, e30, e35, e40, e45);
	signal e_atual   : estado;
	signal e_proximo : estado;
	
	begin
		--- Processo para resetar o controlador
		process (Clk, Reset)
		begin	
			if(Reset = '1') then
				e_atual <= e0;			
			elsif (rising_edge(Clk)) then
				e_atual <= e_proximo;
			end if;	
		end process;
		
		--- processo para mudança de estados		
		process (e_atual, moeda5cent, moeda10cent, moeda25cent)
		begin 
			case e_atual is 			
			-- ESTADO 0 (IDLE)
				when e0 =>
					saida_agua <= '0';
					saida10cent <= '0';
					saida5cent <= '0';
					if   (moeda5cent)   then e_proximo <= e5;
					elsif(moeda10cent) 	then e_proximo <= e10;
					elsif(moeda25cent) 	then e_proximo <= e25;
					else e_proximo <= e0; -- se nada acontecer, permanece no mesmo estado
					end if;
					
				-- ESTADO 5 CENTAVOS	
				when e5 =>
					saida_agua <= '0';
					saida10cent <= '0';
					saida5cent <= '0';
					if   (moeda5cent)  	then e_proximo <= e10;
					elsif(moeda10cent) 	then e_proximo <= e15;
					elsif(moeda25cent) 	then e_proximo <= e30;
					else e_proximo <= e5;
					end if;					
					
				-- ESTADO 10 CENTAVOS	
				when e10 =>
					saida_agua <= '0';
					saida10cent <= '0';
					saida5cent <= '0';
					if   (moeda5cent)  	then e_proximo <= e15;
					elsif(moeda10cent) 	then e_proximo <= e20;
					elsif(moeda25cent) 	then e_proximo <= e35;
					else e_proximo <= e10;
					end if;						
		
				-- ESTADO 15 CENTAVOS	
				when e15 =>
					saida_agua <= '0';
					saida10cent <= '0';
					saida5cent <= '0';
					if   (moeda5cent)  	then e_proximo <= e20;
					elsif(moeda10cent) 	then e_proximo <= e25;
					elsif(moeda25cent) 	then e_proximo <= e40;
					else e_proximo <= e15;
					end if;			
		
				-- ESTADO 20 CENTAVOS	
				when e20 =>
					saida_agua <= '0';
					saida10cent <= '0';
					saida5cent <= '0';
					if   (moeda5cent)  	then e_proximo <= e25;
					elsif(moeda10cent) 	then e_proximo <= e30;
					elsif(moeda25cent) 	then e_proximo <= e45;
					else e_proximo <= e20;
					end if;	
					
				-- ESTADO 25 CENTAVOS	
				when e25 =>
					saida_agua <= '1';
					saida10cent <= '0';
					saida5cent <= '0';
					e_proximo <= e0;
					
				-- ESTADO 30 CENTAVOS	
				when e30 =>
					saida_agua <= '1';
					saida10cent <= '0';
					saida5cent <= '1';
					e_proximo <= e0;

				-- ESTADO 35 CENTAVOS	
				when e35 =>
					saida_agua <= '1';
					saida10cent <= '1';
					saida5cent <= '0';
					e_proximo <= e0;	

				-- ESTADO 40 CENTAVOS	
				when e40 =>
					saida_agua <= '0';
					saida10cent <= '0';
					saida5cent <= '1';
					e_proximo <= e35;	

				-- ESTADO 45 CENTAVOS	
				when e45 =>
					saida_agua <= '0';
					saida10cent <= '1';
					saida5cent <= '0';
					e_proximo <= e35;					
										
			end case;
		end process;	
end mef;
