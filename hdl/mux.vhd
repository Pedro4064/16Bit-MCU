library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity mux is
  port (
    -- INPUT PORTS
    i_data_bus_00: in STD_LOGIC_VECTOR(15 downto 0);
    i_data_bus_01: in STD_LOGIC_VECTOR(15 downto 0);
    i_data_bus_02: in STD_LOGIC_VECTOR(15 downto 0);
    i_data_bus_03: in STD_LOGIC_VECTOR(15 downto 0);
    i_data_bus_04: in STD_LOGIC_VECTOR(15 downto 0);
    i_data_bus_05: in STD_LOGIC_VECTOR(15 downto 0);
    i_data_bus_06: in STD_LOGIC_VECTOR(15 downto 0);
    i_data_bus_07: in STD_LOGIC_VECTOR(15 downto 0);
    i_bus_select: in STD_LOGIC_VECTOR(3 downto 0);

    -- OUTPUT PORTS
    o_data_out: out  STD_LOGIC_VECTOR(15 downto 0)
  );
end mux;

architecture arch of n_m_mux is
begin

    MUX_SELECT : process
    begin
        with i_bus_select select o_data_out <= 
                                    i_data_bus_00 when "000",
                                    i_data_bus_01 when "001",
                                    i_data_bus_02 when "010",
                                    i_data_bus_03 when "011",
                                    i_data_bus_04 when "100",
                                    i_data_bus_05 when "101",
                                    i_data_bus_06 when "110",
                                    i_data_bus_07 when "111";
    end process ; -- MUX_SELECT

end arch ; -- arch