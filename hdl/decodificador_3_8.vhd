library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity decodificador_3_8 is
  port (
    -- INPUT PORTS
	i_data_in: in STD_LOGIC_VECTOR(2 downto 0);

    -- OUTPUT PORTS
    o_data_out: out  STD_LOGIC_VECTOR(7 downto 0)
  );
end decodificador_3_8;

architecture arch of decodificador_3_8 is
begin

    MUX_SELECT : process
    begin
        with i_bus_select select o_data_out <= 
                                    "00000001" when "000", 
                                    "00000010" when "001",
                                    "00000100" when "010",
                                    "00001000" when "011",
                                    "00010000" when "100",
                                    "00100000" when "101",
                                    "01000000" when "110",
                                    "10000000" when others;
												
												
												
    end process ; -- MUX_SELECT

end arch ; -- arch