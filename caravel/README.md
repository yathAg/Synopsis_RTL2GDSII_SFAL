# Caravel Core Project

## Directory Structure

- **RTL**: Contains Verilog files for the design.
- **PDK**: Contains the SCL180 wrapper and Sky130 library files.
- **dv**: Contains the testbench files, specifically for `hkspi`.

## Running the Testbench

To run the `hkspi` testbench, follow these steps:

1. Export the following environment variables:

    ```bash
    export GCC_PATH=<path_to_riscv_gcc>
    export GCC_PREFIX=<gcc_prefix>
    export SCL_PDK_PATH=<path_to_scl_pdk>
    ```

2. Navigate to the `hkspi` directory:

    ```bash
    cd dv/hkspi
    ```

3. Run the make command to start the testbench:

    ```bash
    make
    ```

![alt text](<../_docs/Screenshot from 2024-11-10 00-59-22.png>)

## Reason for Multi-PDK Usage

Some cells referenced in [simple_por.v](rtl/simple_por.v) are missing in the SCL180 library, necessitating the use of both SCL180 and Sky130 PDKs to ensure compatibility and functionality.
