# Define the root path
set root_path "/home/yatharth/vsd_sfal/Synopsys_RTL2GDSII_SFAL/caravel"

# Define the target and link libraries
set target_library "$root_path/pdk/scl180/stdlib/fs120/liberty/lib_flow_ff/tsl18fs120_scl_ff.db"

# Specify the input Verilog directory and output paths
set verilog_folder "$root_path/verilog/rtl"
set verilog_folder_wrapper "$root_path/pdk/scl180"
set output_file "$root_path/out/synth/output_file.v"

# Define the top-level module name
set top_module "caravel"

# Load the target and link libraries
set_app_var target_library $target_library
set_app_var link_library "* $target_library"

# Define the include directories
set search_path [list \
    "$root_path/pdk/scl180/iolib/cio150/verilog/tsl18cio150/zero" \
    $verilog_folder_wrapper
]

# Read the Verilog files
read_file $verilog_folder -autoread -define USE_POWER_PINS -format verilog -top $top_module

# Elaborate and link the design
elaborate $top_module
link

# Run compile_ultra for optimization
compile_ultra

# Report data
report_qor > "$root_path/out/synth/qor_post_synth.rpt"
report_area > "$root_path/out/synth/area_post_synth.rpt"
report_power > "$root_path/out/synth/power_post_synth.rpt"

# Write out the synthesized netlist
write -format verilog -hierarchy -output $output_file

# Exit the DC Shell
quit
