library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_generator is
    generic (   
                eoc : integer   := 50000
            );
    Port (      clk 		: in STD_LOGIC;
                areset_n 	: in STD_LOGIC;
                duty        : in STD_LOGIC_VECTOR (2 downto 0);
                high_counter: in STD_LOGIC; 
                pwm_out 	: out STD_LOGIC
            );
end pwm_generator;

architecture Behavioral of pwm_generator is
    
    signal clk_counter : integer range 0 to eoc;
    signal clk_slow : std_logic;

    process (clk, areset_n) is
        begin
            if areset_n = '0' then
                pwm_out  <= '0';
                clk_slow <= '0';
            elsif rising_edge(clk) then
                if (clk_counter = eoc) then
                    clk_slow <= '1';
                    clk_counter <= '0';
                else
                    clk_counter <= clk_counter + 1;
            end if;
        end process;
    
    end Behavioral;