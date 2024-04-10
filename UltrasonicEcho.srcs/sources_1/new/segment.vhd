----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2024 09:31:18
-- Design Name: 
-- Module Name: segment - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity bin2seg_multi is
    port (
        clear : in    std_logic;                    -- Clear all displays
        bin   : in    std_logic_vector(6 downto 0); -- Binary representation of decimal number (0 to 100)
        seg   : out   std_logic_vector(20 downto 0) -- Seven active-low segments from A to G for each display
    );
end entity bin2seg_multi;

architecture behavioral of bin2seg_multi is
    component bin2seg is
        port (
            clear : in    std_logic;                    -- Clear the display
            bin   : in    std_logic_vector(3 downto 0); -- Binary representation of one hexadecimal symbol
            seg   : out   std_logic_vector(6 downto 0)  -- Seven active-low segments from A to G
        );
    end component;

    -- Signals for segments of each display
    signal display_0, display_1, display_2 : std_logic_vector(6 downto 0) := (others => '0');

    -- Binary representation of numbers 0 to 9
    constant BIN_0   : std_logic_vector(3 downto 0) := "0000";
    constant BIN_1   : std_logic_vector(3 downto 0) := "0001";
    constant BIN_2   : std_logic_vector(3 downto 0) := "0010";
    constant BIN_3   : std_logic_vector(3 downto 0) := "0011";
    constant BIN_4   : std_logic_vector(3 downto 0) := "0100";
    constant BIN_5   : std_logic_vector(3 downto 0) := "0101";
    constant BIN_6   : std_logic_vector(3 downto 0) := "0110";
    constant BIN_7   : std_logic_vector(3 downto 0) := "0111";
    constant BIN_8   : std_logic_vector(3 downto 0) := "1000";
    constant BIN_9   : std_logic_vector(3 downto 0) := "1001";

    -- Binary representation of numbers 10 to 100
    constant BIN_10  : std_logic_vector(3 downto 0) := "1010";
    constant BIN_20  : std_logic_vector(3 downto 0) := "1011";
    constant BIN_30  : std_logic_vector(3 downto 0) := "1100";
    constant BIN_40  : std_logic_vector(3 downto 0) := "1101";
    constant BIN_50  : std_logic_vector(3 downto 0) := "1110";
    constant BIN_60  : std_logic_vector(3 downto 0) := "1111";
    constant BIN_70  : std_logic_vector(3 downto 0) := "0000";
    constant BIN_80  : std_logic_vector(3 downto 0) := "0001";
    constant BIN_90  : std_logic_vector(3 downto 0) := "0010";
    constant BIN_100 : std_logic_vector(3 downto 0) := "0011";
    
    -- Counter to switch between displays
    signal counter : integer range 0 to 2 := 0;

begin

    -- Counter process to switch between displays
    counter_process : process
    begin
        wait until rising_edge(clk); -- Assuming you have a clock signal named clk

        if clear = '1' then
            counter <= 0; -- Reset the counter
        else
            if counter = 2 then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process counter_process;

    -- Display selection logic
    display_selection : process(bin, counter)
    begin
        case counter is
            when 0 =>
                -- Display 0
                display_0_decoder : bin2seg
                    port map (
                        clear => clear,
                        bin   => bin(6 downto 4),
                        seg   => display_0
                    );
                display_1 <= (others => '0');
                display_2 <= (others => '0');
            when 1 =>
                -- Display 1
                display_1_decoder : bin2seg
                    port map (
                        clear => clear,
                        bin   => bin(3 downto 1),
                        seg   => display_1
                    );
                display_0 <= (others => '0');
                display_2 <= (others => '0');
            when 2 =>
                -- Display 2
                display_2_decoder : bin2seg
                    port map (
                        clear => clear,
                        bin   => bin(0),
                        seg   => display_2
                    );
                display_0 <= (others => '0');
                display_1 <= (others => '0');
            when others =>
                -- Do nothing
                display_0 <= (others => '0');
                display_1 <= (others => '0');
                display_2 <= (others => '0');
        end case;
    end process display_selection;

    -- Output the segments for each display
    seg <= display_2 & display_1 & display_0;

end architecture behavioral;

