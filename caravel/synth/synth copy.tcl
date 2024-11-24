# Define the target and link libraries
set target_library "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel/pdk/scl180/stdlib/fs120/liberty/lib_flow_ff/tsl18fs120_scl_ff.db"
set link_library "* $target_library"

# Define the input directories and output paths
set verilog_dirs [list \
    "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel/verilog/rtl"
]
set output_file "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel/out/synth/output_file.v"
set report_file "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel/out/synth/qor_report.rpt"

# Define the top-level module name
set top_module "caravel"

# Load the target and link libraries
set_app_var target_library $target_library
set_app_var link_library $link_library

# Read all Verilog files from the specified directories
read_file $verilog_dirs -autoread -recursive -format verilog -top $top_module

# Analyze the design and link files
elaborate $top_module
link

# Run compile_ultra for optimization
compile_ultra -gate_clock

# Write the synthesized netlist
write -format verilog -hierarchy -output $output_file

# Generate and save the QoR report
report_qor -hierarchical -output $report_file

# Exit the DC Shell
quit
