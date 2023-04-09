FILENAME   = top
PCFFILE    = io.pcf
ICELINKDIR = $(shell df | grep iCELink | awk '{print $$9}')

.PHONY: prog_flash clean sim

build: $(FILENAME).v
	yosys -p "synth_ice40 -top top -json $(FILENAME).json" $(FILENAME).v
	nextpnr-ice40 --up5k --package sg48 --json $(FILENAME).json --pcf $(PCFFILE) --asc $(FILENAME).asc
	icepack $(FILENAME).asc $(FILENAME).bin

prog_flash:
	cp $(FILENAME).bin $(ICELINKDIR)

sim:
	iverilog -g2012 -o $(FILENAME).vvp $(FILENAME)_tb.v $(FILENAME).v sim.v
	vvp $(FILENAME).vvp

clean:
	rm -rf $(FILENAME).json $(FILENAME).asc $(FILENAME).bin *.vvp *.vcd
