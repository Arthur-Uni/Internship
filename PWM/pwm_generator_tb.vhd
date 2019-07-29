library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_generator_tb is
        Generic (
            max_count_clock_division : integer := 50;
            max_count                : integer := 40
            );
end pwm_generator_tb;

architecture Behavioral of pwm_generator_tb is
    
    component pwm_generator is
        Generic (
            max_count_clock_division : integer;
            max_count : integer    
            );
        Port (
            clk 		: in STD_LOGIC;
            areset_n 	: in STD_LOGIC;
            duty        : in STD_LOGIC_VECTOR (2 downto 0);
            pwm_out 	: out STD_LOGIC
            );
    end component;
    
    --signal declarations
    
    --inputs
    
    signal  clk 		: STD_LOGIC := '0';
    signal  areset_n 	: STD_LOGIC;
    signal  duty        : STD_LOGIC_VECTOR (2 downto 0);

    --outputs
    
    signal  pwm_out     : STD_LOGIC;
    
    begin
    
    clk <= not clk after 10 ps; 
    areset_n <= '0', '1' after 20 ps;
    duty <= b"010";
    --instantiation
    dut : pwm_generator
        generic map (
            max_count_clock_division => 50,
            max_count => 40
            )
        port map (
                clk => clk,
                areset_n => areset_n,
                duty => duty,
                pwm_out => pwm_out
            );
    
    end Behavioral;