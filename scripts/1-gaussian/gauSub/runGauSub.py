#!/usr/bin/python3

# 2022-06-24
# Nicole I. Pi
# Provided a directory, submit Gaussian jobs using the input files

from mimetypes import init
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
input = args.input
script_path = os.getcwd()
method = ["B3LYP", "D3BJ"]
initial_basis = "6-31Gd"
basis_sets = ["6-31Gdp", "6-31+Gdp", "6-311Gdp", "6-311++Gdp", "6-311G2df2pd", "6-311++G2df2pd"]

for i in range(len(method)):
    a_method = method[i]
    file_pattern = input+"/"+a_method+"_"+initial_basis+"_*.com"
    initial_file_list = glob.glob(file_pattern)
    
    for j in range(len(initial_file_list)):
        a_file = os.path.basename(initial_file_list[j])
        a_filename = os.path.splitext(a_file)[0]
        var = a_filename.split("_")
        isomer = var [2]
        print(isomer)
        os.chdir(input)
        run_command = "bash "+script_path+"/gauSub.sh "+a_filename+".com > /tmp/job_id"
        #os.system(run_command)
        print(run_command)

        with open("/tmp/job_id") as f:
            lines = f.read()
            first_line = lines.split('\n', 1)[0]
            split = first_line.split(" ")
            job_id = split [3]
            job_id = str(job_id)
        print(job_id)

        for k in range(len(basis_sets)):
            dep_command = "bash "+script_path+"/gauSub.sh -c "+a_filename+".chk -d "+job_id+" "+method[i]+"_"+basis_sets[k]+"_"+isomer+".com"
            #os.system(dep_command)
            print(dep_command)
        
        #os.system(run_command)
        #job_id=$(${full_path}/gau-sub.sh ${job})

