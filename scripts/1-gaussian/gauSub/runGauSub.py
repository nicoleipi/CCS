#!/usr/bin/python3

# 2022-06-24
# Nicole I. Pi
# Provided a directory, submit Gaussian jobs using the input files

import os
import sys
import glob
import argparse
from pathlib import Path

# helpdesk
parser = argparse.ArgumentParser(description="Provided a directory, submit Gaussian jobs using the input files")
parser.add_argument("-i", "--input", type=str, required=True, help="Directory containing Gaussian .com files")
parser.add_argument("-o", "--output", type=str, required=True, help="Directory that will contain Gaussian .log files")
args = parser.parse_args()

# variables 
script_path = os.getcwd()
initial_basis = ["6-31Gd"]
basis_sets = ["6-31Gdp", "6-31+Gdp", "6-311Gdp", "6-311++Gdp", "6-311G2df2pd", "6-311++G2df2pd"]

directory = r'%s' % args.input

for f in os.listdir(directory):

    filename = os.path.splitext(f)[0]
    variables = filename.split("_")
    method = variables[0]
    basis = variables [1]
    isomer = variables [2]
    print (method)
    print (basis)
    print (isomer
            
    chk_name = filename.chk
    
    job_id = gauSub.sh ${f}
    job_id = os.path.splitext(job_id)[3]

    for basis in range(len(basis_sets)):    
        cd input_data_path
        script_path/gauSub.sh -c directory/chk_name -d job_id 
