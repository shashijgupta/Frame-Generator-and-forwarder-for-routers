--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   01:04:02 05/03/2019
-- Design Name:
-- Module Name:   
--/home/aneesh/XilinxProjects/DLD-Packet-Gen-Fwd/their_top_module_tb.vhd
-- Project Name:  DLD-Packet-Gen-Fwd
-- Target Device:
-- Tool versions:
-- Description:
-- 
-- VHDL Test Bench Created by ISE for module: main
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes:
-- This testbench has been automatically generated using types 
--std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx 
--recommends
-- that these types always be used for the top-level I/O of a design in 
--order
-- to guarantee that the testbench will bind correctly to the 
--post-implementation
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY their_top_module_tb IS
END their_top_module_tb;

ARCHITECTURE behavior OF their_top_module_tb IS

     -- Component Declaration for the Unit Under Test (UUT)

     COMPONENT main
     PORT(
          iData_av : IN  std_logic;
          iRd_data : OUT  std_logic;
          iData : IN  std_logic_vector(143 downto 0);
          Input_Port : IN  std_logic_vector(4 downto 0);
          Opcode : IN  std_logic_vector(2 downto 0);
          Rd_opcode : OUT  std_logic;
          CFM_information : IN  std_logic_vector(255 downto 0);
          CFM_Sequence_number : IN  std_logic_vector(15 downto 0);
          CFM_Output_port : IN  std_logic_vector(31 downto 0);
          Gen_CFM : IN  std_logic;
          CFM_sent : OUT  std_logic;
          Wr_Sequence_number : IN  std_logic_vector(15 downto 0);
          Wr_output_port : IN  std_logic_vector(4 downto 0);
          Send_wr_ACK : IN  std_logic;
          Ack_sent : OUT  std_logic;
          MAC : IN  std_logic_vector(47 downto 0);
          oData_av : OUT  std_logic;
          oRd_data : IN  std_logic;
          oData : OUT  std_logic_vector(143 downto 0);
          Output_Port_mask : OUT  std_logic_vector(31 downto 0);
          Port_number : OUT  std_logic_vector(4 downto 0);
          Read_port_info : OUT  std_logic;
          Port_info : IN  std_logic_vector(79 downto 0);
          Port_info_valid : IN  std_logic;
          clk : IN  std_logic;
          Core_ports : IN  std_logic_vector(31 downto 0)
         );
     END COMPONENT;


    --Inputs
    signal iData_av : std_logic := '0';
    signal iData : std_logic_vector(143 downto 0) := (others => '0');
    signal Input_Port : std_logic_vector(4 downto 0) := (others => '0');
    signal Opcode : std_logic_vector(2 downto 0) := (others => '0');
    signal CFM_information : std_logic_vector(255 downto 0) := (others 
=> '0');
    signal CFM_Sequence_number : std_logic_vector(15 downto 0) := 
(others => '0');
    signal CFM_Output_port : std_logic_vector(31 downto 0) := (others => 
'0');
    signal Gen_CFM : std_logic := '0';
    signal Wr_Sequence_number : std_logic_vector(15 downto 0) := (others 
=> '0');
    signal Wr_output_port : std_logic_vector(4 downto 0) := (others => 
'0');
    signal Send_wr_ACK : std_logic := '0';
    signal MAC : std_logic_vector(47 downto 0) := (others => '0');
    signal oRd_data : std_logic := '0';
    signal Port_info : std_logic_vector(79 downto 0) := (others => '0');
    signal Port_info_valid : std_logic := '0';
    signal clk : std_logic := '0';
    signal Core_ports : std_logic_vector(31 downto 0) := (others => 
'0');

        --Outputs
    signal iRd_data : std_logic;
    signal Rd_opcode : std_logic;
    signal CFM_sent : std_logic;
    signal Ack_sent : std_logic;
    signal oData_av : std_logic;
    signal oData : std_logic_vector(143 downto 0);
    signal Output_Port_mask : std_logic_vector(31 downto 0);
    signal Port_number : std_logic_vector(4 downto 0);
    signal Read_port_info : std_logic;

    -- Clock period definitions
    constant clk_period : time := 10 ns;

BEGIN

        -- Instantiate the Unit Under Test (UUT)
    uut: main PORT MAP (
           iData_av => iData_av,
           iRd_data => iRd_data,
           iData => iData,
           Input_Port => Input_Port,
           Opcode => Opcode,
           Rd_opcode => Rd_opcode,
           CFM_information => CFM_information,
           CFM_Sequence_number => CFM_Sequence_number,
           CFM_Output_port => CFM_Output_port,
           Gen_CFM => Gen_CFM,
           CFM_sent => CFM_sent,
           Wr_Sequence_number => Wr_Sequence_number,
           Wr_output_port => Wr_output_port,
           Send_wr_ACK => Send_wr_ACK,
           Ack_sent => Ack_sent,
           MAC => MAC,
           oData_av => oData_av,
           oRd_data => oRd_data,
           oData => oData,
           Output_Port_mask => Output_Port_mask,
           Port_number => Port_number,
           Read_port_info => Read_port_info,
           Port_info => Port_info,
           Port_info_valid => Port_info_valid,
           clk => clk,
           Core_ports => Core_ports
         );

    -- Clock process definitions
    clk_process :process
    begin
                clk <= '0';
                wait for clk_period/2;
                clk <= '1';
                wait for clk_period/2;
    end process;


    -- Stimulus process
    stim_proc: process
    begin
       -- hold reset state for 100 ns.
       wait for 100 ns;

                --- giving some data
       iData_av <= '1';
                iData <= (others => '1');
                Input_Port <= (4|3|1 => '1', others => '0');
                Opcode <= "001";
                CFM_information <= (others => '0');
                CFM_Sequence_number <= (others => '0');
                CFM_Output_port <= (others => '0');
                Gen_CFM <= '0';
                Wr_Sequence_number <= (others => '0');
                Wr_output_port <= (others => '0');
                Send_wr_ACK <= '0';
                MAC <= (others => '1');
                oRd_data <= '0';
                Port_info <= (others => '0');
                Port_info_valid <= '0';
                Core_ports <= (12|13|14 => '1',  others => '0');
                ---giving data for 50 clk cycles
					 
                wait for clk_period;
					iData_av <= '1';
                iData <= (others => '1');
                Input_Port <= (4|3|1 => '1', others => '0');
                Opcode <= (others => '1');
                CFM_information <= (others => '0');
                CFM_Sequence_number <= (others => '0');
                CFM_Output_port <= (others => '0');
                Gen_CFM <= '0';
                Wr_Sequence_number <= (others => '0');
                Wr_output_port <= (others => '0');
                Send_wr_ACK <= '0';
                MAC <= (others => '1');
                oRd_data <= '1';
                Port_info <= (others => '0');
                Port_info_valid <= '0';
                Core_ports <= (12|13|14 => '1',  others => '0');

                wait for clk_period*5;
                ---giving end of data by putting all idata =0
                iData_av <= '1';
                iData <= (others => '0');
                Input_Port <= (4|3|1 => '1', others => '0');
                Opcode <= (others => '1');
                CFM_information <= (others => '0');
                CFM_Sequence_number <= (others => '0');
                CFM_Output_port <= (others => '0');
                Gen_CFM <= '0';
                Wr_Sequence_number <= (others => '0');
                Wr_output_port <= (others => '0');
                Send_wr_ACK <= '0';
                MAC <= (others => '1');
                oRd_data <= '1';
                Port_info <= (others => '0');
                Port_info_valid <= '0';
                Core_ports <= (12|13|14 => '1',  others => '0');

                wait for clk_period*2;

                --idata_av is closed and now we give port infos one by one
                -- This is done 32 times...

                iData_av <= '0';
                iData <= (others => '0');
                Input_Port <= (4|3|1 => '1', others => '0');
                Opcode <= (others => '1');
                CFM_information <= (others => '0');
                CFM_Sequence_number <= (others => '0');
                CFM_Output_port <= (others => '0');
                Gen_CFM <= '0';
                Wr_Sequence_number <= (others => '0');
                Wr_output_port <= (others => '0');
                Send_wr_ACK <= '0';
                MAC <= (others => '1');
                oRd_data <= '1';
                Port_info <= (others => '1');
                Port_info_valid <= '1';
                Core_ports <= (12|13|14 => '1',  others => '0');

                wait for clk_period*100;



wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '1');
Port_info_valid <= '1';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

iData_av <= '0';
iData <= (others => '0');
Input_Port <= (4|3|1 => '1', others => '0');
Opcode <= (others => '1');
CFM_information <= (others => '0');
CFM_Sequence_number <= (others => '0');
CFM_Output_port <= (others => '0');
Gen_CFM <= '0';
Wr_Sequence_number <= (others => '0');
Wr_output_port <= (others => '0');
Send_wr_ACK <= '0';
MAC <= (others => '1');
oRd_data <= '0';
Port_info <= (others => '0');
Port_info_valid <= '0';
Core_ports <= (12|13|14 => '1',  others => '0');

wait for clk_period*2;

                --- now I ask for the output
                iData_av <= '0';
                iData <= (others => '0');
                Input_Port <= (4|3|1 => '1', others => '0');
                Opcode <= (others => '1');
                CFM_information <= (others => '0');
                CFM_Sequence_number <= (others => '0');
                CFM_Output_port <= (others => '0');
                Gen_CFM <= '0';
                Wr_Sequence_number <= (others => '0');
                Wr_output_port <= (others => '0');
                Send_wr_ACK <= '0';
                MAC <= (others => '1');
                oRd_data <= '1';
                Port_info <= (others => '0');
                Port_info_valid <= '0';
                Core_ports <= (12|13|14 => '1',  others => '0');

       -- insert stimulus here

       wait;
    end process;

END;


