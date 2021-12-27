# Boltzmann-Averaged CCS Calculation Workflow

Description
--------

Repository Structure
--------
<pre><code><b>📂 data  </b>
└──📁 model#  
    └──📁 DFT method  
        ├──📁 basis_set  
        │   └──📄 Data in seperated by basis set, with one data-containing .csv file per basis set  
        └──📁 isomer  
            ├──📄 Data in seperated by isomer, with one data-containing .csv file per isomer  
            └──📄 File structure: Basis (basis set), EZPE (energy + zero-point correction), U (internal energy), H (enthalpy), G (Gibbs free energy), E (electronic energy), boltz_G (Boltzmann average calculated using G), boltz_E (Boltzmann average calculated using E)  
  
<b>📂 diagrams  </b>
└──📁 model#  
    └──📄 3D models of the isomers generated using VMD  
  
<b>📂 inputs  </b>
└──📁 model#  
    ├──📁 DFT method  
    │   └──📁 basis set  
    │       ├──📁 gaussian  
    │       │   └──📄 Gaussian .com input file)  
    │       └──📁 pqr  
    │           └──📄 HPCCS .pqr input files  
    └──📁 xyz  
        └──📄 .xyz files for each isomer  
  
<b>📂 outputs  </b>
└──📁 model#  
    └──📁 DFT method  
        └──📁 basis set  
            ├──📁 gaussian  
            │   └──📄 Gaussian .log output files containing the energy and frequency calculations  
            └──📁 hpccs  
                └──📄 HPCCS .out output files containing the CCS calculation  
  
<b>📂 plots  </b>
└──📁 model#  
    ├──📁 DFT method  
    │   ├──📁 boltzmann  
    │   │   └──📈 x-axis: basis set, y-axis: relative population  
    │   ├──📁 compare_rela_pop  
    │   │   └──📊 x-axis: isomer, y-axis: relative population  
    │   ├──📁 energy  
    │   │   └──📊 x-axis: energy in Hartree, y-axis: basis set  
    │   └──📁 relative_population  
    │       └──📊 x-axis: relative population, y-axis: basis set  
    ├──📁 final  
    │   └──📈 final plots used in my REHS 2021 presentation  
    └──📁 full  
        └──📈 all relative populations graphed together  
  
<b>📂 scripts </b>(ReadME files for each scripts are in their respective folders)  
├──📁 1-gaussian (step 1)  
│   └──📃 generates Gaussian inputs and organizes outputs
├──📁 2-boltz-avg (step 2)  
│   └──📃 calculates the Boltzmann averages
├──📁 3-hpccs (step 3)  
│   └──📁 calculates the CCS values
└──📁 4-boltz-weight (step 4)  
    └──📁 finds the Boltzmann averaged CCS value of each model  </pre></code>