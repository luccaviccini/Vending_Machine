library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity rom_precos is 
	port(
		-- ENTRADAS
		Clk          : in std_logic;
		produto		 : in std_logic_vector(1 downto 0);
		-- SAIDA
		preco    	 : out integer);	
	

end rom_precos;

architecture rom_arq of rom_precos is 

	type rom_type is array (0 to 3) of integer;
	
	constant ROM: rom_type := (0 => 25,
							   1 => 30,
						       2 => 50,
						       3 => 100);


	begin
		preco <= ROM(to_integer(unsigned(produto));
end architecture; 