library ieee;
use ieee.STD_LOGIC_1164.all;
use work.pkg_testing.p_CLOCK_SIGNAL;

entity tb_register is
end tb_register;

architecture arch of tb_register is

    component n_register is

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

    end component;

    signal s_clk: std_logic;
    signal s_enable: std_logic;
    signal s_data_in:  std_logic_vector(15 downto 0);
    signal s_data_out: std_logic_vector(15 downto 0);

begin

    -- PORT MAPPING
    REG1: n_register generic map(n => 15) port map(i_clk => s_clk, i_enable => s_enable, i_data_in => s_data_in, o_data_out => s_data_out);

    -- TESTING PROCEDURE PROCESS
    TESTING_PROCEDURE : process
    begin
        s_enable  <= '1';
        s_data_in <= X"0000";
        p_CLOCK_SIGNAL(o_clock_signal => s_clk);
        wait;
    end process ; -- TESTING_PROCEDURE

end arch ; -- arch

