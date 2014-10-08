library ieee;
use ieee.std_logic_1164.all;

entity tcl1549_t is
    generic(
        clk_in_freq     : integer := 50000000); -- input clock frequency
    port(
        clk_in          : in std_logic;
        data_in         : in std_logic;
        cs_out          : out std_logic);
end tcl1549_t;

architecture behavioral of tcl1549_t is

begin


end behavioral;

