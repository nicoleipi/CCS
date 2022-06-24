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
input_data_path = args.input
initial_basis="6-31Gd"
basis_sets="6-31Gdp 6-31+Gdp 6-311Gdp 6-311++Gdp 6-311G2df2pd 6-311++G2df2pd"

directory = r'args.input'

for f in os.listdir(directory):
    Path('%s').stem % f
