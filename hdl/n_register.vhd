library ieee;
use ieee.STD_LOGIC_1164.all;

entity n_register is
  generic(
    constant n: natural
  );

  port (
    -- INPUT PORTS
    i_clk: in STD_LOGIC;
    i_enable: in STD_LOGIC;
    i_data_in: in STD_LOGIC_VECTOR(n downto 0);

    -- OUTPUT PORTS
    o_data_out: out STD_LOGIC_VECTOR(n downto 0)
  );
end n_register;

architecture arch of n_register is
begin

    RISIN_EDGE_DATA_TRANSFER : process(i_clk, i_enable)
    begin

        if rising_edge(i_clk) and i_enable = '1' then
            o_data_out <= i_data_in;
        end if ;

    end process ; -- RISIN_EDGE_DATA_TRANSFER

end arch ; -- arch