# Define the target and link libraries
set target_library "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel/pdk/scl180/stdlib/fs120/liberty/lib_flow_ff/tsl18fs120_scl_ff.db"
# set link_library "/path/to/link_library.lib"

# Specify the input Verilog directory and output paths
set verilog_folder "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel/verilog/rtl"
set verilog_folder_wrapper "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel/pdk/scl180"
set output_file "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel/out/synth/output_file.v"
set report_file "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel/out/synth/qor_report.rpt"

# Define the top-level module name
set top_module "caravel" ;# Replace with your top module name

# Load the target and link libraries
set_app_var target_library $target_library
# set_app_var link_library "* $link_library"
set_app_var link_library "* $target_library"

# Collect all Verilog files for analysis
set verilog_files [concat [glob -nocomplain "$verilog_folder_wrapper/*.v"] [glob -nocomplain "$verilog_folder/*.v"]]

# Set the include search path for files with `include` directives
set search_path "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel/pdk/scl180/iolib/cio150/verilog/tsl18cio150/zero"

# Analyze all Verilog files (parsing only)
analyze -format verilog $verilog_files

# Elaborate and link the design
elaborate $top_module
link

# Run compile_ultra for optimization
compile_ultra -gate_clock

# Write out the synthesized netlist
write -format verilog -hierarchy -output $output_file

# Generate and save the QoR (Quality of Results) report
report_qor -hierarchical -output $report_file

# Exit the DC Shell
quit
