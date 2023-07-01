LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY addsub IS
	PORT (
		add_sub : IN STD_LOGIC;
		dataa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		datab : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		result : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
END addsub;

ARCHITECTURE arch OF addsub IS

	SIGNAL s_result : signed(15 DOWNTO 0);
BEGIN

	SUB_ADD : PROCESS (add_sub, dataa, datab)
	BEGIN

		IF add_sub = '1' THEN
			s_result <= signed(dataa) - signed(datab);
		ELSE
			s_result <= signed(dataa) + signed(datab);
		END IF;

	END PROCESS; -- SUB_ADD

	result <= STD_LOGIC_VECTOR(s_result);

END arch;