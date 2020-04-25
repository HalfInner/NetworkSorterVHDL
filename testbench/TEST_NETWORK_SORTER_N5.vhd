--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   16:40:05 04/25/2020
-- Design Name:
-- Module Name:   /home/halfsinner/NetworkSorterVHDL/testbench/TEST_NETWORK_SORTER_N5.vhd
-- Project Name:  FPGA_learn
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: NETWORK_SORTER_N5
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

library ieee;
  use ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

entity TEST_NETWORK_SORTER_N5 is
end entity TEST_NETWORK_SORTER_N5;

architecture BEHAVIOR of TEST_NETWORK_SORTER_N5 is

  -- Component Declaration for the Unit Under Test (UUT)

  component NETWORK_SORTER_N5 is
    port (
      VALUE_0      : in    std_logic_vector(3 downto 0);
      VALUE_1      : in    std_logic_vector(3 downto 0);
      VALUE_2      : in    std_logic_vector(3 downto 0);
      VALUE_3      : in    std_logic_vector(3 downto 0);
      VALUE_4      : in    std_logic_vector(3 downto 0);

      VALUE_SORT_0 : out   std_logic_vector(3 downto 0);
      VALUE_SORT_1 : out   std_logic_vector(3 downto 0);
      VALUE_SORT_2 : out   std_logic_vector(3 downto 0);
      VALUE_SORT_3 : out   std_logic_vector(3 downto 0);
      VALUE_SORT_4 : out   std_logic_vector(3 downto 0);

      CLK          : in    std_logic;
      RST          : in    std_logic
    );
  end component;

  --Inputs
  signal value_0      : std_logic_vector(3 downto 0) := (others => '0');
  signal value_1      : std_logic_vector(3 downto 0) := (others => '0');
  signal value_2      : std_logic_vector(3 downto 0) := (others => '0');
  signal value_3      : std_logic_vector(3 downto 0) := (others => '0');
  signal value_4      : std_logic_vector(3 downto 0) := (others => '0');
  signal clk          : std_logic := '0';
  signal rst          : std_logic := '0';

  --Outputs
  signal value_sort_0 : std_logic_vector(3 downto 0);
  signal value_sort_1 : std_logic_vector(3 downto 0);
  signal value_sort_2 : std_logic_vector(3 downto 0);
  signal value_sort_3 : std_logic_vector(3 downto 0);
  signal value_sort_4 : std_logic_vector(3 downto 0);

  -- Clock period definitions
  constant clk_period : time := 10 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  UUT : NETWORK_SORTER_N5
    port map (
      VALUE_0      => value_0,
      VALUE_1      => value_1,
      VALUE_2      => value_2,
      VALUE_3      => value_3,
      VALUE_4      => value_4,

      VALUE_SORT_0 => value_sort_0,
      VALUE_SORT_1 => value_sort_1,
      VALUE_SORT_2 => value_sort_2,
      VALUE_SORT_3 => value_sort_3,
      VALUE_SORT_4 => value_sort_4,

      CLK          => clk,
      RST          => rst
    );

  clk <= not clk after clk_period / 2;

  -- Stimulus process
  STIM_PROC : process
  begin

    wait for 100ns;

    -- full iteration begin
    -- sorted asceding
    value_0 <= X"0";
    value_1 <= X"1";
    value_2 <= X"2";
    value_3 <= X"3";
    value_4 <= X"4";
    wait for 10 ns;

    rst <= '1';
    wait for 10 ns;

    rst <= '0';
    wait for clk_period * 10;
    -- full iteration end

    -- full iteration begin
    -- sorted descending
    value_0 <= X"F";
    value_1 <= X"E";
    value_2 <= X"D";
    value_3 <= X"C";
    value_4 <= X"B";
    wait for 10 ns;

    rst <= '1';
    wait for 10 ns;

    rst <= '0';
    wait for clk_period * 10;
    -- full iteration end

    -- full iteration begin
    -- first element not sorted
    value_0 <= X"F";
    value_1 <= X"0";
    value_2 <= X"1";
    value_3 <= X"2";
    value_4 <= X"3";
    wait for 10 ns;

    rst <= '1';
    wait for 10 ns;

    rst <= '0';
    wait for clk_period * 10;
    -- full iteration end

    -- full iteration begin
    -- last element not sorted
    value_0 <= X"B";
    value_1 <= X"C";
    value_2 <= X"D";
    value_3 <= X"E";
    value_4 <= X"0";
    wait for 10 ns;

    rst <= '1';
    wait for 10 ns;

    rst <= '0';
    wait for clk_period * 10;
    -- full iteration end

    -- full iteration begin
    -- shuffled
    value_0 <= X"4";
    value_1 <= X"2";
    value_2 <= X"C";
    value_3 <= X"6";
    value_4 <= X"9";
    wait for 10 ns;

    rst <= '1';
    wait for 10 ns;

    rst <= '0';
    wait for clk_period * 10;
    -- full iteration end

    wait;

  end process STIM_PROC;

end architecture BEHAVIOR;
