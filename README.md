# Synopsis_RTL2GDSII_SFAL

Digital chip design transforms a high-level functional description into a manufacturable physical chip. The process follows key steps: starting with **specification**, followed by **RTL design** using hardware description languages like Verilog or VHDL, **verification**, **synthesis** into a gate-level netlist, **place and route (PnR)**, and final **timing, power, and physical verification** before the chip is ready for fabrication.

This repository demonstrates the entire RTL-to-GDSII flow using Synopsys tools, providing a streamlined guide from RTL design to physical implementation. It covers each stage, offering insights into optimizing digital chip design workflows.

## Tools Overview

This project uses several essential tools to facilitate the digital chip design flow, from synthesis to simulation and waveform analysis:

1. **Yosys**:  
   Yosys is an open-source framework for RTL synthesis. It converts RTL code (written in Verilog or VHDL) into a gate-level netlist and provides optimization features to meet timing and area constraints.

   <details>
      <summary>Installation Steps:</summary>

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

   </details>  

2. **Icarus Verilog (Iverilog)**:  
   Iverilog is a free and open-source Verilog simulation tool. It allows for compiling and simulating Verilog code, making it an essential tool for functional verification of RTL designs.

   <details>
      <summary>Installation Steps:</summary>

   ```bash
   sudo apt-get update
   sudo apt-get install iverilog
   ```

   </details>

3. **GTKWave**:  
   GTKWave is an open-source waveform viewer used for analyzing simulation results. It helps visualize signals and detect issues in the timing and functionality of the design.

   <details>
      <summary>Installation Steps:</summary>

   ```bash
   sudo apt-get update
   sudo apt install gtkwave
   ```

   </details>

## Synthesis

Synthesis in digital VLSI design is the process of translating high-level hardware description language (HDL) code, often in RTL (Register Transfer Level) form, into a gate-level netlist. This netlist represents the circuit in terms of basic logic gates and components. Synthesis tools ensure that the design meets specific constraints, such as timing, area, and power, to facilitate the physical implementation.

### Simulation to Verify RTL

RTL simulation is the initial step to validate the functionality of the RTL code. This process uses testbenches to simulate the behavior of the RTL design, ensuring it functions as expected before synthesis. RTL simulation helps identify and correct logical and functional issues, enabling designers to confirm that the design meets requirements.

   <details>
      <summary>Labs:</summary>

   </details>

### Logic Synthesis

Logic synthesis is the process of converting RTL into a gate-level representation by mapping logic elements to actual hardware gates. Synthesis tools use timing, power, and area constraints to optimize the design, generating a netlist that adheres to the design's specifications. This netlist is essential for subsequent stages, such as placement and routing.

   <details>
      <summary>Labs:</summary>

   </details>

### Understanding .lib Files

Library files (often with the .lib extension) provide the synthesis tool with details about the available cells and components in a particular technology. These files include specifications like timing, power consumption, and area for each cell type. The synthesis tool uses this information to make decisions that optimize the design within the constraints provided.

   <details>
      <summary>Labs:</summary>

   </details>

