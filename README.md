# SDES-Simplified-Data-Encryption-Standard
VHDL code written in ModelSim for Encryption and Decryption of data (binary messages) using Simplified Data Encryption Standard.

Data encryption is done with the help of keys, various operations and Sbox values. So, I have divided the entire code into some small modules.
They are :
1) Key Generation : 
  2 Keys are generated (K1 and K2). Code can be found in keyGeneration.vhd
2) SBOX :
  Sbox values are predefined. As there are 2 Sboxes which are used twice in entire encryption/decryption process, I have created a seperate code.
  This code can be used as a module again and again. This is just to reduce redundant code. 
  Code files in the name of sBlock0.vhd and sBlock1.vhd
2) Functional Block : 
  Contains operations like EP, EXORing, P4 and SBoxes. This code also acts as a top level source code for SBOX code as they are used as a module in Functional Blocks.
  As there are 2 Functional blocks for the process, There are 2 source Files for 2 different Functional Blocks. As I have used concurrent programming approach,
  I had to use 2 seperate source Files. I doubted that the code wouldn't work as expected if used same source file as a block.
  Code files are in the name of functionalBlock1.vhd functionalBlock2.vhd
3) Encrypter/Decrypter:
  This is the main source code which will run the entire process. Remaining operations like IP, switching and inverse Ip are carried out in this code.
  Code file in the name of encrypter.vhd and decrypter.vhd respectively.
4) TestBench :
  Testbench code is available in the name of encrypter_tb.vhd and decrypter_tb.vhd for encrypter and decrypter respectively.
  
  ---------------------------------
  Graphical representation of hierarchy can be found in the image named images.vhd.
  Process illustrated in the images keyGeneration and SDES. (These images have been downloaded from the WEB).
