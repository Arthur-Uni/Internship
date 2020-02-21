library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_generator is
    generic (   
                max_count_clock_division : integer := 25000; --divisor to slow down clock
                max_count                : integer := 40     --number of intervals of slowed down clock: for the robot hand this is always 40 because 20 ms / 0.5 ms = 40 and we count in 0.5 ms pulses
                -- the robot hand uses a pwm clock of 20 ms with pulses of 0.5 ms corresponding to different hand rotation positions
                -- 0.5 ms pulse width = 0 degree, 2.5 ms pulse width = 180 degree
                -- formula for calculating max_count_clock_division: max_count_clock_division = 0.5 ms * system_clk_frequency
                -- e.g. for pwm clock period of 20 ms (assuming clk of 100 MHz): max_count_clock_division = 0.5ms * 100Mhz = 50000, max_count = 40
            );
    Port (      clk 		: in STD_LOGIC;
                duty_cycle  : in STD_LOGIC_VECTOR (2 downto 0);
                pwm_out 	: out STD_LOGIC
            );
end pwm_generator;

architecture Behavioral of pwm_generator is
    
    signal clk_counter : integer range 0 to max_count_clock_division := 0;
    signal clk_counter_in : integer range 0 to max_count_clock_division := 0;
    signal counter :     integer range 0 to max_count := 0;
    
    begin
    --process to generate slowed down clock signal pulse
        combinational : process (clk_counter, duty_cycle) is
        variable tmp_clk_counter : integer range 0 to max_count_clock_division;
        variable tmp_counter : integer range 0 to max_count;
        variable tmp_clk_div : std_logic := '0';
        begin
        --initialize all variables
            tmp_clk_counter := clk_counter;
            tmp_counter := counter;
        
        -- slow down system clock to PWM clock
            if (tmp_clk_counter = max_count_clock_division) then
                tmp_clk_div := '1';
                tmp_clk_counter := 0;
            else
                tmp_clk_counter := tmp_clk_counter + 1;
            end if;
            
        -- counter in PWM clock domain
            if (tmp_clk_div = '1') then
                if tmp_counter = max_count-1 then
                    tmp_counter := 0;
                else
                    tmp_counter := tmp_counter + 1;
                end if;
            end if;
            
            clk_counter_in <= tmp_clk_counter;
            counter <= tmp_counter;
            
        -- output assignment
            if (tmp_counter < to_integer(unsigned(duty_cycle)) AND to_integer(unsigned(duty_cycle)) < max_count) then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end process;
            
        sequential : process (clk) is
        begin
            if rising_edge(clk) then clk_counter <= clk_counter_in; end if;
        end process;
    
    end Behavioral;