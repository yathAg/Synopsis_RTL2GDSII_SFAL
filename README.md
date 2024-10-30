# Synopsis_RTL2GDSII_SFAL

Digital chip design transforms a high-level functional description into a manufacturable physical chip. The process follows key steps: starting with **specification**, followed by **RTL design** using hardware description languages like Verilog or VHDL, **verification**, **synthesis** into a gate-level netlist, **place and route (PnR)**, and final **timing, power, and physical verification** before the chip is ready for fabrication.

This repository demonstrates the entire RTL-to-GDSII flow using Synopsys tools, providing a streamlined guide from RTL design to physical implementation. It covers each stage, offering insights into optimizing digital chip design workflows.

## Tools Overview

This project uses several essential tools to facilitate the digital chip design flow, from synthesis to simulation and waveform analysis:

1. **Yosys**:  
   Yosys is an open-source framework for RTL synthesis. It converts RTL code (written in Verilog or VHDL) into a gate-level netlist and provides optimization features to meet timing and area constraints.

   <details>
      <summary> 🛠️Installation Steps:</summary>

      ```bash
      git clone https://github.com/YosysHQ/yosys.git
      cd yosys
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
      <summary> 🛠️Installation Steps:</summary>

   ```bash
   sudo apt-get install iverilog
   ```

   </details>

3. **GTKWave**:  
   GTKWave is an open-source waveform viewer used for analyzing simulation results. It helps visualize signals and detect issues in the timing and functionality of the design.

   <details>
      <summary> 🛠️Installation Steps:</summary>

   ```bash
   sudo apt install gtkwave
   ```

   </details>

## Synthesis

Synthesis in digital VLSI design is the process of translating high-level hardware description language (HDL) code, often in RTL (Register Transfer Level) form, into a gate-level netlist. This netlist represents the circuit in terms of basic logic gates and components. Synthesis tools ensure that the design meets specific constraints, such as timing, area, and power, to facilitate the physical implementation.

### Simulation to Verify RTL

RTL simulation is the initial step to validate the functionality of the RTL code. This process uses testbenches to simulate the behavior of the RTL design, ensuring it functions as expected before synthesis. RTL simulation helps identify and correct logical and functional issues, enabling designers to confirm that the design meets requirements.

   <details>
      <summary> 🛠️Implementation using GTKwave</summary>

- **Prepare Verilog Files**
   - Ensure you have:
     - **Verilog source file** (`specfile.v`) — your design under test.
     - **Testbench file** (`testbench.v`) — provides input stimulus and checks the output.

- **Run Icarus Verilog**
   - Use Icarus Verilog to compile your files and create an executable:
     ```bash
     iverilog <specfile.v> <testbench.v>
     ```
   - This produces an `a.out` executable file.

- **Execute Simulation to Generate a VCD File**
   - Run the `a.out` file to generate a **Value Change Dump (VCD)** file:
     ```bash
     ./a.out
     ```
   - This creates `file.vcd`, which stores signal changes over time.

- **View Simulation in GTKWave**
   - Open the `.vcd` file in GTKWave to analyze the simulation:
     ```bash
     gtkwave file.vcd
     ```
   - Inspect signal waveforms and verify design functionality in GTKWave.

![Alt text](<_docs/synthesisP1_1.png>)

   </details>

### Logic Synthesis

Logic synthesis is the process of converting RTL into a gate-level representation by mapping logic elements to actual hardware gates. Synthesis tools use timing, power, and area constraints to optimize the design, generating a netlist that adheres to the design's specifications. This netlist is essential for subsequent stages, such as placement and routing.

   <details>
      <summary> 🛠️Implementation using Yosys</summary>

- **Load the Library**
   - Load the standard cell library to define available cells for synthesis:
     ```bash
     read_liberty -lib <library_path>/<library_file>.lib
     ```

- **Load the RTL Design**
   - Load your Verilog RTL design file:
     ```bash
     read_verilog <design_file>.v
     ```

- **Declare the Top Module**
   - Specify the top-level module to be synthesized:
     ```bash
     synth -top <top_module_name>
     ```

- **Run the Synthesis**
   - Perform the synthesis step, mapping the design to the cells in the library:
     ```bash
     abc -liberty <library_path>/<library_file>.lib
     ```

- **Generate the Netlist Verilog File**
   - Write the synthesized design to a Verilog file. Use `-noattr` to avoid additional attributes:
     ```bash
     write_verilog -noattr <output_netlist_file>.v
     ```
![Alt text](<_docs/synthesisP2_1.png>)
- **View the Output Summary**
   - A summary of the synthesis results, including details on used cells and wiring, will be displayed.

- **View Flow Chart of Cells and Wires**
   - Use the `show` command to generate a flow chart of the synthesized design:

![Alt text](<_docs/synthesisP2_2.png>)
   </details>

### Understanding .lib Files

Library files (often with the .lib extension) provide the synthesis tool with detailed specifications about the cells and components available in a particular technology. These files define the characteristics of each cell type, including timing, power consumption, and area, which the synthesis tool uses to optimize the design according to specified constraints.

A .lib file typically includes multiple variants of logic gates to meet different performance requirements. For example, fast and slow cells are included to satisfy the setup and hold timing constraints, respectively. Faster cells drive more current to quickly charge and discharge the capacitive load in a circuit, achieving low delay. However, this increased speed comes at the cost of greater area and power usage, as faster cells require wider transistors. The synthesis tool selects appropriate cells based on the design’s needs, balancing speed, area, and power to meet timing requirements effectively.

### Hierarchical vs. Flat Synthesis

**Hierarchical Synthesis**  
In hierarchical synthesis, the design is divided into separate modules, each synthesized individually. This approach is ideal for large designs, as it reduces memory usage and synthesis time by focusing on each module independently. It supports modularity and simplifies debugging since changes can be made to specific modules without re-synthesizing the entire design.

<details>
<summary> 🛠️Implementation using Yosys</summary>

By default, synthesizing a top-level module in Yosys employs hierarchical synthesis, where the hierarchy in the generated netlist is maintained. This can be observed in the example below, where both the block diagram and the generated netlist showcase the preserved module hierarchy.
![Alt text](<_docs/synthesisP3_1.png>)
![Alt text](<_docs/synthesisP3_2.png>)

</details>

**Flat Synthesis**  
Flat synthesis treats the design as a single block, synthesizing everything together. This can yield more optimized results in terms of area and speed, but it’s resource-intensive and impractical for large designs. Flat synthesis works best for smaller circuits where global optimizations can provide performance benefits.

<details>
<summary> 🛠️Implementation using Yosys</summary>

The `flatten` command in Yosys converts the design to a flat structure, eliminating all hierarchy. This transformation can be seen in the example below, where the figures illustrate the loss of hierarchy in the flattened design.
![Alt text](<_docs/synthesisP3_3.png>)
![Alt text](<_docs/synthesisP3_4.png>)

</details>

### Synthesising and simulating Flops

**What are Flops?**  
Flip-flops (flops) are sequential elements that store binary data based on a clock signal’s edge. They form the building blocks for registers, counters, and other timing-dependent components.

**Importance of Flops**  
Flops are essential for stable, clock-synchronized data storage and transfer, critical to maintaining timing consistency across a design. They also enable pipelining for performance optimization. Proper placement of flops during synthesis is crucial for meeting timing requirements and minimizing power consumption.

<details>
<summary> 🛠️Flops Simulation</summary>

**Synchronous vs. Asynchronous Flip-Flops**  

- **Synchronous Flip-Flops**: These flip-flops change state only in response to a clock signal, making them ideal for designs where timing control is critical. All data transitions are aligned to the clock, ensuring predictable behavior.
- **Asynchronous Flip-Flops**: These flip-flops can change state independently of the clock, triggered directly by inputs. While they allow faster responses to changes, they can introduce timing uncertainty, making them suitable for specific cases like asynchronous resets.

**Set-Reset Flip-Flops**  

- Set/reset flip-flops have dedicated **set** or **reset** inputs to force the output to a high (set) or low (reset) state, overriding other inputs. These are useful for initializing states or enforcing specific conditions at any time during operation.

Below is a screenshot showing RTL code examples of these flip-flops and their corresponding simulation waveforms.
![Alt text](_docs/synthesisP4_0.png)
Synchronous reset
![Alt text](_docs/synthesisP4_3.png)
Asynchronous reset
![Alt text](_docs/synthesisP4_1.png)
Asynchronous set
![Alt text](_docs/synthesisP4_2.png)

</details>

<details>
<summary> 🛠️Flops Synthesis</summary>

</details>
