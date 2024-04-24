----------------------------------------------------------------------------------
-- TEAM: Sensor
-- Engineer: Marek Karlicek, Jan Kriz, Tomas Kucera, Rauf Iusufov 
-- 
-- Create Date: 27.03.2024 09:22:18
-- Design Name: 
-- Module Name: toplevel - Behavioral
-- Project Name: Parking Sensor system 
-- Target Devices: Nexys A7-50T 

-- Description: Top level module for Parking Sensor system 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity toplevel is
 port (
    CLK100MHZ : in std_logic; -- Main clock input from oscilator

    LED : out std_logic_vector(15 downto 0); -- LED bargraph output
    
    TRIG : out std_logic; -- Trigger signal for ultrasonic sensor
    ECHO : in std_logic; -- Echo signal from ultrasonic sensor

    -- Seven segment display output cathodes
    CA : out std_logic;
    CB : out std_logic;
    CC : out std_logic;
    CD : out std_logic;
    CE : out std_logic;
    CF : out std_logic;
    CG : out std_logic;
    DP : out std_logic;

    -- Seven segment display output anodes
    AN : out std_logic_vector(7 downto 0)
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
        Port (
            inputNumber : in STD_LOGIC_VECTOR (20 downto 0); -- Number from pulse lenght conter 
            leds : out STD_LOGIC_VECTOR (15 downto 0); -- LED bargraph output
            clk : in std_logic -- Main clock
        );
    end component LEDcontrol;

    component segment is 
        port (
            clear : in    std_logic;                    --! Clear the display
            seg   : out   std_logic_vector(6 downto 0);  --! Seven active-high segments from A to G
    
            clk : in STD_LOGIC; -- Main clock
    
            inputNumber : in STD_LOGIC_VECTOR (20 downto 0); -- Number from pulse lenght conter 

            AN : out STD_LOGIC_VECTOR (2 downto 0) -- Seven segment display output anodes (active low)
    
        );
      end component segment;
    
     signal last_echo_time_count : STD_LOGIC_VECTOR(20 downto 0); --! Last echo time count (1 pulse per 1/100e6 sec)
     signal trig_res : std_logic; --! Trigger signal for ultrasonic sensor

begin
    seg7 : component segment --! Seven segment display
        port map (
            clear => '0',
            seg(0) => CG,
            seg(1) => CF,
            seg(2) => CE,
            seg(3) => CD,
            seg(4) => CC,
            seg(5) => CB,
            seg(6) => CA,
            
            clk   => CLK100MHZ,
            inputNumber => last_echo_time_count, --! Number from pulse lenght counter
            AN(0) => AN(0),
            AN(1) => AN(1),
            AN(2) => AN(2)
             
        );
   
    led_control0 : component LEDcontrol --! LED bargraph 
        port map (
            inputNumber => last_echo_time_count,
            leds        => LED,
            clk         => CLK100MHZ
        );


    time_counter0 : component time_counter --! Counter clock pulses for echo pulse lenght
        port map (
            clk   => CLK100MHZ,
            rst   => trig_res,
            en    => '1',
            count => last_echo_time_count,
            latch => ECHO
        );


    counter0 : component clock_enable --! Clock division for trigger signal
        generic map (
            PERIOD => 10000000
        )
        port map (
            clk      => CLK100MHZ,
            rst      => '0',
            pulse    => trig_res
        );
        
        TRIG <= trig_res;

    DP <= '1';
    AN (7 downto 3) <= (others => '1');  

end Behavioral;
