#!/bin/bash

input_file=$1
output_file=$2

aline=`cat ${input_file} | grep "Sum of electronic and zero-point Energies"`
var_ezpe=`echo ${aline} | cut -d " " -f 7`
echo ${var_ezpe}

aline=`cat ${input_file} | grep "Sum of electronic and thermal Energies"`
var_u=`echo ${aline} | cut -d " " -f 7`
echo ${var_u}

aline=`cat ${input_file} | grep "Sum of electronic and thermal Enthalpies"`
var_h=`echo ${aline} | cut -d " " -f 7`
echo ${var_h}

aline=`cat ${input_file} | grep "Sum of electronic and thermal Free Energies"`
var_g=`echo ${aline} | cut -d " " -f 8`
echo ${var_g}

aline=`cat ${input_file} | grep 'HF='`
search="HF="
prefix=${aline%%${search}*}
num=${#prefix}
let "num=num+3"
rest_of_line=${aline:${num}}

search='\'
prefix=${rest_of_line%%${search}*}
echo prefix