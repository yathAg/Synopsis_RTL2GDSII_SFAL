# Synopsis_RTL2GDSII_SFAL

Digital chip design transforms a high-level functional description into a manufacturable physical chip. The process follows key steps: starting with **specification**, followed by **RTL design** using hardware description languages like Verilog or VHDL, **verification**, **synthesis** into a gate-level netlist, **place and route (PnR)**, and final **timing, power, and physical verification** before the chip is ready for fabrication.

This repository demonstrates the entire RTL-to-GDSII flow using Synopsys tools, providing a streamlined guide from RTL design to physical implementation. It covers each stage, offering insights into optimizing digital chip design workflows.

## Tools Overview

This project uses several essential tools to facilitate the digital chip design flow, from synthesis to simulation and waveform analysis:

1. **Yosys**:  
   Yosys is an open-source framework for RTL synthesis. It converts RTL code (written in Verilog or VHDL) into a gate-level netlist and provides optimization features to meet timing and area constraints.

   **Installation Steps**:

   ```bash
   sudo apt-get update
   git clone https://github.com/YosysHQ/yosys.git
   cd yosys
   sudo apt install make  # If make is not installed, please install it
   sudo apt-get install build-essential clang bison flex \
       libreadline-dev gawk tcl-dev libffi-dev git \
       graphviz xdot pkg-config python3 libboost-system-dev \
       libboost-python-dev libboost-filesystem-dev zlib1g-dev
   make config-gcc
   make 
   sudo make install
   ```

2. **Icarus Verilog (Iverilog)**:  
   Iverilog is a free and open-source Verilog simulation tool. It allows for compiling and simulating Verilog code, making it an essential tool for functional verification of RTL designs.

   **Installation Steps**:

   ```bash
   sudo apt-get update
   sudo apt-get install iverilog
   ```

3. **GTKWave**:  
   GTKWave is an open-source waveform viewer used for analyzing simulation results. It helps visualize signals and detect issues in the timing and functionality of the design.

   **Installation Steps**:

   ```bash
   sudo apt-get update
   sudo apt install gtkwave
   ```
