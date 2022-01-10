library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Maquina_Vendas;

entity Maquina_Vendas_tb is 
end entity;

architecture sim of Maquina_Vendas_tb is 

	constant ClockPeriod    : time   := 1 ns; 	
	signal clk : std_logic := '1'; -- starting the clock high.

	signal reset : std_logic := '0';
	signal tb_moeda5cent  : boolean := false;
	signal tb_moeda10cent : boolean := false;
	signal tb_moeda25cent : boolean := false;
	signal tb_produto     : integer;
	signal tb_saida_agua  : std_logic;
	signal tb_saida_refri : std_logic;	
	signal tb_saida25cent : std_logic;
	signal tb_saida10cent : std_logic;
	signal tb_saida5cent  : std_logic;
begin
	vending_machine : entity work.Maquina_Vendas(mef)
	port map (
		Clk 		 => clk,
		Reset 		 => reset,
		moeda5cent   => tb_moeda5cent,
		moeda10cent  => tb_moeda10cent,
		moeda25cent  => tb_moeda25cent,
		produto		 => tb_produto,
		saida_agua   => tb_saida_agua,
		saida_refri  => tb_saida_refri,
		saida25cent  => tb_saida25cent,
		saida10cent  => tb_saida10cent,
		saida5cent   => tb_saida5cent);
		
	-- Process for generating the clock
	clk <= not clk after ClockPeriod/2;	
	
	process is
	begin
		wait for 2 ns;
		
		tb_produto <= 25;
		tb_moeda5cent  <= true;
		tb_moeda10cent <= false;
		tb_moeda25cent <= false;
		wait for 1 ns;
		
		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= false;
		wait for 2 ns;
		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= true;
		tb_moeda25cent <= false;
		wait for 1 ns;
		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= false;
		wait for 2 ns;
		
		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= true;
		wait for 1 ns;
		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= false;
		wait for 15 ns;
		
		-- produto de 30
		tb_produto <= 30;
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= true;
		wait for 1 ns;
		
		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= false;
		wait for 2 ns;
		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= true;
		wait for 1 ns;
		

		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= false;
		wait for 15 ns;
		-- outro produto
		tb_produto <= 30;
		tb_moeda5cent  <= false;
		tb_moeda10cent <= true;
		tb_moeda25cent <= false;
		wait for 1 ns;
		
		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= false;
		wait for 2 ns;
		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= true;
		wait for 1 ns;
		

		
		tb_moeda5cent  <= false;
		tb_moeda10cent <= false;
		tb_moeda25cent <= false;
		wait;
		
		
		
	end process;
	
end architecture;		
