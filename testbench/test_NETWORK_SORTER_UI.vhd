--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:50:49 04/26/2020
-- Design Name:   
-- Module Name:   /home/halfsinner/FPGA_learn/test_NETWORK_SORTER_UI.vhd
-- Project Name:  FPGA_learn
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: NETOWRK_SORTER_UI
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_NETWORK_SORTER_UI IS
END test_NETWORK_SORTER_UI;
 
ARCHITECTURE behavior OF test_NETWORK_SORTER_UI IS 
 
    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT NETOWRK_SORTER_UI
    PORT(
         UART_TX : OUT  std_logic;
         UART_RX : IN  std_logic;
         LED_CONTROL : OUT  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic
        );
    END COMPONENT;


    --Inputs
    signal UART_RX : std_logic := '0';
    signal CLK : std_logic := '0';
    signal RST : std_logic := '0';

    --Outputs
    signal UART_TX : std_logic;
    signal LED_CONTROL : std_logic;

    -- Clock period definitions
    constant CLK_period : time := 10 ns;
 
    constant c_BIT_PERIOD : time := 30 ns; 

    signal byte_tmp  : std_logic_vector(7 downto 0);
    -- Low-level byte-write
    procedure UART_WRITE_BYTE (
    i_data_in       : in  std_logic_vector(7 downto 0);
    signal o_serial : out std_logic) is
    begin

    -- Send Start Bit
    o_serial <= '0';
    wait for c_BIT_PERIOD;

    -- Send Data Byte
    for ii in 0 to 7 loop
      o_serial <= i_data_in(ii);
      wait for c_BIT_PERIOD;
    end loop;  -- ii

    -- Send Stop Bit
    o_serial <= '1';
    wait for c_BIT_PERIOD;
    end UART_WRITE_BYTE;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: NETOWRK_SORTER_UI PORT MAP (
          UART_TX => UART_TX,
          UART_RX => UART_RX,
          LED_CONTROL => LED_CONTROL,
          CLK => CLK,
          RST => not RST
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
    RST <= '1';
    wait for 100ns;
 -- Tell the UART to send a command.
    RST <= '0';
    wait until rising_edge(CLK);
    wait until rising_edge(CLK);
 
     
    -- Send a command to the UART
    UART_WRITE_BYTE(X"AA", UART_RX);
    wait until rising_edge(CLK);
    
    UART_WRITE_BYTE(X"AA", UART_RX);
    wait until rising_edge(CLK);
    
    UART_WRITE_BYTE(X"AA", UART_RX);
    wait until rising_edge(CLK);
    
    UART_WRITE_BYTE(X"AA", UART_RX);
    wait until rising_edge(CLK);

    UART_WRITE_BYTE(X"AA", UART_RX);
    wait until rising_edge(CLK);

    wait;
   end process;

END;
