library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encrypter_tb is
end entity;

architecture behave of encrypter_tb is
	component encrypter is
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
	end component;
	
	component keyGeneration is
	port(
		key 	: in std_logic_vector	(9 downto 0);
		K1 		: out std_logic_vector	(7 downto 0);
		K2 		: out std_logic_vector	(7 downto 0)
	);
	end component;
	
	component functionalBlock1 is
	port (	ip_Rout1 			: in std_logic_vector	(3 downto 0);
			key1 				: in std_logic_vector	(7 downto 0);
			ip_Lout1 			: in std_logic_vector	(3 downto 0);
			functionalBlock1_out : out std_logic_vector	(3 downto 0)
		);
	end component;
	
	component functionalBlock2 is
	port (	ip_Rout2 			: in std_logic_vector	(3 downto 0);
			key2 				: in std_logic_vector	(7 downto 0);
			ip_Lout2 			: in std_logic_vector	(3 downto 0);
			functionalBlock2_out : out std_logic_vector	(3 downto 0)
		);
	end component;
	
	signal inputMessage_sim : std_logic_vector (7 downto 0) := "11101110";
	signal key1_sim : std_logic_vector (7 downto 0);
	signal key2_sim : std_logic_vector (7 downto 0);
	signal cipherText_sim : std_logic_vector (7 downto 0);
	signal ip_Lout_sim : std_logic_vector (3 downto 0);
	signal ip_Rout_sim : std_logic_vector (3 downto 0);
	--signal functionalBlock1_in : std_logic_vector (3 downto 0);
	signal switchingLout_sim : std_logic_vector (3 downto 0);
	signal switchingRout_sim : std_logic_vector (3 downto 0);
	
	signal key_sim : std_logic_vector (9 downto 0) := "0101101101";
	signal K1_sim : std_logic_vector (7 downto 0);
	signal K2_sim : std_logic_vector (7 downto 0);
	
	--signal ip_Rout1 : std_logic_vector (3 downto 0);
	signal key_sim1 : std_logic_vector (7 downto 0);
	--signal ip_Lout1 : std_logic_vector (3 downto 0);
	signal functionalBlock1_out_sim : std_logic_vector (3 downto 0);
	
	signal ip_Rout2 : std_logic_vector (3 downto 0);
	signal key_sim2 : std_logic_vector (7 downto 0);
	signal ip_Lout2 : std_logic_vector (3 downto 0);
	signal functionalBlock2_out_sim : std_logic_vector (3 downto 0);
	
begin
	keyGeneration_inst : keyGeneration port map (
							key => key_sim,
							k1 => K1_sim,
							K2 => K2_sim
							);
	functionalBlock1_inst : functionalBlock1 port map (
							ip_Lout1 => ip_Lout_sim,
							ip_Rout1 => ip_Rout_sim,
							key1 => K1_sim,
							functionalBlock1_out => functionalBlock1_out_sim
							);						
	encrypter_inst : encrypter port map (
							inputMessage => inputMessage_sim,
							ip_Lout => ip_Lout_sim,
							ip_Rout => ip_Rout_sim,
							functionalBlock1_in => functionalBlock1_out_sim,
							switchingLout => switchingLout_sim,
							switchingRout => switchingRout_sim,
							functionalBlock2_in => functionalBlock2_out_sim,
							cipherText => cipherText_sim
							);
	functionalBlock2_inst : functionalBlock2 port map(
							ip_Lout2 => switchingLout_sim,
							ip_Rout2 => switchingRout_sim,
							key2 => K2_sim,
							functionalBlock2_out => functionalBlock2_out_sim
							);						
	
end architecture;