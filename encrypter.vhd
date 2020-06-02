library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encrypter is
	port ( inputMessage : in std_logic_vector(7 downto 0);
			--key1_ : in std_logic_vector (7 downto 0);
			--key2 : in std_logic_vector (7 downto 0);
			cipherText : out std_logic_vector (7 downto 0);
			ip_Lout : out std_logic_vector (3 downto 0);
			ip_Rout : out std_logic_vector (3 downto 0);
			functionalBlock1_in : in std_logic_vector (3 downto 0);
			switchingLout : out std_logic_vector (3 downto 0);
			switchingRout : out std_logic_vector (3 downto 0);
			functionalBlock2_in : in std_logic_vector (3 downto 0)
			);
end entity;

architecture behave of encrypter is
	signal ip_Rout_sig : std_logic_vector (3 downto 0);
	--signal ip_Lout_sig : std_logic_vector (3 downto 0);
	--signal switchingLout : std_logic_vector(3 downto 0);
	signal switchingRout_sig : std_logic_vector(3 downto 0);
	--signal functionalBlock1_out : std_logic_vector(3 downto 0);
	--signal functionalBlock2_out : std_logic_vector(3 downto 0);
begin 	
	--IP implementation
	ip_Lout(0) <= inputMessage(7);
	ip_Lout(1) <= inputMessage(5);
	ip_Lout(2) <= inputMessage(2);
	ip_Lout(3) <= inputMessage(6);
	ip_Rout_sig(0) <= inputMessage(1);
	ip_Rout_sig(1) <= inputMessage(3);
	ip_Rout_sig(2) <= inputMessage(0);
	ip_Rout_sig(3) <= inputMessage(4);
	
	--1st functional Block functioning. 
	ip_Rout <= ip_Rout_sig;
	--ip_Lout <= ip_Lout_sig;
	
	--switching
	switchingLout <= ip_Rout_sig;
	switchingRout_sig <= functionalBlock1_in;
	
	--2nd functional Block functioning 
	switchingRout <= switchingRout_sig;
	
	--IP inverse 
	cipherText(0) <= switchingRout_sig (2);
	cipherText(1) <= switchingRout_sig (0);
	cipherText(2) <= functionalBlock2_in (2);
	cipherText(3) <= switchingRout_sig (1);
	cipherText(4) <= switchingRout_sig (3);
	cipherText(5) <= functionalBlock2_in (1);
	cipherText(6) <= functionalBlock2_in (3);
	cipherText(7) <= functionalBlock2_in (0);
end behave;