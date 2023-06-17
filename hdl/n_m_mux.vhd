library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.pkg_data_bus.t_data_bus;
use work.pkg_data_bus.f_select_calc;

entity n_m_mux is
  generic(
    constant n: natural;  -- n number of bits for each bus
    constant m: natural   -- m number of data buses
  );

  port (
    -- INPUT PORTS
    i_data_in: in t_data_bus(0 to m-1)(n - 1 downto 0);
    i_bus_select: in STD_LOGIC_VECTOR(f_select_calc(m) downto 0);

    -- OUTPUT PORTS
    o_data_out: out  STD_LOGIC_VECTOR(n-1 downto 0)
  );
end n_m_mux;

architecture arch of n_m_mux is
  signal s_target_bus: integer; -- Signal that holds the index of target bus
begin

  s_target_bus <= to_integer(unsigned(i_bus_select));          -- Convert the data on select vector to numeral to be used as index
  o_data_out <= i_data_in(to_integer(unsigned(i_bus_select))); -- Index the array and set as output 

end arch ; -- arch