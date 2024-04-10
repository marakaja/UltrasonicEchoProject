-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 3.4.2024 07:28:43 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_toplevel is
end tb_toplevel;

architecture tb of tb_toplevel is

    component toplevel
        port (CLK100MHZ : in std_logic;
              LED       : out std_logic_vector (15 downto 0);
              TRIG      : out std_logic;
              ECHO      : in std_logic);
    end component;

    signal CLK100MHZ : std_logic;
    signal LED       : std_logic_vector (15 downto 0);
    signal TRIG      : std_logic;
    signal ECHO      : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : toplevel
    port map (CLK100MHZ => CLK100MHZ,
              LED       => LED,
              TRIG      => TRIG,
              ECHO      => ECHO);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK100MHZ is really your main clock signal
    CLK100MHZ <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        wait for 100 ns;
        ECHO <= '0';
        wait for 50 ns;
         ECHO <= '1';
        wait for 50 ns;
       ECHO <= '0';
 

        -- EDIT Add stimuli here
        wait for 1000000000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_toplevel of tb_toplevel is
    for tb
    end for;
end cfg_tb_toplevel;