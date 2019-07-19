library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_tb is
end counter_tb;

architecture Behavioral of counter_tb is
    
    --component declaration
    component counter is
        Port ( 
           clk 	    : in STD_LOGIC;
           areset_n 	: in STD_LOGIC;
           pwm_clk 		: out STD_LOGIC
           );
    end component;
    
    --signal declarations
    
    --inputs
    signal clk 		: std_logic := '0';
    signal areset_n : std_logic;
    
    --outputs
    signal pwm_clk	: std_logic;
    
    begin
    
    clk <= not clk after 10 ns; -- 100 MHz clock
    areset_n <= '0', '1' after 20 ns;
    
    --instantiation
    dut : counter
        port map (
            clk => clk,
            areset_n => areset_n,
            
            pwm_clk => pwm_clk
        );
    
    end Behavioral;