--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:01:14 04/20/2020
-- Design Name:   
-- Module Name:   /home/halfsinner/FPGA_learn/test_led_blinking.vhd
-- Project Name:  FPGA_learn
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: led_blinking
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
 
ENTITY test_led_blinking IS
END test_led_blinking;
 
ARCHITECTURE behavior OF test_led_blinking IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT led_blinking
    PORT(
         Clk : IN  std_logic;
         LED : OUT  std_logic_vector(7 downto 0);
         SW1 : IN  std_logic;
         SW2 : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal SW1 : std_logic := '0';
   signal SW2 : std_logic := '0';

 	--Outputs
   signal LED : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
   constant reset_time : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: led_blinking PORT MAP (
          Clk => Clk,
          LED => LED,
          SW1 => not SW1,
          SW2 => not SW2
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for reset_time;	
      SW1 <= '0';
      SW2 <= '0';
      
      wait for Clk_period * 10;	
      SW1 <= '1';
      SW2 <= '1';
      
      wait for Clk_period * 10;	
      SW1 <= '0';
      SW2 <= '0';
      
      wait for Clk_period * 10;	
      SW1 <= '0';
      SW2 <= '1';
      
      wait for Clk_period * 10;	
      SW1 <= '0';
      SW2 <= '0';
      
      wait for Clk_period * 10;	
      SW1 <= '1';
      SW2 <= '1';

      wait for Clk_period * 10;	
      SW1 <= '0';
      SW2 <= '0';
      
      wait for Clk_period * 10;	
      SW1 <= '1';
      SW2 <= '0';

      
      wait for Clk_period * 10;	
      SW1 <= '1';
      SW2 <= '1';
      
      wait;
   end process;

END;
