LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE work.pkg_testing.p_CLOCK_SIGNAL;

ENTITY tb_mcu IS
END tb_mcu;

ARCHITECTURE arch OF tb_mcu IS

    COMPONENT mcu IS
        PORT (
            -- INPUT PORTS
            i_external_data_bus : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            i_clk : IN STD_LOGIC;
            i_run : IN STD_LOGIC;
            i_reset_n : IN STD_LOGIC;

            -- OUTPUT PORTS
            o_output_data_bus : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            o_done_status : OUT STD_LOGIC);
    END COMPONENT;

    -- INPUT SIGNAL PORTS
    SIGNAL s_external_data_bus : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_clk : STD_LOGIC;
    SIGNAL s_run : STD_LOGIC;
    SIGNAL s_reset_n : STD_LOGIC;

    -- OUTPUT SIGNAL PORTS
    SIGNAL s_output_data_bus : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_done_status : STD_LOGIC;
BEGIN

    PROC : mcu PORT MAP(
        -- INPUT PORTS
        i_external_data_bus => s_external_data_bus,
        i_clk => s_clk,
        i_run => s_run,
        i_reset_n => s_reset_n,

        -- OUTPUT PORTS
        o_output_data_bus => s_output_data_bus,
        o_done_status => s_done_status
    );

    TESTING_PROCEDURE : PROCESS
    BEGIN

        -- TEST FOR MVI
        p_CLOCK_SIGNAL(o_clock_signal => s_clk);
        s_external_data_bus <= "0010000000000000";
        p_CLOCK_SIGNAL(o_clock_signal => s_clk);

        s_external_data_bus <= X"0001";
        p_CLOCK_SIGNAL(o_clock_signal => s_clk);
        p_CLOCK_SIGNAL(o_clock_signal => s_clk);
        WAIT;

    END PROCESS;

END arch; -- arch