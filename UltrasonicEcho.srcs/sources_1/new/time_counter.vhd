----------------------------------------------------------------------------------
-- TEAM: Sensor
-- Engineer: Marek Karlicek, Jan Kriz, Tomas Kucera, Rauf Iusufov 
-- 
-- Create Date: 27.03.2024
-- Design Name: 
-- Module Name: time_counter
-- Project Name: Parking Sensor system 
-- Target Devices: Nexys A7-50T 

-- Description: Time counter for pulse lenght measurement, 21-bit counter 
----------------------------------------------------------------------------------


library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all; -- Package for data types conversion


    entity time_counter is
    
    port (
        clk   : in    std_logic;                          --! Main clock
        rst   : in    std_logic;                          --! High-active synchronous reset
        en    : in    std_logic;                          --! Clock enable input
        count : out   std_logic_vector(20 downto 0); --! Counter value
        latch : in      std_logic
    );
end entity time_counter;

-------------------------------------------------

architecture behavioral of time_counter is
    --! Local counter
    signal sig_count : integer range 0 to (2 ** 21 - 1) := 0;
    signal sig_last_latch : std_logic := '0';
begin

    --! Clocked process with synchronous reset which implements
    --! N-bit up counter.
    time_counter : process (clk) is
    begin

        if (rising_edge(clk)) then
            -- Synchronous, active-high     
            if (rst = '1') then
                sig_count <= 0;

            -- Clock enable activated
            elsif (en = '1') then
                -- Test the maximum value
                if (sig_count < (2 ** 21 - 1)) then
                    sig_count <= sig_count + 1;
                end if;
                
                if (latch = '1' and sig_last_latch = '0') then -- Test begin of pulse
                    sig_count <= 0;
                elsif (latch = '0' and sig_last_latch = '1') then -- Test end of pulse
                    -- Assign internal register to output
                    count <= std_logic_vector(to_unsigned(sig_count, 21));
                end if;
            end if;

            sig_last_latch <= latch;         
        end if;

    end process time_counter;

end architecture behavioral;