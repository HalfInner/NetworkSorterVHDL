--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:15:08 04/27/2020
-- Design Name:   
-- Module Name:   /home/halfsinner/NetworkSorterVHDL/testbench/TEST_NETWORK_SORTER_B4_COMPARATOR.vhd
-- Project Name:  FPGA_learn
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: NETWORK_SORTER_B4_COMPARATOR
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
 
ENTITY TEST_NETWORK_SORTER_B4_COMPARATOR IS
END TEST_NETWORK_SORTER_B4_COMPARATOR;
 
ARCHITECTURE behavior OF TEST_NETWORK_SORTER_B4_COMPARATOR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT NETWORK_SORTER_B4_COMPARATOR
    PORT(
         I_VALUE_A : IN  std_logic_vector(3 downto 0);
         I_VALUE_A : IN  std_logic_vector(3 downto 0);
         O_MIN : OUT  std_logic_vector(3 downto 0);
         O_MAX : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal R_VALUE_A : std_logic_vector(3 downto 0) := (others => '0');
   signal R_VALUE_B : std_logic_vector(3 downto 0) := (others => '0');
   
   signal R_MIN : std_logic_vector(3 downto 0) := (others => '0');
   signal R_MAX : std_logic_vector(3 downto 0) := (others => '0');

 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: NETWORK_SORTER_B4_COMPARATOR PORT MAP (
          I_VALUE_A => R_VALUE_A,
          I_VALUE_A => R_VALUE_B,
          O_MIN => R_MIN,
          O_MAX => R_MAX
        );

   -- Clock process definitions

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      
      VALUE_B <= X"9";
      VALUE_A <= VALUE_B;
      wait for 5 ns;	
      assert MIN <= MAX report "MIN must be less or equal to MAX" severity error;
      
      VALUE_A <= X"2";
      wait for 5 ns;	
      assert VALUE_A = MIN report "Value must MIN" severity error;
      assert MIN <= MAX report "MIN must be less or equal to MAX" severity error;
      
      VALUE_A <= X"C";
      wait for 5 ns;	      
      assert VALUE_A = MAX report "Value must MAX" severity error;
      assert MIN <= MAX report "MIN must be less or equal to MAX" severity error;

      wait;
   end process;

END;
