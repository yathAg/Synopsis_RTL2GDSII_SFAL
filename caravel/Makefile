# Variables
DC_SHELL = dc_shell       # Path to Synopsys DC Shell executable
TCL_SCRIPT = ./synth/synth.tcl  # Name of your TCL script
LOG_FILE = ./out/synth/log.txt            # Log file to capture output

# Default target
all: run_synthesis

# Target to run the synthesis
run_synthesis:
	$(DC_SHELL) -f $(TCL_SCRIPT) | tee $(LOG_FILE)

# Target to clean generated files
clean:
	rm -f $(LOG_FILE) /path/to/output_file.v /path/to/qor_report.rpt
	rm -f *.log
	rm -f *.pvl
	rm -f *.syn
	rm -f *.mr


