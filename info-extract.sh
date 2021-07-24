#!/bin/bash

input_file=$1
output_file=$2

aline=`cat ${input_file} | grep "Sum of electronic and zero-point Energies"`
var_u=`echo ${aline} | cut -d " " -f 7`
echo ${var_u}