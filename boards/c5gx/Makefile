
help:
	qmegawiz -h

test:
	qmegawiz -silent OPTIONAL_FILES=NONE ip/fpga_lpddr2.v 

test2:
	qmegawiz -p:test_dir -silent OPTIONAL_FILES=NONE ip/fpga_lpddr2.v 

SYN_DIR = synth/lpddr2

syn:
	rm -rf $(SYN_DIR)
	mkdir -p $(SYN_DIR)
	cp ip/* $(SYN_DIR)
	cd $(SYN_DIR) && qmegawiz -silent OPTIONAL_FILES="SIM_NETLIST|SYNTH_NETLIST" lpddr2.v 

