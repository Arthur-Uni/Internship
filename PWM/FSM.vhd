library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fsm is
    Port ( clk 			: in STD_LOGIC;
           areset_n 	: in STD_LOGIC;
           pwm_sig 		: out STD_LOGIC_VECTOR (5 downto 0)
           );
end counter;

architecture Behavioral of counter is
    constant EXTEND  : Integer := 250000; --extend robot hand finger
    constant RETRACT : Integer := 50000; --retract robot hand finger
    --signal declarations
    signal counter : unsigned (20 downto 0) := (others => '0');
    
    begin

    process(clk, areset_n) is
        begin
            if areset_n = '0' then
                counter <= (others => '0');
                pwm_clk <= '0';
            elsif rising_edge(clk) then
                counter <= counter + 1;
                if (counter < HIGH_COUNT) then
                    pwm_clk <= '1';
                elsif (counter >= HIGH_COUNT) and (counter < LOW_COUNT) then
                    pwm_clk <= '0';
                elsif (counter = LOW_COUNT) then
                    counter <= (others => '0');
                end if;
            end if;
        end process;
    
    end Behavioral;