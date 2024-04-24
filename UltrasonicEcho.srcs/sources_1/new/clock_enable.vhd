----------------------------------------------------------------------------------
-- TEAM: Sensor
-- Engineer: Marek Karlicek, Jan Kriz, Tomas Kucera, Rauf Iusufov 
-- 
-- Create Date: 27.03.2024
-- Design Name: 
-- Module Name: clock_enable
-- Project Name: Parking Sensor system 
-- Target Devices: Nexys A7-50T 

-- Description: Clock divider module with enable signal, for generating trig pulses 
----------------------------------------------------------------------------------



-------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;

-------------------------------------------------

entity clock_enable is
    generic (
        PERIOD : integer := 3 --! Default number of clk periodes to generate one pulse
    );
    port (
        clk   : in    std_logic; --! Main clock
        rst   : in    std_logic; --! High-active synchronous reset
        pulse : out   std_logic  --! Clock enable pulse signal
    );
end entity clock_enable;

-------------------------------------------------

architecture behavioral of clock_enable is
    --! Local counter
    signal sig_count : integer range 0 to PERIOD - 1 := 0;
begin

    --! Count the number of clock pulses from zero to PERIOD-1.
    p_clk_enable : process (clk) is
    begin

        if (rising_edge(clk)) then                 -- Synchronous process
            if (rst = '1') then                    -- High-active reset
                sig_count <= 0;

            -- Counting
            elsif (sig_count < (PERIOD - 1)) then
                sig_count <= sig_count + 1;        -- Increment local counter

            -- End of counter reached
            else
                sig_count <= 0;
            end if;                                -- Each `if` must end by `end if`
        end if;

    end process p_clk_enable;

    -- Generated pulse is always one clock long
    pulse <= '1' when (sig_count > PERIOD / 2) else
             '0';

end architecture behavioral;