--Functional Block 1 code.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity functionalBlock1 is
port (	ip_Rout1 			: in std_logic_vector	(3 downto 0);
		key1 				: in std_logic_vector	(7 downto 0);
		ip_Lout1 			: in std_logic_vector	(3 downto 0);
		functionalBlock1_out : out std_logic_vector	(3 downto 0)
		);
end entity;

architecture behave of functionalBlock1 is
	signal ep_out : std_logic_vector (7 downto 0);
	signal exor8_Lout : std_logic_vector (3 downto 0);
	signal exor8_Rout : std_logic_vector (3 downto 0);
	signal sBox_outL : std_logic_vector (1 downto 0);
	signal sBox_outR : std_logic_vector (1 downto 0);
	signal p4_in : std_logic_vector (3 downto 0);
	signal p4_out : std_logic_vector (3 downto 0);
	
	component sBlock0 is 
	port (sBlock_in : in std_logic_vector(3 downto 0);
		sBlock_outL : out std_logic_vector (1 downto 0)
		);
	end component;
	
	component sBlock1 is 
	port (sBlock_in : in std_logic_vector(3 downto 0);
		sBlock_outR : out std_logic_vector (1 downto 0)
		);
	end component;

	
begin
	
	--EP function. Extension of bits
	ep_out(0) <= ip_Rout1(3);
	ep_out(1) <= ip_Rout1(0);
	ep_out(2) <= ip_Rout1(1);
	ep_out(3) <= ip_Rout1(2);
	ep_out(4) <= ip_Rout1(1);
	ep_out(5) <= ip_Rout1(2);
	ep_out(6) <= ip_Rout1(3);
	ep_out(7) <= ip_Rout1(0);
	
	--EXORing
	exor8_Lout <= ep_out(7 downto 4) xor key1(7 downto 4);
	exor8_Rout <= ep_out(3 downto 0) xor key1(3 downto 0);
	
	--sbox implementation
	sbox0 : sBlock0 port map (
							sBlock_in => exor8_Lout,
							sBlock_outL => sBox_outL
							);
	sbox1 : sBlock1 port map (
							sBlock_in => exor8_Rout,
							sBlock_outR => sBox_outR
							);
	
	-- P4 implementation
	p4_in(3 downto 2) <= sBox_outL;
	p4_in(1 downto 0) <= sBox_outR;
	p4_out(0) <= p4_in(3);
	p4_out(1) <= p4_in(1);
	p4_out(2) <= p4_in(0);
	p4_out(3) <= p4_in(2);
	
	--EXORing
	functionalBlock1_out <= ip_Lout1 xor p4_out;
	
end behave;
