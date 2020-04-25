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

library ieee;
  use ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

entity TEST_LED_BLINKING is
end entity TEST_LED_BLINKING;

architecture BEHAVIOR of TEST_LED_BLINKING is

  -- Component Declaration for the Unit Under Test (UUT)

  component LED_BLINKING is
    port (
      CLK : in    std_logic;
      LED : out   std_logic_vector(7 downto 0);
      SW1 : in    std_logic;
      SW2 : in    std_logic
    );
  end component;

  --Inputs
  signal clk : std_logic := '0';
  signal sw1 : std_logic := '0';
  signal sw2 : std_logic := '0';

  --Outputs
  signal led : std_logic_vector(7 downto 0);

  -- Clock period definitions
  constant clk_period : time := 10 ns;
  constant reset_time : time := 100 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  UUT : LED_BLINKING
    port map (
      CLK => clk,
      LED => led,
      SW1 => not sw1,
      SW2 => not sw2
    );

  -- Clock process definitions
  CLK_PROCESS : process
  begin

    clk <= '0';
    wait for clk_period / 2;
    clk <= '1';
    wait for clk_period / 2;

  end process CLK_PROCESS;

  -- Stimulus process
  STIM_PROC : process
  begin

    -- hold reset state for 100 ns.
    wait for reset_time;
    sw1 <= '0';
    sw2 <= '0';

    wait for clk_period * 10;
    sw1 <= '1';
    sw2 <= '1';

    wait for clk_period * 10;
    sw1 <= '0';
    sw2 <= '0';

    wait for clk_period * 10;
    sw1 <= '0';
    sw2 <= '1';

    wait for clk_period * 10;
    sw1 <= '0';
    sw2 <= '0';

    wait for clk_period * 10;
    sw1 <= '1';
    sw2 <= '1';

    wait for clk_period * 10;
    sw1 <= '0';
    sw2 <= '0';

    wait for clk_period * 10;
    sw1 <= '1';
    sw2 <= '0';

    wait for clk_period * 10;
    sw1 <= '1';
    sw2 <= '1';

    wait;

  end process STIM_PROC;

end architecture BEHAVIOR;
