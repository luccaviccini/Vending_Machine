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
		produto								 : in std_logic_vector(1 downto 0); --- a maquina possui 2 produtos, um que custa 25 e outro que custa 30 centavos.
		-- SAIDAS (agua + troco quando necessário)
		saida_agua, saida_refri, saida25cent, saida10cent, saida5cent : out std_logic);

end Maquina_Vendas;

architecture mef of Maquina_Vendas is 
0
	type estado is (e0, e5, e10, e15, e20, e25, e30, e35, e40, e45, e50);
	signal e_atual, e_proximo  : estado;	
	signal qtd_moeda5cent, qtd_moeda10cent, qtd_moeda25cent  : integer := 10; -- a maquina só tem capacidade para 20 moedas de cada valor.
	signal valor_depositado : integer := 0;
	signal preco 			: integer := 0;
	
	begin
	-- declarando a instancia da ROM
	rom1: entity work.rom_precos(rom_arq)
	port map(
			 Clk => Clk,
			 produto => produto,
			 preco => preco);
	
	
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
		process (produto, e_atual, moeda5cent, moeda10cent, moeda25cent)
		begin 
			
			case e_atual is 			
			-- ESTADO 0 (IDLE)
				when e0 =>
					-- nao precisa checar para dar ok na saída.
					saida_agua <= '0';
					saida_refri <= '0';

					if   (moeda5cent)   then e_proximo <= e5; valor_depositado <= valor_depositado + 5; 	qtd_moeda5cent <= qtd_moeda5cent + 1;
					elsif(moeda10cent) 	then e_proximo <= e10;  qtd_moeda10cent <= qtd_moeda10cent + 1;
					elsif(moeda25cent) 	then e_proximo <= e25;  qtd_moeda25cent <= qtd_moeda25cent + 1;
					else e_proximo <= e0; -- se nada acontecer, permanece no mesmo estado
					end if;
					
				-- ESTADO 5 CENTAVOS	
				when e5 =>
					
					saida_agua <= '0';
					saida_refri <= '0';
					
					saida25cent <= '0';
					saida10cent <= '0';
					saida5cent <= '0';
					if   (moeda5cent)  	then e_proximo <= e10;  qtd_moeda5cent <= qtd_moeda5cent + 1;
					elsif(moeda10cent) 	then e_proximo <= e15;  qtd_moeda10cent <= qtd_moeda10cent + 1;
					elsif(moeda25cent) 	then e_proximo <= e30;  qtd_moeda25cent <= qtd_moeda25cent + 1;
					else e_proximo <= e5;
					end if;					
					
				-- ESTADO 10 CENTAVOS	
				when e10 =>
					
					saida_agua <= '0';
					saida_refri <= '0';
					saida25cent <= '0';
					saida10cent <= '0';
					saida5cent <= '0';
					if   (moeda5cent)  	then e_proximo <= e15; qtd_moeda5cent <= qtd_moeda5cent + 1;
					elsif(moeda10cent) 	then e_proximo <= e20; qtd_moeda10cent <= qtd_moeda10cent + 1;
					elsif(moeda25cent) 	then e_proximo <= e35; qtd_moeda25cent <= qtd_moeda25cent + 1;
					else e_proximo <= e10;
					end if;						
		
				-- ESTADO 15 CENTAVOS	
				when e15 =>

					saida_agua <= '0';
					saida_refri <= '0';
					saida25cent <= '0';
					saida10cent <= '0';
					saida5cent <= '0';
					if   (moeda5cent)  	then e_proximo <= e20; qtd_moeda5cent <= qtd_moeda5cent + 1;
					elsif(moeda10cent) 	then e_proximo <= e25; qtd_moeda10cent <= qtd_moeda10cent + 1;
					elsif(moeda25cent) 	then e_proximo <= e40; qtd_moeda25cent <= qtd_moeda25cent + 1;
					else e_proximo <= e15;
					end if;			
		
				-- ESTADO 20 CENTAVOS	
				when e20 =>
					
					saida_agua <= '0';
					saida_refri <= '0';
					saida25cent <= '0';
					saida10cent <= '0';
					saida5cent <= '0';
					if   (moeda5cent)  	then e_proximo <= e25; qtd_moeda5cent <= qtd_moeda5cent + 1;
					elsif(moeda10cent) 	then e_proximo <= e30; qtd_moeda10cent <= qtd_moeda10cent + 1;
					elsif(moeda25cent) 	then e_proximo <= e45; qtd_moeda25cent <= qtd_moeda25cent + 1;
					else e_proximo <= e20;
					end if;	
					
				-- ESTADO 25 CENTAVOS	
				when e25 =>
				

					if (produto = 25) then
						saida_agua <= '1';
						saida_refri <= '0';
						saida25cent <= '0';
						saida10cent <= '0';
						saida5cent <= '0';
						e_proximo <= e0;
					else	
						if   (moeda5cent)  	then e_proximo <= e30; qtd_moeda5cent <= qtd_moeda5cent + 1;
						elsif(moeda10cent) 	then e_proximo <= e35; qtd_moeda10cent <= qtd_moeda10cent + 1;					
						elsif(moeda25cent) 	then e_proximo <= e50; qtd_moeda25cent <= qtd_moeda25cent + 1;
						else e_proximo <= e50;
						end if;
					end if;
					
				-- ESTADO 30 CENTAVOS	
				when e30 =>
				
					
					if (produto = 30) then -- coca
						saida_agua <= '0';
						saida_refri <= '1';
						saida25cent <= '0';
						saida10cent <= '0';
						saida5cent <= '0';
						e_proximo <= e0;
					else -- agua
						saida_agua  <= '1';
						saida_refri <= '0';
						saida25cent <= '0';
						saida10cent <= '0';
						if (qtd_moeda5cent > 0) then
							saida5cent  <= '1'; qtd_moeda5cent <= qtd_moeda5cent - 1; -- nao tem opcao 
							e_proximo <= e0;
						else	
							e_proximo <= e0;
						end if;	
					end if;
				-- ESTADO 35 CENTAVOS	
				when e35 =>
				
					if(produto = 25) then -- troco de 10  -> 2 possibilidades											
						saida25cent <= '0';
						if (qtd_moeda10cent > 0) then 
							saida10cent <= '1'; qtd_moeda10cent <= qtd_moeda10cent - 1;
							saida_agua  <= '1';
							e_proximo <= e0;
						elsif (qtd_moeda5cent > 0)	then
							saida5cent  <= '1'; qtd_moeda5cent <= qtd_moeda5cent - 1;
							e_proximo <= e30;	
						else
							e_proximo <= e0; -- nao retorna as moedas.
						end if;
					else -- troco de 5
						saida25cent <= '0';
						
						if (qtd_moeda5cent > 0)	then
							saida_refri <= '1';
							saida5cent  <= '1'; qtd_moeda5cent <= qtd_moeda5cent - 1;
							e_proximo <= e0;	
						else
							saida_refri <= '1';
							e_proximo <= e0; -- nao retorna as moedas.
						end if;													
					end if;	
					
				-- ESTADO 40 CENTAVOS	
				when e40 =>
					
					
					if(produto = 25) then -- troco de 10  -> 2 possibilidades											
						saida25cent <= '0';
						if (qtd_moeda10cent > 0) then 
							saida10cent <= '1'; qtd_moeda10cent <= qtd_moeda10cent - 1;
							e_proximo <= e30;
						elsif (qtd_moeda5cent > 0)	then
							saida5cent  <= '1'; qtd_moeda5cent <= qtd_moeda5cent - 1;
							e_proximo <= e35;	
						else
							e_proximo <= e0; -- nao retorna as moedas.
						end if;
					else-- se for refri 
						saida25cent <= '0';
						if (qtd_moeda10cent > 0) then 
							saida10cent <= '1'; qtd_moeda10cent <= qtd_moeda10cent - 1;
							e_proximo <= e30;
						elsif (qtd_moeda5cent > 0) then 
								saida5cent  <= '1'; qtd_moeda5cent <= qtd_moeda5cent - 1;
								e_proximo <= e35;
						else
							saida_refri <= '1';
							e_proximo <= e0; -- nao retorna as moedas.		
						end if;
					end if;	

				-- ESTADO 45 CENTAVOS	
				when e45 =>
					if(produto = 25) then -- troco de 10  -> 2 possibilidades											
						saida25cent <= '0';
						if (qtd_moeda10cent > 0) then 
							saida10cent <= '1'; qtd_moeda10cent <= qtd_moeda10cent - 1;
							e_proximo <= e35;
						elsif (qtd_moeda5cent > 0)	then
							saida5cent  <= '1'; qtd_moeda5cent <= qtd_moeda5cent - 1;
							e_proximo <= e40;	
						else
							saida_agua <= '1';
							e_proximo <= e0; -- nao retorna as moedas.
						end if;
					else -- se for refri 
						saida25cent <= '0';
						if (qtd_moeda10cent > 0) then 
							saida10cent <= '1'; qtd_moeda10cent <= qtd_moeda10cent - 1;
							e_proximo <= e35;
						elsif (qtd_moeda5cent > 0) then 
								saida5cent  <= '1'; qtd_moeda5cent <= qtd_moeda5cent - 1;
								e_proximo <= e40;
						else
							saida_refri <= '1';
							e_proximo <= e0; -- nao retorna as moedas.		
						end if;
					end if;	

				-- ESTADO 50 CENTAVOS	
				when e50 =>
					if(produto = 25) then -- troco de 10  -> 2 possibilidades											
						if (qtd_moeda25cent > 0) then 
							saida25cent <= '1'; qtd_moeda25cent <= qtd_moeda25cent - 1;
							e_proximo <= e25;						
						elsif (qtd_moeda10cent > 0) then 
							saida10cent <= '1'; qtd_moeda10cent <= qtd_moeda10cent - 1;
							e_proximo <= e40;
						elsif (qtd_moeda5cent > 0)	then
							saida5cent  <= '1'; qtd_moeda5cent <= qtd_moeda5cent - 1;
							e_proximo <= e45;	
						else
							saida_agua <= '1';
							e_proximo <= e0; -- nao retorna as moedas.
						end if;
					else -- se for refri 
						saida25cent <= '0';
						if (qtd_moeda10cent > 0) then 
							saida10cent <= '1'; qtd_moeda10cent <= qtd_moeda10cent - 1;
							e_proximo <= e40;
						elsif (qtd_moeda5cent > 0) then 
								saida5cent  <= '1'; qtd_moeda5cent <= qtd_moeda5cent - 1;
								e_proximo <= e45;
						else
							saida_refri <= '1';
							e_proximo <= e0; -- nao retorna as moedas.		
						end if;
					end if;						
										
			end case;
				
		end process;	
end mef;
