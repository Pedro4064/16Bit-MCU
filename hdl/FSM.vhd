LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;

ENTITY FSM IS

	PORT (
		-- INPUT PORTS
		i_clk, i_run, i_resetn : IN STD_LOGIC;
		i_IR : IN STD_LOGIC_VECTOR(8 DOWNTO 0);

		-- OUTPUT PORTS
		o_enable_bus : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_sel_bus : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_G_enable, o_external_sel, o_done, o_addsub, o_IR, o_A, o_G_select : OUT STD_LOGIC
	);
END FSM;
ARCHITECTURE arch OF FSM IS

	COMPONENT decodificador_3_8 IS
		PORT (
			-- INPUT PORTS
			i_data_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

			-- OUTPUT PORTS
			o_data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	TYPE TIMMING_STATE IS (T0, T1, T2, T3);

	CONSTANT mv : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
	CONSTANT mvi : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
	CONSTANT add : STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";
	CONSTANT sub : STD_LOGIC_VECTOR(2 DOWNTO 0) := "011";

	SIGNAL s_TargetRegister, s_SourceRegister : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL s_TAtual, s_TProx : TIMMING_STATE;
	SIGNAL s_Opcode : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

	DEC0 : decodificador_3_8 PORT MAP(i_data_in => i_IR(2 DOWNTO 0), o_data_out => s_SourceRegister);
	DEC1 : decodificador_3_8 PORT MAP(i_data_in => i_IR(5 DOWNTO 3), o_data_out => s_TargetRegister);

	s_Opcode <= i_IR(8 DOWNTO 6);

	fsm_clock : PROCESS (s_TAtual)
	BEGIN
		CASE(s_TAtual) IS

			WHEN T0 =>
			s_TProx <= T1;
			WHEN T1 =>
			IF s_Opcode = mv OR s_Opcode = mvi THEN
				s_TProx <= T0;
			ELSIF s_Opcode = add OR s_Opcode = sub THEN
				s_Tprox <= T2;
			END IF;
			WHEN T2 =>
			s_TProx <= T3;
			WHEN T3 =>
			s_TProx <= T0;
		END CASE;
	END PROCESS;

	fsm_update : PROCESS (i_clk)
	BEGIN
		IF rising_edge(i_clk) THEN
			s_TAtual <= S_TProx;
		END IF;

	END PROCESS;

	fsm_op : PROCESS (s_Opcode, s_Tatual)
	BEGIN
		IF s_TAtual = T0 THEN
			-- WHEN [s_TATUAL] is equal to T0, the PROCESSOR MUST set [o_IR] equal to 1
			o_IR <= '1';

			-- WHEN [S_TATUAL] is equal to T), the processor must reset all the following variables to their defautl state:
			-- | variable name | defautl state |
			-- |  o_externa_sel|   0           |  ... 
			o_G_enable <= '0';
			o_external_sel <= '0';
			o_done <= '0';
			o_addsub <= '0';
			o_IR <= '0';
			o_A <= '0';
			o_G_select <= '0';
		ELSE

			-- WHEN  [s_ATUAL] is other than T0, the PROCESSOR must set [o_IR] equal to 0 
			o_IR <= '0';

			CASE(s_Opcode) IS

				WHEN mv =>
				-- WHEN the struction is set to MV, the PROCESSOR must set the ADDRESS of the source register [s_SourceRegister]
				-- on [o_sel_output]
				o_sel_bus <= s_SourceRegister;

				-- WHEN the struction is set to MV, the PROCESSOR must set the [o_enable_bus] equal to the target register [s_TargetRegister]
				o_enable_bus <= s_TargetRegister;

				-- WHEN the strcution is set to MV, all of the above are done, the PROCESSOR must set the [DONE] Bite to HIGH
				o_done <= '1';

				WHEN mvi =>

				-- WHEN the struction is set to MVI, the PROCESSOR must set [o_external_sel] to HIGH
				o_external_sel <= '1';

				-- WHEN the struction is set to MVI, the PROCESSOR must set the [o_enable_bus] equal to the target register [s_TargetRegister]
				o_enable_bus <= s_TargetRegister;
				o_done <= '1';

				WHEN OTHERS =>

				CASE(s_TAtual) IS -- Its either add or sub

					WHEN T1 =>
					-- selec <- TargetRegister	
					o_sel_bus <= s_TargetRegister;
					-- A enable <- HIGH
					o_A <= '1';
					---------------- o que tava no target vai para o A ---------------
					WHEN T2 =>
					-- A enable <- LOW
					o_A <= '0';
					-- selec <- sourceREgister
					o_sel_bus <= s_SourceRegister;

					IF s_Opcode = add THEN
						-- AddSub <- HIGH
						o_addsub <= '0';

					ELSE
						o_addsub <= '1';
					END IF;

					-- G enable <- HIGH
					o_G_enable <= '1';
					---------------- a soma vai para o G -----------------------------

					WHEN T3 =>
					-- g-select <- HIGH
					o_G_select <= '1';
					-- targetRegiss_Sourter enable <- HIGH
					o_enable_bus <= s_TargetRegister;
					o_done <= '1';
					----------------- o target register vai receber o barramento (que é o G) -----

					WHEN OTHERS => NULL;

				END CASE;

			END CASE;

		END IF;
	END PROCESS;

END arch;