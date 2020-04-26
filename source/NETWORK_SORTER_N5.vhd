----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    15:11:12 04/25/2020
-- Design Name:
-- Module Name:    network_sorter_n5 - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NETWORK_SORTER_N5 is
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
end entity NETWORK_SORTER_N5;

architecture BEHAVIORAL of NETWORK_SORTER_N5 is

  type fsm_sorter_type is (
    WAIT_FOR_INPUT,
    SORT_PART_1, SORT_PART_2, SORT_PART_3, SORT_PART_4, SORT_PART_5, SORT_PART_6,
    FINISHED,
    UNDEFINED
  );

  signal fsm_sorter : fsm_sorter_type;

  shared variable v0_raw : integer;
  shared variable v1_raw : integer;
  shared variable v2_raw : integer;
  shared variable v3_raw : integer;
  shared variable v4_raw : integer;

begin

  process (CLK, RST) is

    variable tmp : integer;

  begin

    if (RST = '1') then
      fsm_sorter <= WAIT_FOR_INPUT;
    elsif (CLK'event and CLK = '1') then

      case fsm_sorter is

        when WAIT_FOR_INPUT => -- read input
          v0_raw := to_integer(unsigned(VALUE_0));
          v1_raw := to_integer(unsigned(VALUE_1));
          v2_raw := to_integer(unsigned(VALUE_2));
          v3_raw := to_integer(unsigned(VALUE_3));
          v4_raw := to_integer(unsigned(VALUE_4));
          fsm_sorter <= SORT_PART_1;

        when SORT_PART_1 =>    -- [[0,1],[3,4]]
          if (v0_raw > v1_raw) then
            tmp    := v0_raw;
            v0_raw := v1_raw;
            v1_raw := tmp;
          end if;
          if (v3_raw > v4_raw) then
            tmp    := v3_raw;
            v3_raw := v4_raw;
            v4_raw := tmp;
          end if;
          fsm_sorter <= SORT_PART_2;

        when SORT_PART_2 =>    -- [[2,4]]
          if (v2_raw > v4_raw) then
            tmp    := v2_raw;
            v2_raw := v4_raw;
            v4_raw := tmp;
          end if;
          fsm_sorter <= SORT_PART_3;

        when SORT_PART_3 =>    -- [[2,3],[1,4]]
          if (v2_raw > v3_raw) then
            tmp    := v2_raw;
            v2_raw := v3_raw;
            v3_raw := tmp;
          end if;
          if (v1_raw > v4_raw) then
            tmp    := v1_raw;
            v1_raw := v4_raw;
            v4_raw := tmp;
          end if;
          fsm_sorter <= SORT_PART_4;

        when SORT_PART_4 =>    -- [[0,3]]
          if (v0_raw > v3_raw) then
            tmp    := v0_raw;
            v0_raw := v3_raw;
            v3_raw := tmp;
          end if;
          fsm_sorter <= SORT_PART_5;

        when SORT_PART_5 =>    -- [[0,2],[1,3]]
          if (v0_raw > v2_raw) then
            tmp    := v0_raw;
            v0_raw := v2_raw;
            v2_raw := tmp;
          end if;
          if (v1_raw > v3_raw) then
            tmp    := v1_raw;
            v1_raw := v3_raw;
            v3_raw := tmp;
          end if;
          fsm_sorter <= SORT_PART_6;

        when SORT_PART_6 =>    -- [[1,2]]
          if (v1_raw > v2_raw) then
            tmp    := v1_raw;
            v1_raw := v2_raw;
            v2_raw := tmp;
          end if;
          fsm_sorter <= FINISHED;
        when FINISHED =>       -- write input
          VALUE_SORT_0 <= STD_LOGIC_VECTOR(to_unsigned(v0_raw, VALUE_SORT_0'length));
          VALUE_SORT_1 <= STD_LOGIC_VECTOR(to_unsigned(v1_raw, VALUE_SORT_1'length));
          VALUE_SORT_2 <= STD_LOGIC_VECTOR(to_unsigned(v2_raw, VALUE_SORT_2'length));
          VALUE_SORT_3 <= STD_LOGIC_VECTOR(to_unsigned(v3_raw, VALUE_SORT_3'length));
          VALUE_SORT_4 <= STD_LOGIC_VECTOR(to_unsigned(v4_raw, VALUE_SORT_4'length));
          fsm_sorter   <= FINISHED;
        when others =>
          fsm_sorter <= UNDEFINED;

      end case;

    end if;

  end process;

end architecture BEHAVIORAL;

