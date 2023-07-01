ghdl -a --std=08 hdl/decodificador_3_8.vhd && echo "[x] decodificador_3_8.vhd" &&
ghdl -a --std=08 hdl/FSM.vhd && echo "[x] FSM.vhd" &&
ghdl -a --std=08 hdl/n_register.vhd && echo "[x] n_register.vhd" &&
ghdl -a --std=08 hdl/mux.vhd && echo "[x] mux.vhd" &&
ghdl -a --std=08 hdl/addsub.vhd &&  echo "[x] addsub.vhd" &&
ghdl -a --std=08 hdl/mcu.vhd &&  echo "[x] mcu.vhd" &&
ghdl -a --std=08 test/pkg_testing.vhd &&  echo "[x] pkg_testing.vhd" &&
ghdl -a --std=08 test/tb_mcu.vhd &&  echo "[x] tb_mcu.vhd" &&
ghdl -e --std=08 tb_mcu && echo "[x] e -- tb_mcu"
ghdl -r -v --std=08 tb_mcu --wave=wave_mcu.ghw