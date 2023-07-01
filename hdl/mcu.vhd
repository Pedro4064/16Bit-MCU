LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;

ENTITY mcu IS
END mcu;

ARCHITECTURE arch OF mcu IS
    COMPONENT FSM IS
        PORT (
            -- INPUT PORTS
            i_clk, i_run, i_resetn : IN STD_LOGIC;
            i_IR : IN STD_LOGIC_VECTOR(8 DOWNTO 0);

            -- OUTPUT PORTS
            o_enable_bus : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_sel_bus : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_G_enable, o_external_sel, o_done, o_addsub, o_IR, o_A, o_G_select : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT n_register IS
        GENERIC (
            CONSTANT n : NATURAL
        )
        PORT (
            -- INPUT PORTS
            i_clk : IN STD_LOGIC;
            i_enable : IN STD_LOGIC;
            i_data_in : IN STD_LOGIC_VECTOR(n DOWNTO 0);

            -- OUTPUT PORTS
            o_data_out : OUT STD_LOGIC_VECTOR(n DOWNTO 0)
        );

    END COMPONENT;

    COMPONENT mux IS
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

    END COMPONENT;

    COMPONENT addsub IS
        PORT (
            add_sub : IN STD_LOGIC;
            dataa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            datab : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            result : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
    END COMPONENT;

    -- ALU SIGNALS
    SIGNAL s_A_output, s_ALU_output, s_G_output, s_Din : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- FSM SIGNALS
    SIGNAL s_clk, s_run, s_resetn : STD_LOGIC;
    SIGNAL s_IR_bus : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL s_enable_bus : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL s_sel_bus : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL s_G_enable, s_external_sel, s_done, s_addsub, s_IR, s_A, s_G_select : STD_LOGIC;

    -- MUX SIGNALS & REGISTER SIGNALS
    SIGNAL s_data_bus_01 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_data_bus_00 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_data_bus_02 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_data_bus_03 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_data_bus_04 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_data_bus_05 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_data_bus_06 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_data_bus_07 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_BUS : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- CLOCK
BEGIN

    -- REGISTER PORT MAPS
    R0 : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_enable_bus(0), i_data_in => s_BUS, o_data_out => s_data_bus_00);
    R1 : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_enable_bus(1), i_data_in => s_BUS, o_data_out => s_data_bus_01);
    R2 : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_enable_bus(2), i_data_in => s_BUS, o_data_out => s_data_bus_02);
    R3 : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_enable_bus(3), i_data_in => s_BUS, o_data_out => s_data_bus_03);
    R4 : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_enable_bus(4), i_data_in => s_BUS, o_data_out => s_data_bus_04);
    R5 : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_enable_bus(5), i_data_in => s_BUS, o_data_out => s_data_bus_05);
    R6 : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_enable_bus(6), i_data_in => s_BUS, o_data_out => s_data_bus_06);
    R7 : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_enable_bus(7), i_data_in => s_BUS, o_data_out => s_data_bus_07);

    A : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_A, i_data_in => s_BUS, o_data_out => s_A_output);
    G : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_G_enable, i_data_in => s_ALU_output, o_data_out => s_G_output);
    IR : n_register PORT GENERIC (16) MAP(i_clk => s_clk, i_enable => s_IR, i_data_in => s_Din, o_data_out => s_IR_bus);

    -- MUX PORT MAP
    MUX : mux PORT MAP(
        i_data_bus_00 => s_data_bus_00,
        i_data_bus_01 => s_data_bus_01,
        i_data_bus_02 => s_data_bus_02,
        i_data_bus_03 => s_data_bus_03,
        i_data_bus_04 => s_data_bus_04,
        i_data_bus_05 => s_data_bus_05,
        i_data_bus_06 => s_data_bus_06,
        i_data_bus_07 => s_data_bus_07,
        i_data_bus_08 => s_G_output,
        i_data_bus_09 => s_Din,
        i_bus_select => s_sel_bus & s_G_select & s_external_sel;
    );

    -- ADDSUB PORT MAP
    ULA : addsub PORT MAP(
        add_sub => s_addsub,
        dataa => s_A_output,
        datab => s_BUS,
        result => s_ALU_output
    );

    -- CONTROLLER FSM PORT MAP
    CONTROLLER : FSM PORT MAP(
        -- INPUT PORTS
        i_clk => s_clk,
        i_run => s_run,
        i_resetn => s_resetn,
        i_IR => s_IR,

        -- OUTPUT PORTS
        o_enable_bus => s_enable_bus,
        o_sel_bus => s_sel_bus,
        o_G_enable => s_G_enable,
        o_external_sel => s_external_sel,
        o_done => s_done,
        o_addsub => s_addsub,
        o_IR => s_IR,
        o_A => s_A,
        o_G_select => s_G_select
    )

END arch; -- arch