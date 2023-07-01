LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;

ENTITY n_register IS
  GENERIC (
    CONSTANT n : NATURAL
  );

  PORT (
    -- INPUT PORTS
    i_clk : IN STD_LOGIC;
    i_enable : IN STD_LOGIC;
    i_data_in : IN STD_LOGIC_VECTOR(n DOWNTO 0);

    -- OUTPUT PORTS
    o_data_out : OUT STD_LOGIC_VECTOR(n DOWNTO 0)
  );
END n_register;

ARCHITECTURE arch OF n_register IS
BEGIN

  RISIN_EDGE_DATA_TRANSFER : PROCESS (i_clk, i_enable)
  BEGIN

    IF (rising_edge(i_clk)) THEN
      IF (i_enable = '1') THEN
        o_data_out <= i_data_in;
      END IF;
    END IF;

  END PROCESS; -- RISIN_EDGE_DATA_TRANSFER

END arch; -- arch