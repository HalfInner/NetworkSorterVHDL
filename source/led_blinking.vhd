----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    03:12:32 04/19/2020
-- Design Name:
-- Module Name:    led_blinking - Behavioral
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
  use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LED_BLINKING is
  port (
    CLK : in    std_logic;
    LED : out   std_logic_vector(7 downto 0);
    SW1 : in    std_logic;
    SW2 : in    std_logic
  );
end entity LED_BLINKING;

architecture BEHAVIORAL of LED_BLINKING is

  --constant COUNTER_MAX : integer := 5000000;
  signal counter      : unsigned(3 downto 0);
  constant counter_max : integer := 10;
  signal blinking_raw : std_logic_vector(7 downto 0) := "00000000";
  signal blinking_out : std_logic_vector(7 downto 0) := "00000000";

begin

  process (Clk) is
  begin

    if (Clk'event and Clk = '1') then
      if (counter >= counter_max) then
        counter      <= counter xor counter;
        blinking_raw <= not blinking_raw;
      else
        counter <= counter + 1;
      end if;

      blinking_out <= blinking_raw;
      if (not SW1 = '1') and (not SW2 = '1') then
        blinking_out <= blinking_out or b"00000001";
      end if;
    end if;

  end process;

  --LED <= blinking_out;
  LED <= X"0" & STD_LOGIC_VECTOR(counter);

end architecture BEHAVIORAL;
