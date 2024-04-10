----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2024 09:22:18
-- Design Name: 
-- Module Name: toplevel - Behavioral
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
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevel is
 port (
    CLK100MHZ : in std_logic;

    LED : out std_logic_vector(15 downto 0);
    
    TRIG : out std_logic;
    ECHO : in std_logic

 );
end toplevel;

architecture Behavioral of toplevel is
    -- Component declaration for simple counter
    component clock_enable is
        generic (
            PERIOD : integer--! Default number of clk periodes to generate one pulse
        );
        port (
            clk   : in    std_logic; --! Main clock
            rst   : in    std_logic; --! High-active synchronous reset
            pulse : out   std_logic  --! Clock enable pulse signal
        );
    end component;

    component time_counter is
        port (
            clk   : in    std_logic;                          --! Main clock
            rst   : in    std_logic;                          --! High-active synchronous reset
            en    : in    std_logic;                          --! Clock enable input
            count : out   std_logic_vector(20 downto 0);       --! Counter value
            latch : in      std_logic
        );
    end component;

    component LEDcontrol is
        Port ( inputNumber : in STD_LOGIC_VECTOR (20 downto 0);
        leds : out STD_LOGIC_VECTOR (15 downto 0);
        clk : in std_logic
        );
    end component LEDcontrol;
    
     signal last_echo_time_count : STD_LOGIC_VECTOR(20 downto 0);
     signal trig_res : std_logic;

begin
    --! Signal declaration
   
    led_control0 : component LEDcontrol
        port map (
            inputNumber => ( others => '0'),
            leds        => LED,
            clk         => CLK100MHZ
        );


    time_counter0 : component time_counter
        port map (
            clk   => CLK100MHZ,
            rst   => trig_res,
            en    => '1',
            count => last_echo_time_count,
            latch => ECHO
        );


    counter0 : component clock_enable
        generic map (
            PERIOD => 10000000
        )
        port map (
            clk      => CLK100MHZ,
            rst      => '0',
            pulse    => trig_res
        );
        
        TRIG <= trig_res;




end Behavioral;
