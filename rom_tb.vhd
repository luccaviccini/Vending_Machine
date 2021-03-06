library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Maquina_Vendas;

entity rom_tb is 
end entity;

architecture sim of rom_tb is 

	constant ClockPeriod    : time   := 1 ns; 	
	signal clk : std_logic := '1'; -- starting the clock high.
	signal tb_produto     : std_logic_vector(1 downto 0);
	signal tb_preco       : integer;

begin
	rom : entity work.rom_precos(rom_arq)
	port map (
		Clk 		 => clk,
		produto      => tb_produto,
		preco   => tb_preco);

		
	-- Process for generating the clock
	clk <= not clk after ClockPeriod/2;	
	
	process is
	begin
		
		
		tb_produto <= "00";
		wait for 2 ns;
		tb_produto <= "01";
		wait for 2 ns;
		tb_produto <= "10";
		wait for 2 ns;
		tb_produto <= "11";

		wait;
		
		
		
	end process;
	
end architecture;		
