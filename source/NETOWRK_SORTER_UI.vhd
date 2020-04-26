----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    18:44:04 04/25/2020
-- Design Name:
-- Module Name:    NETOWRK_SORTER_UI - Behavioral
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

entity NETOWRK_SORTER_UI is
  port (
    UART_TX            : out   std_logic;
    UART_RX            : in    std_logic;

    LED_CONTROL        : out   std_logic;

    CLK                : in    std_logic;
    RST                : in    std_logic
  );
end entity NETOWRK_SORTER_UI;

architecture BEHAVIORAL of NETOWRK_SORTER_UI is

  type fsm_ui_type is (
    READ_VALUE_1,
    READ_VALUE_2,
    READ_VALUE_3,
    READ_VALUE_4,
    READ_VALUE_5,
    SHOW_VALUE,
    UNDEFINED
  );

  signal fsm_ui          : fsm_ui_type;

  --  signal blinking_raw : std_logic_vector(7 downto 0) := "00000000";
  signal tx_dv_off       : std_logic;
  signal tx_byte_example : std_logic_vector(7 downto 0) := X"41"; -- 'A'
  signal tx_active       : std_logic;
  signal tx_done         : std_logic;

begin

  uart_tx_module : entity work.UART_TX port map (
      I_CLK       => CLK,
      I_TX_DV     => tx_dv_off,
      I_TX_BYTE   => tx_byte_example,
      O_TX_ACTIVE => tx_active,
      O_TX_SERIAL => UART_TX,
      O_TX_DONE   => tx_done
    );

  process (CLK, RST, UART_RX) is

    variable tmp : integer := 0;

  begin

    LED_CONTROL <= NOT UART_RX;

    if (RST = '1') then
      tx_dv_off <= '0';
      fsm_ui    <= SHOW_VALUE;
      tmp := 0;
    elsif (CLK'event and CLK = '1') then
      if (tx_dv_off = '0' and tx_active = '0') then
        tx_dv_off <= '1';
        tmp := 0;
      end if;
      if (tmp < 3) then
        tmp := tmp + 1;
      else
        tx_dv_off <= '0';
      end if;

      case fsm_ui is

        when SHOW_VALUE => -- read input
        when others =>
          fsm_ui <= SHOW_VALUE;

      end case;

    end if;

  end process;

end architecture BEHAVIORAL;

