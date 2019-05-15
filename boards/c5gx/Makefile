
IP_DIR = ip
LST_IP = lpddr2

IP_DIR_PATH = $(IP_DIR)/$@
IP_DIR_FILE = $@.v

$(LST_IP):
	mkdir -p $(IP_DIR_PATH)
	cp $(IP_DIR_FILE) $(IP_DIR_PATH)
	cd $(IP_DIR_PATH) && qmegawiz -silent OPTIONAL_FILES="SIM_NETLIST|SYNTH_NETLIST" $(IP_DIR_FILE)

clean:
	rm -rf $(IP_DIR)

edit:
	cd ip/lpddr2 && qmegawiz lpddr2.v
