LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux IS
  PORT (
    -- INPUT PORTS
    i_data_bus_00 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_data_bus_01 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_data_bus_02 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_data_bus_03 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_data_bus_04 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_data_bus_05 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_data_bus_06 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_data_bus_07 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_data_bus_08 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_data_bus_09 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_bus_select : IN STD_LOGIC_VECTOR(9 DOWNTO 0);

    -- OUTPUT PORTS
    o_data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END mux;

ARCHITECTURE arch OF mux IS
BEGIN

  MUX_SELECT : PROCESS
  BEGIN

    WITH i_bus_select SELECT o_data_out <=
      "0000000000000001"WHEN "0000000001",
      "0000000000000001" WHEN OTHERS;
    --     i_data_bus_01 WHEN "0000000010",
    --     i_data_bus_02 WHEN "0000000100",
    --     i_data_bus_03 WHEN "0000001000",
    --     i_data_bus_04 WHEN "0000010000",
    --     i_data_bus_05 WHEN "0000100000",
    --     i_data_bus_06 WHEN "0001000000",
    --     i_data_bus_07 WHEN "0010000000",
    --     i_data_bus_08 WHEN "0100000000",
    --     i_data_bus_09 WHEN "1000000000"
  END PROCESS; -- MUX_SELECT

END arch; -- arch