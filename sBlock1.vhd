
-- This code generates Sbox values. 
-- input: value of with Sbox value is to be found.
-- output : 2 bit output value for following Sbox
-- S1 : 	0	1	2	3
		--  2	0	1	3	
		--  3	0	1	0
		--  2	1	0	3

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sBlock1 is 
port (sBlock_in : in std_logic_vector(3 downto 0);
		sBlock_outR : out std_logic_vector (1 downto 0)
		);
end entity;

architecture behave of sBlock1 is

	signal row : std_logic_vector (1 downto 0);
	signal column : std_logic_vector (1 downto 0);
	TYPE sBlock_values IS ARRAY (0 to 3, 0 to 3) of std_logic_vector (1 downto 0);
	signal sBlock2: sBlock_values;
		
begin
	--sblock2 values
	sBlock2(0, 0) <= "00";
	sBlock2(0, 1) <= "01";
	sBlock2(0, 2) <= "10";
	sBlock2(0, 3) <= "11";
		  
	sBlock2(1, 0) <= "10";
	sBlock2(1, 1) <= "00";
	sBlock2(1, 2) <= "01";
	sBlock2(1, 3) <= "11";
		  
	sBlock2(2, 0) <= "11";
	sBlock2(2, 1) <= "00";
	sBlock2(2, 2) <= "01";
	sBlock2(2, 3) <= "00";
		  
	sBlock2(3, 0) <= "10";
	sBlock2(3, 1) <= "01";
	sBlock2(3, 2) <= "00";
	sBlock2(3, 3) <= "11";
	
	row(1) <= sBlock_in(3);
	row(0) <= sBlock_in(0);
	
	column(1) <= sBlock_in(2);
	column(0) <= sBlock_in(1);
	
	sblock_proc : process (row, column)
	begin
	for i in 0 to 3 loop 
			for j in 0 to 3 loop
				--if ((i = to_integer(row) ) and (j = to_integer(column))) then
					if (i = to_integer(unsigned(row)) ) then 
						if (j = to_integer(unsigned(column)) ) then
							sBlock_outR <= sBlock2(i, j);
						end if;
					end if;
			end loop;
	end loop;
	end process;
end behave;