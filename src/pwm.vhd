library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pwm_t is
    generic(
        clk_in_freq     : integer := 50000000; -- input clock frequency
        pwm_out_freq    : integer := 50; -- frequency of the PWM output
        bits_resolution : integer := 8); -- resolution of 'duty_in'
    port(
        clk_in          : in std_logic; -- input clock
        duty_in         : in std_logic_vector(bits_resolution - 1 downto 0); -- duty cycle
        duty_latch_in   : in std_logic; -- when high latches in duty new cycle on 'duty_in'
        pwm_out         : out std_logic); -- PWM output signal
end pwm_t;

architecture behavioral of pwm_t is
    constant period_num_clocks : integer := clk_in_freq/pwm_out_freq;
    signal count               : integer range 0 to period_num_clocks := 0;
    signal duty_clocks         : integer range 0 to period_num_clocks := 0;
    signal pwm_io              : std_logic := '0';

begin
    pwm_out <= pwm_io;

    process(clk_in)
    begin
        if (rising_edge(clk_in)) then
            if (duty_latch_in = '1') then
                -- map 'duty_in' from [0; 2^bits_resolution] -> [0; period_num_clocks]
                duty_clocks <= conv_integer(duty_in) * period_num_clocks / 2**bits_resolution;
            end if;

            count <= count + 1;

            if (count = duty_clocks) then
                pwm_io <= not pwm_io;
                count <= 0;
            end if;
        end if;
    end process;

end behavioral;
