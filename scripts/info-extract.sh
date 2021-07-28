#!/bin/bash

input_file=$1
output_file=$2

basis_sets=("6-31G(d)" "6-31G(d,p)" "6-31+G(d,p)" "6-311G(d,p)" "6-311++G(d,p)" "6-311G(2df,2pd)" "6-311++G(2df,2pd)")

for i in ${!basis_sets[@]};
do 
    num=0
    basis=${basis_sets[$i]}
    num=`grep ${basis} ${input_file} | wc -l`
    if [ ${num} -gt 0 ]; then
        basis_set=${basis}
    fi
done
#echo ${basis_set}

aline=`cat ${input_file} | grep "Sum of electronic and zero-point Energies"`
var_ezpe=`echo ${aline} | cut -d " " -f 7`
#echo ${var_ezpe}

aline=`cat ${input_file} | grep "Sum of electronic and thermal Energies"`
var_u=`echo ${aline} | cut -d " " -f 7`
#echo ${var_u}

aline=`cat ${input_file} | grep "Sum of electronic and thermal Enthalpies"`
var_h=`echo ${aline} | cut -d " " -f 7`
#echo ${var_h}

aline=`cat ${input_file} | grep "Sum of electronic and thermal Free Energies"`
var_g=`echo ${aline} | cut -d " " -f 8`
#echo ${var_g}

aline=`cat ${input_file} | grep 'HF='`
search="HF="
prefix=${aline%%${search}*}
num=${#prefix}
let "num=num+3"
rest_of_line=${aline:${num}}
search='\\'
var_e=${rest_of_line%%${search}*}
#echo ${var_e}

echo "${basis_set}, ${var_ezpe}, ${var_u}, ${var_h}, ${var_g}, ${var_e}" >> ${output_file}