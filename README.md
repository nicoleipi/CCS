# DFT Geometry Optimization with Gaussian

file-modifier.sh
--------
* Generates a folder with sub-folders containing modified Gaussian input files from a folder of Gaussian input files
* A sub-folder is created for each of the following basis sets:
    - 6-31G(d)
    - 6-31G(d,p)
    - 6-31+G(d,p)
    - 6-311G(d,p)
    - 6-311++G(d,p)
    - 6-311G(2df,2pd)
    - 6-311++G(2df,2pd)
* Example: `./file-modifier.sh /path/to/folder/with/Gaussian/input/files /path/to/folder/with/modified/Gaussian/input/files`
* Example folder structure after `file-modifier.sh` is run:
    ```
    /folder/with/modified/Gaussian/input/files
        +- 6-31Gd
            +- opt_freq-conf-118.com
            +- ...
        +- 6-31Gdp
            +- opt_freq-conf-118.com
            +- ...
        +- ...
            +- ...
* `file-modifier.sh` is currently set to generate input files with the B97D3 DFT method. To change the DFT method the input files will be modified to, replace B97D3 with your DFT method of choice
* The output folder will be created in the directed that `file-modifier.sh` is initiated
* Disclaimer: Nicole knows that the script is a bit tedious and that there's bably cleaner scripting methods of achieving the same results, but this solution works (for now)

sub-jobs.sh
--------
* Submits a job for each file in a directory with `gau-sub.sh`
* Example: `./sub-jobs.sh /path/to/folder/with/Gaussian/input/files`
* Works for folders with subfolders that contain Gaussian input files
* Currently, the variable `exec_path` is set to the full path that `sub-jobs.sh` is located in on Aerosol for Nicole. To run the script, change `exec_path` to where you have `sub-jobs.sh` located--you can use `pwd`