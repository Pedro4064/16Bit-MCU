library ieee;
use ieee.STD_LOGIC_1164.all;
use work.pkg_testing.p_CLOCK_SIGNAL;
use work.pkg_data_bus.t_data_bus;
use work.pkg_data_bus.f_select_calc;

entity tb_n_m_mux is
end tb_n_m_mux;

architecture arch of tb_n_m_mux is

    component n_m_mux is
        generic(
            constant n: natural;  -- n number of bits for each bus
            constant m: natural   -- m number of data buses
        );

        port (
            -- INPUT PORTS
            i_data_in: in t_data_bus(0 to m-1)(n - 1 downto 0);
            i_bus_select: in STD_LOGIC_VECTOR(f_select_calc(m) -1 downto 0);

            -- OUTPUT PORTS
            o_data_out: out  STD_LOGIC_VECTOR(n-1 downto 0)
        );
   end component;

    signal s_clk: std_logic;                                 -- clock signal
    signal s_data_bus_01:  std_logic_vector(15 downto 0);    -- first data line signal
    signal s_data_bus_02:  std_logic_vector(15 downto 0);    -- second data line signal
    signal s_in_data_buses: t_data_bus(0 to 1)(15 downto 0); -- 2 data buses with 16bits each
    signal s_bus_select: std_logic_vector(1 downto 0);       -- select signal for the mux
    signal s_data_out: std_logic_vector(15 downto 0);        -- output signal with 16bits

begin

    -- PORT MAPPING
    MUX01: n_m_mux generic map(n => 16, m => 2) port map(i_data_in => s_in_data_buses, i_bus_select => s_bus_select, o_data_out => s_data_out);

    -- SIGNAL COMPOSITION 
    s_in_data_buses(0) <= s_data_bus_01;
    s_in_data_buses(1) <= s_data_bus_02;

    -- TESTING PROCEDURE PROCESS
    TESTING_PROCEDURE : process
    begin
        s_data_bus_01 <= X"000A";
        s_data_bus_02 <= X"000B";
        s_bus_select  <= "00";

        p_CLOCK_SIGNAL(o_clock_signal => s_clk);
        p_CLOCK_SIGNAL(o_clock_signal => s_clk);


        s_bus_select <= "01";
        p_CLOCK_SIGNAL(o_clock_signal => s_clk);

        s_bus_select <= "00";
        p_CLOCK_SIGNAL(o_clock_signal => s_clk);
        
        wait;
    end process ; -- TESTING_PROCEDURE

end arch ; -- arch

