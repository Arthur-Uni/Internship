library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_generator is
    generic (   
                max_count_clock_division : integer := 50;
                max_count                : integer := 40
            );
    Port (      clk 		: in STD_LOGIC;
                areset_n 	: in STD_LOGIC;
                duty_cycle  : in STD_LOGIC_VECTOR (2 downto 0);
                pwm_out 	: out STD_LOGIC
            );
end pwm_generator;

architecture Behavioral of pwm_generator is
    
    signal clk_counter : integer range 0 to max_count_clock_division;
    signal clk_div :     std_logic;
    signal counter :     integer range 0 to max_count;
    
    begin
    
        process (clk, areset_n) is
            begin
                if areset_n = '0' then
                    clk_div <= '0';
                elsif rising_edge(clk) then
                    clk_div <= '0';
                    if (clk_counter = max_count_clock_division) then
                        clk_div <= '1';
                        clk_counter <= 0;
                    else
                        clk_counter <= clk_counter + 1;
                    end if;
                end if;
            end process;
            
        process (clk_div, areset_n) is
            begin
                if areset_n = '0' then
                    counter <= 0;
                elsif rising_edge(clk_div) then
                    if counter = max_count-1 then
                        counter <= 0;
                    else
                        counter <= counter + 1;
                    end if;
                end if;
            end process;
        
        pwm_out <= '1' when counter < to_integer(unsigned(duty_cycle)) else '0';
    
    end Behavioral;