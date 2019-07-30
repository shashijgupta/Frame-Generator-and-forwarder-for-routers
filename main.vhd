----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:27 05/02/2019 
-- Design Name: 
-- Module Name:    main - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( iData_av : in  STD_LOGIC;
           iRd_data : out  STD_LOGIC;
           iData : in  STD_LOGIC_VECTOR (143 downto 0);
           Input_Port : in  STD_LOGIC_VECTOR (4 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (2 downto 0);
           Rd_opcode : out  STD_LOGIC;
           CFM_information : in  STD_LOGIC_VECTOR (255 downto 0);
           CFM_Sequence_number : in  STD_LOGIC_VECTOR (15 downto 0);
           CFM_Output_port : in  STD_LOGIC_VECTOR (4 downto 0);
           Gen_CFM : in  STD_LOGIC;
           CFM_sent : out  STD_LOGIC;
           Wr_Sequence_number : in  STD_LOGIC_VECTOR (15 downto 0);
           Wr_output_port : in  STD_LOGIC_VECTOR (4 downto 0);
           Send_wr_ACK : in  STD_LOGIC;
           Ack_sent : out  STD_LOGIC;
           MAC : in  STD_LOGIC_VECTOR (47 downto 0);
           oData_av : out  STD_LOGIC;
           oRd_data : in  STD_LOGIC;
           oData : out  STD_LOGIC_VECTOR (143 downto 0);
           Output_Port_mask : out  STD_LOGIC_VECTOR (31 downto 0);
           Port_number : out  STD_LOGIC_VECTOR (4 downto 0);
           Read_port_info : out  STD_LOGIC;
           Port_info : in  STD_LOGIC_VECTOR (79 downto 0);
           Port_info_valid : in  STD_LOGIC;
			  clk : in std_logic;
           Core_ports : in  STD_LOGIC_VECTOR (31 downto 0));
end main;
 
architecture Behavioral of main is
COMPONENT fifo
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(143 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(143 DOWNTO 0);
    full : OUT STD_LOGIC;
    almost_full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT fifo_port
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC
  );
END COMPONENT;

component demux5to32 
    Port ( selecti : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
			  
type states is (idle, reading, forward, hello_ack,hello_for, last, cfm_gen, ack_gen1, ack_gen2, ack_for, cfm_gen1, cfm_gen2,cfm_for, ack_gen, last1);
signal p_state, n_state : states := idle;
signal rst, full, almost_full, empty, prog_full, fsm_bsy, wr_en0, rd_en0, wr_en1, rd_en1 : std_logic := '0';
signal dout_data : std_logic_vector(143 downto 0) := (others => '0');
signal temp_dout_port : std_logic_vector(31 downto 0) := (others => '0');
signal dout_port : std_logic_vector(31 downto 0) := (others => '0');   
signal seq_no : std_logic_vector(15 downto 0) := (others => '0');
signal ether_value : std_logic_vector(15 downto 0) := (others => '0');
signal ether_type : std_logic_vector(15 downto 0) := (others => '0');
signal cur_port : std_logic_vector(4 downto 0) := (others => '0');
signal cur_port_working : std_logic_vector(4 downto 0) := (others => '0');
signal cur_port_working_mask : std_logic_vector(31 downto 0) := (others => '0');
signal cur_port_sending : std_logic_vector(4 downto 0) := (others => '0');
signal cur_port_sending_int : integer := 0;
signal ack : std_logic_vector(2719 downto 0) := (others => '0');
signal help_ack_valid : std_logic_vector(3059 downto 0) := (others => '0');
signal cur_unit : std_logic_vector(4 downto 0) := (others => '0');
signal cur_unit_int : integer := 0;
signal cfm_packet : std_logic_vector(191 downto 0) := (others => '0');
signal cfm_packet_valid : std_logic_vector(215 downto 0) := (others => '0');
signal cfm_port_mask : std_logic_vector(31 downto 0) := (others => '0'); 
signal ack_packet : std_logic_vector(143 downto 0) := (others => '0');
signal ack_packet_valid : std_logic_vector(161 downto 0) := (others => '0');
signal ack_port_mask : std_logic_vector(31 downto 0) := (others => '0');
signal null_vec : std_logic_vector(71 downto 0) := (others => '0');
signal null_vec1 : std_logic_vector(107 downto 0) := (others => '0');
signal null_vec2 : std_logic_vector(125 downto 0) := (others => '0');

begin
DUT0 : demux5to32 PORT MAP (
						Selecti => Input_Port,
						output => temp_dout_port
						);
						
DUT1 : demux5to32 PORT MAP (
						Selecti => cur_port_working,
						output => cur_port_working_mask
						);

DUT2 : demux5to32 PORT MAP (
						Selecti => CFM_Output_port,
						output => cfm_port_mask
						);
						
DUT3 : demux5to32 PORT MAP (
						Selecti => Wr_Output_port,
						output => ack_port_mask
						);						
						
process(clk)
begin
if rising_edge(clk) then
p_state <= n_state;
end if;
end process;

process(clk)
begin
--if rising_edge(clk) then
case p_state is
when idle => 
if (iData_av = '1') then
if (fsm_bsy = '0') then
if (Opcode = "001") then
n_state <= reading;
else 
n_state <= idle; 
end if;
else 
n_state <= idle;
end if;
elsif Gen_CFM = '1' then
n_state <= cfm_gen;
elsif Send_wr_ACK = '1' then
n_state <= ack_gen;
else
n_state <= idle;
end if;

when reading =>
n_state <= forward;

when forward =>
if iData(0) = '0' AND iData(8) = '0' AND iData(16) = '0' AND iData(24) = '0' AND iData(32) = '0' AND iData(40) = '0' AND iData(48) = '0' AND iData(56) = '0' AND iData(64) = '0' AND iData(72) = '0' AND iData(80) = '0' AND iData(88) = '0' AND iData(96) = '0' AND iData(104) = '0' AND iData(112) = '0' AND iData(120) = '0' AND iData(128) = '0' AND iData(136) = '0'  then
n_state <= hello_ack;
else
n_state <= forward;
end if;

when hello_ack =>
if cur_port = "11111" then
n_state <= last;
else
n_state <= hello_ack;
end if;

when last =>
n_state < hello_for;

when hello_for =>
n_state <= last1;

when last1 =>
if cur_unit = 21 then
n_state <= idle;
else
n_state <= last1;
end if;

when cfm_gen =>
n_state <= cfm_for;

when cfm_for =>
n_state <= cfm_gen1;

when cfm_gen1 =>
n_state <= cfm_gen2;

when cfm_gen2 =>
n_state <= idle;

when ack_gen =>
n_state <= ack_for;

when ack_for =>
n_state <= ack_gen1;

when ack_gen1 =>
n_state <= ack_gen2;

when ack_gen2 =>
n_state <= idle;

when others =>
n_state <= idle;
end case;
--end if;
end process;

process(clk)
variable ack_help1 : integer := 3059;
variable ack_help2 : integer := 2719;
variable help1 : integer := 161;
variable help2 : integer := 143;
variable cfm_help1 : integer := 215;
variable cfm_help2 : integer := 191;
begin
if rising_edge(clk) then
case p_state is 
when idle =>
wr_en0 <= '0';
wr_en1 <= '0';

when reading =>
seq_no <= iData(15 downto 0);
ether_value <= iData(31 downto 16);
ether_type <= iData(47 downto 32);
dout_port <= core_ports and (not temp_dout_port);
dout_data <= iData;
wr_en0 <= '1';
wr_en1 <= '1';
cur_port_working <= Input_Port;

when forward =>
dout_port <= core_ports and (not temp_dout_port);
dout_data <= iData;
wr_en0 <= '1';
wr_en1 <= '1';


when hello_ack =>
wr_en0 <= '0';
wr_en1 <= '0';
if cur_port = 0 then
cur_port_sending <= cur_port;
cur_port <= cur_port + 1;
ack(2671 downto 2624) <= MAC;
ack(2623 downto 2608) <= ether_type;
ack(2607 downto 2592) <= ether_value;
ack(2591 downto 2576) <= seq_no;
ack(2575 downto 2560) <= "0000000000000000";
else 
if Port_info_valid = '1' then
ack((2559 - cur_port_sending_int) downto (2480 - cur_port_sending_int)) <= Port_info;
cur_port_sending_int <= cur_port_sending_int + 80;
if cur_port_sending = cur_port_working then
ack(2719 downto 2672) <= Port_info(63 downto 16);
end if;
cur_port_sending <= cur_port;
cur_port <= cur_port + 1;
else
cur_port_sending <= cur_port_sending;
cur_port <= cur_port;
end if;
end if; 

when last =>
--if Port_info_valid = '1' then
ack(79 downto 0) <= (others => '0');
cur_port_sending_int <= cur_port_sending_int + 80;
if cur_port_sending = cur_port_working then
ack(2719 downto 2672) <= Port_info(63 downto 16);
end if;
--else
--ack(79 downto 0) <= (others => '0');
--cur_port_sending <= cur_port_sending;
--cur_port <= cur_port;
--end if;

when hello_for =>
for j in 0 to 339 loop
help_ack_valid(3059 - (j)*9) <= '1';
help_ack_valid((3058 - (j)*9) downto (3051 - (j)*9)) <= ack((2719 - (j)*8) downto (2712 - (j)*8));
ack_help1 := ack_help1 - 9;
ack_help2 := ack_help2 - 8;
end loop;

when last1 =>
if cur_unit = 21 then
dout_data <= help_ack_valid(35 downto 0) & null_vec1;
dout_port <= cur_port_working_mask;
cur_port_working <= (others => '0');
cur_port <= (others => '0');
cur_port_sending <= (others => '0');
cur_unit_int <= 0;
--cur_port_working_mask <= (others => '0');
fsm_bsy <= '0';
else
dout_data <= help_ack_valid((3059 - cur_unit_int) downto (2916 - cur_unit_int));
cur_unit_int <= cur_unit_int + 144;
cur_unit <= cur_unit + 1;
dout_port <= cur_port_working_mask;
end if;
wr_en0 <= '1';
wr_en1 <= '1';

when cfm_gen =>
cfm_packet(191 downto 64) <= CFM_information(255 downto 128);
cfm_packet(63 downto 48) <= CFM_sequence_number;
cfm_packet(47 downto 0) <= CFM_information(127 downto 80);

when cfm_for =>
for j in 0 to 23 loop
cfm_packet_valid(215 - (j)*9) <= '1';
cfm_packet_valid((214 - (j)*9) downto (207 - (j)*9)) <= cfm_packet((191 - (j) * 8) downto (184 - (j)*8));
cfm_help1 := cfm_help1 - 9;
cfm_help2 := cfm_help2 - 8;
end loop;



when cfm_gen1 =>
dout_data <= cfm_packet_valid(215 downto 72);
dout_port <= cfm_port_mask;
wr_en0 <= '1';
wr_en1 <= '1';

when cfm_gen2 =>
dout_data <= cfm_packet_valid(71 downto 0) & null_vec;
dout_port <= cfm_port_mask;
wr_en0 <= '1';
wr_en1 <= '1';


when ack_gen =>
ack_packet(143 downto 96) <= (others => '1');
ack_packet(95 downto 48) <= MAC;
ack_packet(15 downto 0) <= Wr_Sequence_number;

when ack_for =>
for j in 0 to 17 loop
ack_packet_valid(161 - (j)*9) <= '1';
ack_packet_valid((160 - (j)*9) downto (153 - (j)*9)) <= ack_packet((143 - (j)*8) downto (136 - (j)*8));
help1 := help1 - 9;
help2 := help2 - 8;
end loop;

when ack_gen1 =>
dout_data <= ack_packet_valid(161 downto 18);
dout_port <= ack_port_mask;
wr_en0 <= '1';
wr_en1 <= '1'; 

when ack_gen2 =>
dout_data <= ack_packet_valid(17 downto 0) & null_vec2;
dout_port <= ack_port_mask;
wr_en0 <= '1';
wr_en1 <= '1';

when others =>
fsm_bsy <= '0';
end case;

if oRd_Data = '1' then
rd_en0 <= '1';
rd_en1 <= '1';
else 
rd_en0 <= '0';
rd_en1 <= '0';
end if;
end if;
end process;


process(clk)
begin
if rising_edge(clk) then
case p_state is
when idle =>
if (iData_av = '1') then
if (fsm_bsy = '0') then
if (Opcode = "001") then
iRd_data <= '1';
else 
iRd_data <= '0'; 
end if;
else 
iRd_data <= '0';
end if;
else 
iRd_data <= '0';
end if;

Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when reading =>
iRd_data <= '1';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when forward =>
if iData(0) = '0' AND iData(8) = '0' AND iData(16) = '0' AND iData(24) = '0' AND iData(32) = '0' AND iData(40) = '0' AND iData(48) = '0' AND iData(56) = '0' AND iData(64) = '0' AND iData(72) = '0' AND iData(80) = '0' AND iData(88) = '0' AND iData(96) = '0' AND iData(104) = '0' AND iData(112) = '0' AND iData(120) = '0' AND iData(128) = '0' AND iData(136) = '0'  then
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

else
iRd_data <= '1';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';
end if;

when hello_ack =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= cur_port;  
Read_port_info <= '1';

when last =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when hello_for =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when last1 =>
if cur_unit = 21 then
iRd_data <= '0';
Rd_opcode <= '1';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';
else
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';
end if;

when cfm_gen =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when cfm_for =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when cfm_gen1 =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when cfm_gen2 =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '1';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when ack_gen =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when ack_for =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when ack_gen1 =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '0';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

when ack_gen2 =>
iRd_data <= '0';
Rd_opcode <= '0';
CFM_sent <= '0';
Ack_sent <= '1';
oData_av <= not empty;
Port_number <= (others => '0');
Read_port_info <= '0';

end case;
end if;
end process;

output_data : fifo
PORT MAP (
    rst => rst,
    wr_clk => clk,
    rd_clk => clk,
    din => dout_data,
    wr_en => wr_en0,
    rd_en => rd_en0,
    dout => oData,
    full => full,
    almost_full => almost_full,
    empty => empty,
 prog_full => prog_full
  );

out_port : fifo_port
PORT MAP (
    rst => rst,
    wr_clk => clk,
    rd_clk => clk,
    din => dout_port,
    wr_en => wr_en1,
    rd_en => rd_en1,
    dout => Output_Port_mask,
    full => full,
    empty => empty,
    prog_full => prog_full
  );
  

end Behavioral;

