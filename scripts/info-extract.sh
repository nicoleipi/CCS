#!/bin/bash

in_dir=${1}

basis_sets=("6-31G(d)" "6-31G(d,p)" "6-31+G(d,p)" "6-311G(d,p)" "6-311++G(d,p)" "6-311G(2df,2pd)" "6-311++G(2df,2pd)")

find ${in_dir} -name "*.log" > log_files.txt
exec_path=/aerosol/users/nicole/CCS

while read -r aline; do
    file_path=`dirname ${aline}`
    file_name=`basename ${aline}`

    cd ${exec_path}/${file_path}

    for i in ${!basis_sets[@]}
    do
        num=0
        basis=${basis_sets[$i]}
        num=`grep ${basis} ${file_name} | wc -l`
        if [ ${num} -gt 0 ]; then
            basis_set=${basis}
        fi
    done
    #echo ${basis_set}

    full_line=`cat ${file_name} | grep -i "Sum of electronic and zero-point Energies"`
    var_ezpe=`echo ${full_line} | cut -d " " -f 7`
    #echo ${var_ezpe}

    full_line=`cat ${file_name} | grep -i "Sum of electronic and thermal Energies"`
    var_u=`echo ${full_line} | cut -d " " -f 7`
    #echo ${var_u}

    full_line=`cat ${file_name} | grep -i "Sum of electronic and thermal Enthalpies"`
    var_h=`echo ${full_line} | cut -d " " -f 7`
    #echo ${var_h}

    full_line=`cat ${file_name} | grep -i "Sum of electronic and thermal Free Energies"`
    var_g=`echo ${full_line} | cut -d " " -f 8`
    #echo ${var_g}

    full_line=`cat ${file_name} | grep 'HF='`
    search="HF="
    prefix=${full_line%%${search}*}
    num=${#prefix}
    let "num=num+3"
    rest_of_line=${full_line:${num}}
    search='\\'
    unformat_e=`echo ${rest_of_line%%${search}*}`
    var_e=`echo "${unformat_e}"`
    #echo ${var_e}

    name=`basename ${file_name} .log`

    echo "${name}, ${basis_set}, ${var_ezpe}, ${var_u}, ${var_h}, ${var_g}, ${var_e}" >> ${exec_path}/BY_model4_data.csv

done <${exec_path}/log_files.txt

sort -k 2n ${exec_path}/BY_model4_data.csv > tmp.txt
mv tmp.txt ${exec_path}/BY_model4_data.csv