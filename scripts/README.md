<b>📂 scripts </b>(ReadME files for each scripts are in their respective folders)  
├──📁 1-gaussian (step 1)  
│   ├──📃 file-modifier.sh: generate Gaussian input files  
│   ├──📁 gauSub: submit Gaussian jobs  
│   └──📃 info-extract.sh: extract info from Gaussian output files  
├──📁 2-boltz-avg (step 2)  
│   ├──📃 boltzAvg.ipynb: calculate the Boltzmann average  
│   ├──📁 boltzAvg2energy: merge energy and boltzmann .csv files  
│   └──📁 plotting  
│       ├──📁 boltzAvgData  
│       │   └──📁 model#  
│       │       └──📁 basis set  
│       │           └──📄 .csv files for plotted data  
│       └──📃 script naming scheme: x-axis_y-axis.ipynb  
├──📁 3-hpccs (step 3)  
│   ├──📁 log2pqr: generate HPCCS .pqr input files from Gaussian .log output files  
│   ├──📃 extractCalc.sh: extract CCS values from HPCCS .out output files  
│   ├──📁 dataProcessing: reorganize extract CCS values  
│   ├──📃 organize.sh: one-time script to organize files in the /input folder  
│   └──📃 reorder.sh: not sure  
└──📁 4-boltz-weight (step 4)  
    └──📁 boltzmannWeighted: multiply the CCS value by the Boltzmann average relative population  
</pre></code>