--decrypter Code
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decrypter is
	port ( inputMessage : in std_logic_vector(7 downto 0);
			decipherText : out std_logic_vector (7 downto 0);
			ip_Lout : out std_logic_vector (3 downto 0);
			ip_Rout : out std_logic_vector (3 downto 0);
			functionalBlock1_in : in std_logic_vector (3 downto 0);
			switchingLout : out std_logic_vector (3 downto 0);
			switchingRout : out std_logic_vector (3 downto 0);
			functionalBlock2_in : in std_logic_vector (3 downto 0)
			);
end entity;

architecture behave of decrypter is
	signal ip_Rout_sig : std_logic_vector (3 downto 0);
	signal ip_Lout_sig : std_logic_vector (3 downto 0);
	signal functionalBlock2_out_sig : std_logic_vector(3 downto 0);
begin 	
	--IP implementation
	ip_Lout_sig(0) <= inputMessage(7);
	ip_Lout_sig(1) <= inputMessage(5);
	ip_Lout_sig(2) <= inputMessage(2);
	ip_Lout_sig(3) <= inputMessage(6);
	ip_Rout_sig(0) <= inputMessage(1);
	ip_Rout_sig(1) <= inputMessage(3);
	ip_Rout_sig(2) <= inputMessage(0);
	ip_Rout_sig(3) <= inputMessage(4);
	
	--1st functional Block functioning. 
	switchingRout <= ip_Rout_sig;
	switchingLout <= ip_Lout_sig;

	--switching
	ip_Lout <= ip_Rout_sig;
	
	--2nd functional Block functioning
	functionalBlock2_out_sig <= functionalBlock2_in;
	ip_Rout <= ip_Rout_sig;
	
	--IP inverse 
	decipherText(0) <= functionalBlock2_out_sig (2);
	decipherText(1) <= functionalBlock2_out_sig (0);
	decipherText(2) <= functionalBlock1_in (2);
	decipherText(3) <= functionalBlock2_out_sig (1);
	decipherText(4) <= functionalBlock2_out_sig (3);
	decipherText(5) <= functionalBlock1_in (1);
	decipherText(6) <= functionalBlock1_in (3);
	decipherText(7) <= functionalBlock1_in (0);
end behave;