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
    distance <= to_integer(unsigned(inputNumber)) / 2915;

process (clk)
begin
  if(rising_edge(clk)) then
      if (distance >= 0 and distance <= 10) then
            leds <= "0000000000000001";
        elsif distance > 10 and distance <= 30 then
            leds <= "0000000000000011";
        elsif distance > 30 and distance <= 50 then
            leds <= "0000000000000111";
        elsif distance > 50 and distance <= 70 then
            leds <= "0000000000001111";
        elsif distance > 70 and distance <= 90 then
            leds <= "0000000000011111";
        elsif distance > 90 and distance <= 120 then
            leds <= "0000000000111111";
        else
            leds <= "1000000000000000";
        end if;
    end if;


end process;

  

end Behavioral;
