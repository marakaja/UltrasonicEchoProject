library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;

entity LEDcontrol is
    Port ( inputNumber : in STD_LOGIC_VECTOR (20 downto 0);
           leds : out STD_LOGIC_VECTOR (15 downto 0);
           clk : in std_logic
           );
end LEDcontrol;

architecture Behavioral of LEDcontrol is

    signal distance : integer := 0;
    
begin
    -- Distance sound needed to travel both ways
    distance <= to_integer(unsigned(inputNumber)) / 2915; 
process (clk)
begin
  if(rising_edge(clk)) then
      if (distance >= 0 and distance <= 10) then -- the closer you are, the more LEDs lights up
            leds <= "0111111111111111";
        elsif distance > 10 and distance <= 15 then
            leds <= "0111111111111110";
        elsif distance > 15 and distance <= 20 then
            leds <= "0111111111111100";
        elsif distance > 20 and distance <= 25 then
            leds <= "0111111111111000";
        elsif distance > 30 and distance <= 35 then
            leds <= "0111111111110000";
        elsif distance > 35 and distance <= 40 then
            leds <= "0111111111100000";
        elsif distance > 40 and distance <= 50 then
            leds <= "0111111111000000";
        elsif distance > 50 and distance <= 60 then
            leds <= "0111111110000000";
        elsif distance > 60 and distance <= 70 then
            leds <= "0111111100000000";
        elsif distance > 70 and distance <= 80 then
            leds <= "0111111000000000";
        elsif distance > 80 and distance <= 90 then
            leds <= "0111110000000000";
        elsif distance > 90 and distance <= 100 then
            leds <= "0111100000000000";
        elsif distance > 100 and distance <= 120 then
            leds <= "0111000000000000";
        elsif distance > 120 and distance <= 160 then
            leds <= "0110000000000000";
        elsif distance > 160 and distance <= 200 then
            leds <= "0100000000000000";
        
        else
            leds <= "1000000000000000";  -- if object is out of range, only 1 LED(first from left) is on
        end if;
    end if;


end process;

  

end Behavioral;
