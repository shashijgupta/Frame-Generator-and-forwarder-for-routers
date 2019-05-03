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
           CFM_Output_port : in  STD_LOGIC_VECTOR (31 downto 0);
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
			  
type states is (idle, reading, forward, hello_ack, last);
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
signal ack : std_logic_vector(2719 downto 0);
signal cur_unit : std_logic_vector(4 downto 0) := (others => '0');
signal cur_unit_int : integer := 0;
begin
DUT0 : demux5to32 PORT MAP (
						Selecti => Input_Port,
						output => temp_dout_port
						);
						
DUT1 : demux5to32 PORT MAP (
						Selecti => cur_port_working,
						output => cur_port_working_mask
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
else
n_state <= idle;
end if;

when reading =>
n_state <= forward;

when forward =>
if iData = 0 then
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
if cur_unit = 18 then
n_state <= idle;
else
n_state <= last;
end if;

when others =>
n_state <= idle;
end case;
--end if;
end process;

process(clk)
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
if iData = 0 then
wr_en0 <= '0';
wr_en1 <= '0';
else
wr_en0 <= '1';
wr_en1 <= '1';
end if;


when hello_ack =>
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
end if;
end if; 

when last =>
if cur_port_sending_int = 2480 then
if Port_info_valid = '1' then
ack((2559 - cur_port_sending_int) downto (2480 - cur_port_sending_int)) <= Port_info;
cur_port_sending_int <= cur_port_sending_int + 80;
if cur_port_sending = cur_port_working then
ack(2719 downto 2672) <= Port_info(63 downto 16);
end if;
end if;
end if;

if cur_unit = 18 then
dout_data <= ack(127 downto 0) & "0000000000000000";
dout_port <= cur_port_working_mask;
cur_port_working <= (others => '0');
cur_port <= (others => '0');
cur_port_sending <= (others => '0');
--cur_port_working_mask <= (others => '0');
fsm_bsy <= '0';
else
dout_data <= ack((2719 - cur_unit_int) downto (2576 - cur_unit_int));
cur_unit_int <= cur_unit_int + 144;
cur_unit <= cur_unit + 1;
dout_port <= cur_port_working_mask;
end if;
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
if iData = 0 then
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
if cur_unit = 18 then
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

