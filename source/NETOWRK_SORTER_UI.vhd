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
  use ieee.numeric_std.all;

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
    INIT, READ_VALUE,
    SORT, WRITE_VALUE,
    UNDEFINED
  );

  signal fsm_ui           : fsm_ui_type := INIT;

  --  signal blinking_raw : std_logic_vector(7 downto 0) := "00000000";
  signal tx_dv_off        : std_logic;
  signal tx_byte          : std_logic_vector(7 downto 0);
  signal tx_active        : std_logic;
  signal tx_done          : std_logic;

  signal tmp_byte         : std_logic_vector(7 downto 0);
  signal i_bus            : std_logic_vector(19 downto 0) := X"00000";
  signal o_bus            : std_logic_vector(19 downto 0) := X"00000";

  signal receive_done     : std_logic;

  signal sorter_running   : std_logic := '1';

  signal tx_running_clock : std_logic := '0';
  signal rx_running_clock : std_logic := '0';
  signal rx_uart_clk      : std_logic := '0';

begin

  uart_tx_module : entity work.UART_TX port map (
      I_CLK       => CLK,
      I_TX_DV     => tx_dv_off,
      I_TX_BYTE   => tx_byte,
      O_TX_ACTIVE => tx_active,
      O_TX_SERIAL => UART_TX,
      O_TX_DONE   => tx_done
    );

  uart_rx_module : entity work.UART_RX port map (
      I_CLK       => rx_uart_clk,
      I_RX_SERIAL => UART_RX,
      O_RX_DV     => receive_done,
      O_RX_BYTE   => tmp_byte
    );

  network_sorter : entity work.NETWORK_SORTER_N5 port map (
      VALUE_0           => i_bus(19 downto 16),
      VALUE_1           => i_bus(15 downto 12),
      VALUE_2           => i_bus(11 downto 8),
      VALUE_3           => i_bus(7 downto 4),
      VALUE_4           => i_bus(3 downto 0),

      VALUE_SORT_0      => o_bus(19 downto 16),
      VALUE_SORT_1      => o_bus(15 downto 12),
      VALUE_SORT_2      => o_bus(11 downto 8),
      VALUE_SORT_3      => o_bus(7 downto 4),
      VALUE_SORT_4      => o_bus(3 downto 0),

      CLK               => CLK,
      RST               => sorter_running
    );

  process (CLK, RST, UART_RX, tmp_byte) is

    variable counter : integer := 0;

  begin

    LED_CONTROL <= NOT UART_RX;
    rx_uart_clk <= CLK and rx_running_clock;

    if (RST = '1') then
      tx_dv_off        <= '0';
      sorter_running   <= '1';
      rx_running_clock <= '0';
      counter := 0;
      tmp_byte  <= X"00";
      fsm_ui    <= INIT;
    elsif (CLK'event and CLK = '1') then

      case fsm_ui is

        when INIT =>
          counter := 0;
          fsm_ui           <= READ_VALUE;
          rx_running_clock <= '1';
        when READ_VALUE =>
          if (receive_done = '1') then
            i_bus             <= i_bus(19 downto 4) & X"0"; -- shift left - problem with shl
            i_bus(3 downto 0) <= tmp_byte(3 downto 0);      -- fill 4 LSB
            counter := counter + 1;
          end if;
          if (counter = 4) then
            counter := 0;
            fsm_ui <= SORT;
          end if;

        when SORT =>
          -- SORTING
          sorter_running <= '0';
          counter := counter + 1;
          if (counter > 6) then
            tx_running_clock <= '1';
            counter := 0;
            fsm_ui <= WRITE_VALUE;
          end if;
        when WRITE_VALUE =>
          sorter_running <= '1';
          if (tx_dv_off = '0' and tx_active = '0') then
            tx_byte <= X"0" & o_bus(19 downto 16);
            o_bus   <= o_bus(19 downto 4) & X"0";           -- shift left - problem with shl
            --            o_bus <= std_logic_vector(shift_left(unsigned(o_bus), 4));
            tx_dv_off <= '1';
          else
            tx_dv_off <= '0';
          end if;

          if (tx_done = '1') then
            counter := counter + 1;
          end if;

          if (counter = 4) then
            tx_running_clock <= '1';
            fsm_ui           <= INIT;
          end if;
        when others =>
          fsm_ui <= INIT;

      end case;

    end if;

  end process;

end architecture BEHAVIORAL;

