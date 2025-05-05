# Design and Analysis of 8-bit Approximate Parallel Prefix Adders for Kogge-Stone and Ladner-Fischer Adders

**Author**: Vijaya Sankaran K

## Project Overview
This project focuses on the design and analysis of 8-bit Kogge-Stone and Ladner-Fischer parallel prefix adders, both in their exact and approximate forms. The approximate adders are evaluated using error metrics to assess their performance in terms of accuracy and efficiency. The project is implemented using Verilog for hardware design, MATLAB for error analysis, and ModelSim for simulation.

## Folder Structure

- **verilog/**  
  Contains Verilog code for the adders and testbench:
  - `kogge_stone_8bit.v`: Exact 8-bit Kogge-Stone Adder  
  - `ladner_fischer_8bit.v`: Exact 8-bit Ladner-Fischer Adder  
  - `kogge_stone_approx.v`: Approximate 8-bit Kogge-Stone Adder  
  - `ladner_fischer_approx.v`: Approximate 8-bit Ladner-Fischer Adder  
  - `test_adder_tb.v`: Testbench for all four adders  

- **matlab/**  
  Contains MATLAB scripts for generating input vectors and analyzing error metrics:
  - `generate_inputs.m`: Generates 10,000 random input vectors for testing  
  - `analyze_errors.m`: Calculates error metrics using the output from simulations  

- **simulation/**  
  Contains simulation files and output results:
  - `simulate_all.do`: ModelSim `.do` file to automate simulation  
  - `ks_exact_outputs.txt`: Output for exact Kogge-Stone  
  - `ks_approx_outputs.txt`: Output for approximate Kogge-Stone  
  - `lf_exact_outputs.txt`: Output for exact Ladner-Fischer  
  - `lf_approx_outputs.txt`: Output for approximate Ladner-Fischer  

## Prerequisites

1. **ModelSim**: Ensure that you have ModelSim installed on your system. This is used for simulating the Verilog designs.
2. **MATLAB**: MATLAB is required for generating input vectors and analyzing error metrics.
3. **Directory Path**: Before running the project, ensure to modify the file paths in the Verilog and MATLAB files (e.g., `d:/project/...`) to match your system's directory structure.

## How to Run the Project

### Step 1: Generate Input Vectors
Run the `generate_inputs.m` script in MATLAB to generate the random input vectors for testing:
```matlab
>> generate_inputs
```
This will generate a file input_vectors.txt containing 10,000 random test vectors.
### Step 2:Run ModelSim Simulation
Open the command window or command prompt, navigate to the directory where your project is saved, and then navigate to the simulation folder. In ModelSim, run the simulation by typing:
```bash
>>vsim -do simulate_all.do
```
This will simulate all the Verilog modules and generate the output files in the simulation folder.

### Step 3: Analyze Error Metrics
After simulation, run the `analyze_errors.m` script in MATLAB to calculate the error metrics using the output files from the simulation:
```matlab
>>analyze_errors
```
This will compute various error metrics (such as Error Rate, MSE, etc.) for the adders.

