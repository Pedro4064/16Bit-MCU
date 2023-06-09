library ieee;
use ieee.STD_LOGIC_1164.all;

package pkg_testing is
    procedure p_CLOCK_SIGNAL(signal o_clock_signal: out std_logic);
end package ;

package body pkg_testing is

    procedure p_CLOCK_SIGNAL (
        signal o_clock_signal: out std_logic) is
    begin

        o_clock_signal <= '0';
        wait for 10 ns;

        o_clock_signal <= '1';
        wait for 10 ns;

    end p_CLOCK_SIGNAL;

end package body pkg_testing;