library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.math_real.all;

package pkg_data_bus is
    type t_data_bus is array(integer range <>) of STD_LOGIC_VECTOR;
    function f_select_calc(number_buses: in natural) return natural;
end package;

package body pkg_data_bus is

    function f_select_calc(
        number_buses: in natural)
        return natural is 
    begin 

        return natural(ceil(log2(real(number_buses))));

    end;
end package body pkg_data_bus;