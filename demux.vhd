----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:41:19 05/02/2019 
-- Design Name: 
-- Module Name:    demux5to32 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity demux5to32 is
    Port ( selecti : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end demux5to32;
architecture Behavioral of demux5to32 is

begin
process(selecti) is
begin 
if selecti = "00000" then
output <= "10000000000000000000000000000000";
elsif selecti = "00001" then
output <= "01000000000000000000000000000000";
elsif selecti = "00010" then
output <= "00100000000000000000000000000000";
elsif selecti = "00011" then
output <= "00010000000000000000000000000000";
elsif selecti = "00100" then
output <= "00001000000000000000000000000000";
elsif selecti = "00101" then
output <= "00000100000000000000000000000000";
elsif selecti = "00110" then
output <= "00000010000000000000000000000000";
elsif selecti = "00111" then
output <= "00000001000000000000000000000000";
elsif selecti = "01000" then
output <= "00000000100000000000000000000000";
elsif selecti = "01001" then
output <= "00000000010000000000000000000000";
elsif selecti = "01010" then
output <= "00000000001000000000000000000000";
elsif selecti = "01011" then
output <= "00000000000100000000000000000000";
elsif selecti = "01100" then
output <= "00000000000010000000000000000000";
elsif selecti = "01101" then
output <= "00000000000001000000000000000000";
elsif selecti = "01110" then
output <= "00000000000000100000000000000000";
elsif selecti = "01111" then
output <= "00000000000000010000000000000000";
elsif selecti = "10000" then
output <= "00000000000000001000000000000000";
elsif selecti = "10001" then
output <= "00000000000000000100000000000000";
elsif selecti = "10010" then
output <= "00000000000000000010000000000000";
elsif selecti = "10011" then
output <= "00000000000000000001000000000000";
elsif selecti = "10100" then
output <= "00000000000000000000100000000000";
elsif selecti = "10101" then
output <= "00000000000000000000010000000000";
elsif selecti = "10110" then
output <= "00000000000000000000001000000000";
elsif selecti = "10111" then
output <= "00000000000000000000000100000000";
elsif selecti = "11000" then
output <= "00000000000000000000000010000000";
elsif selecti = "11001" then
output <= "00000000000000000000000001000000";
elsif selecti = "11010" then
output <= "00000000000000000000000000100000";
elsif selecti = "11011" then
output <= "00000000000000000000000000010000";
elsif selecti = "11100" then
output <= "00000000000000000000000000001000";
elsif selecti = "11101" then
output <= "00000000000000000000000000000100";
elsif selecti = "11110" then
output <= "00000000000000000000000000000010";
elsif selecti = "11111" then
output <= "00000000000000000000000000000001";
else 
output <= "00000000000000000000000000000000";
end if;
end process;
end Behavioral;

