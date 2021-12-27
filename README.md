# Boltzmann-Averaged CCS Calculation Workflow

Repository Structure
--------
`data`  
├─ model#  
│  ├─ DFT method  
│  │  ├─ basis_set  
│  │  │  ├─ Data in seperated by basis set, with one data-containing .csv file per basis set  
│  │  ├─ isomer  
│  │  │  ├─Data in seperated by isomer, with one data-containing .csv file per isomer  
│  │  │  ├─File structure: Basis (basis set), EZPE (energy + zero-point correction), U (internal energy), H (enthalpy), G (Gibbs free energy), E (electronic energy), boltz_G (Boltzmann average calculated using G),boltz_E (Boltzmann average calculated using E)
* `diagrams`
    - model#
        - 3D models of the isomers generated using VMD
* `inputs`
    - model#
        - DFT method
            - basis set
                - gaussian (Gaussian .com input files)
                - pqr (HPCCS .pqr input files)
        - xyz
            - .xyz files for each isomer
* `outputs`
    - model#
        - DFT method
            - basis set
                - gaussian (Gaussian .log output files containing the energy and frequency calculations)
                - hpccs (HPCCS .out output files containing the CCS calculation)
* `plots`
    - model#
        - DFT method
            - boltzmann (x-axis: basis set, y-axis: relative population)
            - compare_rela_pop (x-axis: isomer, y-axis: relative population)
            - energy (x-axis: energy in Hartree, y-axis: basis set)
            - relative_population (x-axis: relative population, y-axis: basis set)
        - final 
            - final plots used in my REHS 2021 presentation
        - full
            - all relative populations graphed together
* `scripts` (ReadME files for each scripts are in their respective folders)
    - 1-gaussian (step 1)
        - file-modifier.sh: generate Gaussian input files
        - gauSub: submit Gaussian jobs
        - info-extract.sh: extract info from Gaussian output files
    - 2-boltz-avg (step 2)
        - boltzAvg.ipynb: calculate the Boltzmann average
        - addBoltzAvg2energy.sh and runAddBoltzAvg2energy.sh: merge energy and boltzmann .csv files
        - plotting
            - boltzAvgData
                - model#
                    - basis set
                        - .csv files for plotted data
            - script naming scheme: x-axis_y-axis.ipynb
    - 3-hpccs (step 3)
        - log2pqr: generate HPCCS .pqr input files from Gaussian .log output files
        - extractCalc.sh: extract CCS values from HPCCS .out output files
        - dataProcessing: reorganize extract CCS values
        - organize.sh: one-time script to organize files in the /input folder
        - reorder.sh: not sure
    - 4-boltz-weight (step 4)
        - boltzmannWeighted: multiply the CCS value by the Boltzmann average relative population