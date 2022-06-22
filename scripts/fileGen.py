#!/usr/bin/python3

# 2022-06-10
# Nicole I. Pi
# Provided a directory, convert all .xyz files into Gaussian (.com) input files
# Modified 2022-06-21: code reorganized into individual functions to improve modularity + help function added

import os
import sys
import glob
import argparse
from pathlib import Path

parser = argparse.ArgumentParser(description="Provided a directory, convert all .xyz files into Gaussian (.com) input files")
parser.add_argument("-i", "--input", type=str, required=True, help="Directory containing .xyz files")
parser.add_argument("-c", "--charge", type=int, required=True, help="Charge of the molecule")
parser.add_argument("-s", "--spin", type=int, required=True, help="Spin of the molecule")
parser.add_argument("-o", "--output", type=str, required=True, help="Directory that will contain Gaussian .com files")

args = parser.parse.args

#define variables 
input_data_path = args.input
charge = args.charge
spin = args.spin
output_data_path = args.output

print ("input_data_path : ", input_data_path)
print ("charge : ", charge);
print ("spin : ", spin);
print ("output_data_path : ", output_data_path)

raw_xyzfiles = []
for afile in glob.glob(input_data_path + "/*.xyz"):
	raw_xyzfiles.append(Path(afile).name)

#print (str(raw_xyzfiles))

method = ["B3LYP"]
basis = ["6-311G(2df,2pd)", "6-311++G(2df,2pd)", "6-311G(d,p)", "6-311++G(d,p)", "6-31G(d)", "6-31+G(d,p)", "6-31G(d,p)"]
basis_name = ["6-311G2df2pd", "6-311++G2df2pd", "6-311Gdp", "6-311++Gdp", "6-31Gd", "6-31+Gdp", "6-31Gdp"]
basis_header = [2, 2, 2, 2, 1, 2, 2]
charge = [0, 1]
dispersion = ["EmpiricalDispersion=GD3BJ", ""]

for file_id in range(len(raw_xyzfiles)):
    cur_file = raw_xyzfiles[file_id]

    data_file = open(input_data_path + "/" + cur_file, 'r')
    Lines = data_file.readlines()

#read the data of the zyx file
    data_lines = []
    for line in Lines:
        if len(line) > 20:
            data_lines.append(line)

    for i in range(len(method)):
        cur_method = method[i]
        
        for j in range(len(basis)):
            cur_basis = basis[j]
            cur_basis_name = basis_name[j]
            # print (cur_file, " ", cur_method, " ", cur_basis)

            for k in range(len(dispersion)):
                cur_dispersion = dispersion[k]

                cur_isomer = raw_xyzfiles[file_id].split('.')[0]

                header_lines = []
                header_lines.append("%mem=2gb")
                header_lines.append("%nproc=4")
                header_lines.append("chk=" + cur_method + "_" + cur_basis + "_" + str(cur_isomer) + ".chk")
                header_lines.append("")

                if basis_header[j] == 2 :
                    header_lines.append("# " + cur_method + "/" + cur_basis + " " + cur_dispersion + " guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)")
                    header_lines.append("")
                else:
                    header_lines.append("# " + cur_method + "/" + cur_basis + " " + cur_dispersion + " opt=calcfc freq=noraman nosymm integral(ultrafinegrid)")
                    header_lines.append("")

                header_lines.append("Candidate Structure: Conf:" + str(cur_isomer) + " OPT and FREQ calc in gas phase")
                header_lines.append("")
                
                cur_charge = charge

                cur_spin = spin

                header_lines.append(str(cur_charge) + " " + str(cur_spin))

                output_file_path = output_data_path + "/molecule" + str(charge)

                if not os.path.isdir(output_file_path):
                    os.mkdir(output_file_path)

                if k == 0:
                    output_file_name = "D3BJ" + "_" + cur_basis_name + "_" + str(cur_isomer) +".com"
                else:
                    output_file_name = "B3LYP" + "_" + cur_basis_name + "_" + str(cur_isomer) +".com"

                out_f = open(output_file_path + "/" + output_file_name, "a")

                for head_line in header_lines: 
                    out_f.write(head_line + "\n")
                
                if basis_header[j] == 2 :
                    out_f.write("\n")

                for data_line in data_lines:
                    out_f.write(data_line)

                out_f.write("\n")
                out_f.close()