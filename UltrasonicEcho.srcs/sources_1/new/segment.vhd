
library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.NUMERIC_STD.ALL;

entity segment is
    port (
        clear : in    std_logic;                    --! Clear the display
        seg   : out   std_logic_vector(6 downto 0);  --! Seven active-low segments from A to G

        clk : in STD_LOGIC;

        inputNumber : in STD_LOGIC_VECTOR (20 downto 0);

        AN : out std_logic_vector(2 downto 0)        --! Common Anode: AN0, AN1, AN2

    );
end entity segment;

-------------------------------------------------

architecture behavioral of segment is

    signal distance : integer := 0;
    signal counter : integer := 0;
    signal sig_AN : std_logic_vector(2 downto 0) := "110";
    signal bin : std_logic_vector(3 downto 0);    

begin
  
    -- Distance calculation, sound travels both ways but we need only one-way to be shown on display
    distance <= to_integer(unsigned(inputNumber)) / (2915 * 2);   
    --! speed of sound is 343m/s, so 1 pulse is 0.01715cm
    --! sound needs to travel to the object and back, so the distance is divided by 2


    process (clk)
    begin
        if rising_edge(clk) then
           counter <= counter + 1; -- counter for multiplexing

           if counter = 2000 then -- 2000 cycles = 100e6/2000 = 50kHz
               counter <= 0; -- reset counter
               if sig_AN = "110" then -- if last digit was displayed
                    sig_AN <= "101"; -- display middle digit
                      bin <= std_logic_vector(to_unsigned(distance/10 - (distance/100)*10 , 4));
               elsif sig_AN = "101" then -- if middle digit was displayed
                    sig_AN <= "011"; -- display first digit
                     bin <= std_logic_vector(to_unsigned(distance/100, 4));
               elsif sig_AN = "011" then -- if first digit was displayed
                    sig_AN <= "110"; -- display last digit
                    bin <= std_logic_vector(to_unsigned(distance mod 10, 4));
               end if;

               if distance > 200 then
                   bin <= "0000"; -- when out of range, the display shows zeros
               end if;
           end if;
        end if;
        
        AN <= sig_AN;
    end process;


    --! This combinational process decodes binary input
    --! `bin` into 7-segment display output `seg` for a
    --! Common Anode configuration. When either `bin` or
    --! `clear` changes, the process is triggered. Each
    --! bit in `seg` represents a segment from A to G.
    --! The display is cleared if `clear` is set to 1.
    p_7seg_decoder : process (bin, clear) is
    begin

        if (clear = '1') then
            seg <= "1111111";  -- Clear the display
        else

            case bin is

                when x"0" =>
                    seg <= "0000001";

                when x"1" =>
                    seg <= "1001111";


                when x"2" =>
                    seg <= "0010010";

                when x"3" =>
                    seg <= "0000110";

                when x"4" =>
                    seg <= "1001100";

                when x"5" =>
                    seg <= "0100100";

                when x"6" =>
                    seg <= "0100000";

                when x"7" =>
                    seg <= "0001111";

                when x"8" =>
                    seg <= "0000000";


                when x"9" =>
                    seg <= "0000100";

                when x"A" =>
                    seg <= "0001000";

                when x"b" =>
                    seg <= "1100000";

                when x"C" =>
                    seg <= "0110001";

                when x"d" =>
                    seg <= "1000010";

                when x"E" =>
                    seg <= "0110000";

                when others =>
                    seg <= "0111000";

            end case;

        end if;

    end process p_7seg_decoder;

end architecture behavioral;
