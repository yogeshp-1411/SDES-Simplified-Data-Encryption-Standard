
-- The following code is made to generate two Keys for SDES implementation.
-- Key : 10 bit input to the code.
-- K1 : 1st key to be used for encryption/decryption.
-- K2 : 2nd Key to be used for encryption/decryption. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity keyGeneration is
	port(
		key : in std_logic_vector(9 downto 0);
		K1 : out std_logic_vector(7 downto 0);
		K2 : out std_logic_vector(7 downto 0)
	);
end entity;

architecture behave of keyGeneration is
	
	signal p10_out :  std_logic_vector (9 downto 0);
	signal p10_out_L :  std_logic_vector (4 downto 0);
	signal p10_out_R :  std_logic_vector (4 downto 0);
	signal ls1_Lout :  std_logic_vector (4 downto 0);
	signal ls1_Rout :  std_logic_vector (4 downto 0);
	signal ls2_Lout :  std_logic_vector (4 downto 0);
	signal ls2_Rout :  std_logic_vector (4 downto 0);
	
	-- Function p10 does the shuffling of bits.
	function p10(key : in std_logic_vector(9 downto 0))
		return std_logic_vector is
		variable p10_out_T : std_logic_vector (9 downto 0);
	begin 
		--for left half
		p10_out_T(9) := key(7);
		p10_out_T(8) := key(5);
		p10_out_T(7) := key(8);
		p10_out_T(6) := key(3);
		p10_out_T(5) := key(6);
		
		--for right half
		p10_out_T(4) := key(0);
		p10_out_T(3) := key(9);
		p10_out_T(2) := key(1);
		p10_out_T(1) := key(2);
		p10_out_T(0) := key(4);
		
		--return variable
		return p10_out_T;
	end;
	
	--p8 function does the shuffling of bits and compresses the output to 8 bits.
	function p8(p8_in : in std_logic_vector(9 downto 0))
		return std_logic_vector is
		variable p8_out_T : std_logic_vector (7 downto 0);
	begin 
		--for left half
		p8_out_T(7) := p8_in(4);
		p8_out_T(6) := p8_in(7);
		p8_out_T(5) := p8_in(3);
		p8_out_T(4) := p8_in(6);
		p8_out_T(3) := p8_in(2);
		p8_out_T(2) := p8_in(5);
		p8_out_T(1) := p8_in(0);
		p8_out_T(0) := p8_in(1);
		
		--return variable
		return p8_out_T;
	end;
	
	-- Function used to rotate the bits left with number of "times" specified.
	function leftShift (ls_in : in std_logic_vector(4 downto 0); times : in integer)
			return std_logic_vector is
			variable leftShift_out : unsigned (4 downto 0);
	begin
		leftShift_out := unsigned (ls_in) rol times;
		
		return std_logic_vector(leftShift_out);
	end;
	
begin

	p10_out <= p10(key);
	p10_out_L <= p10_out(9 downto 5);
	p10_out_R <= p10_out(4 downto 0);
	
	ls1_Lout <= leftShift(p10_out_L, 1);
	ls1_Rout <= leftShift(p10_out_R, 1);

	
	p8_proc1 : process(ls1_Lout, ls1_Rout)
		variable p8_in : std_logic_vector(9 downto 0);
	begin
			p8_in(4 downto 0) := ls1_Rout;
			p8_in(9 downto 5) := ls1_Lout;
			--1st key
			K1 <= p8(p8_in);
	end process;
	
	ls2_Lout <= leftShift(ls1_Lout, 2);
	ls2_Rout <= leftShift(ls1_Rout, 2);
	
	
	p8_proc2 : process(ls2_Lout, ls2_Rout)
		variable p8_in : std_logic_vector(9 downto 0);
	begin
			p8_in(4 downto 0) := ls2_Rout;
			p8_in(9 downto 5) := ls2_Lout;
			--2nd key
			K2 <= p8(p8_in);
	end process;
end behave;	
