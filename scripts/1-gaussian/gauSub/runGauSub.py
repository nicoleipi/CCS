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
script_path = os.getcwd()
method = ["B3LYP", "D3BJ"]
initial_basis = "6-31Gd"
basis_sets = ["6-31Gdp", "6-31+Gdp", "6-311Gdp", "6-311++Gdp", "6-311G2df2pd", "6-311++G2df2pd"]

for i in range(len(method)):
    a_method = method[i]
    initial_file_list = glob.glob('a_method+"_"+initial_basis+"*.com"')
        
    for j in range(len(initial_file_list)):
        a_file = initial_file_list[j]
        a_filename = os.path.splitext(a_file)[0]
        var = a_filename.split("_")
        isomer = var [2]
        print(isomer)

