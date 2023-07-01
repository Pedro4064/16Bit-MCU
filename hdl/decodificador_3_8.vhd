LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decodificador_3_8 IS
  PORT (
    -- INPUT PORTS
    i_data_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- OUTPUT PORTS
    o_data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END decodificador_3_8;

ARCHITECTURE arch OF decodificador_3_8 IS
BEGIN

  WITH i_data_in SELECT o_data_out <=
    "00000001" WHEN "000",
    "00000010" WHEN "001",
    "00000100" WHEN "010",
    "00001000" WHEN "011",
    "00010000" WHEN "100",
    "00100000" WHEN "101",
    "01000000" WHEN "110",
    "10000000" WHEN OTHERS;
END arch; -- arch