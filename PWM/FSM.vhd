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
    
    begin
    
    end Behavioral;