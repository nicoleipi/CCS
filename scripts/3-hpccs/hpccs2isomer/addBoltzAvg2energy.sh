#!/bin/bash

base_folder=$1
ccs_folder=${base_folder}/ccs
isomer_folder=${base_folder}/isomer
output_folder=${base_folder}/isomer2
mkdir ${output_folder}

function merge() {
    input_filename=$1
    css_filename=`echo ${input_filename} | cut -d "_" -f 1,2,4`

    dos2unix ${ccs_folder}/${input_filename}
    num_lines=`cat ${ccs_folder}/${input_filename}|wc -l`
    if [ $num_lines -eq 7 ]; then
        echo >> ${ccs_folder}/${css_filename}
    fi

    dos2unix ${isomer_folder}/${input_filename}
    num_lines=`cat ${isomer_folder}/${input_filename}|wc -l`
    if [ $num_lines -eq 7 ]; then
        echo >> ${isomer_folder}/${input_filename}
    fi

    id=1
    while read -r aline; 
    do
        if [ $id -gt 1 ]; then
            output_line_ccs[$id]=${aline:2}
        fi
        #echo $id ${output_line_ccs[$id]}
        let "id = id + 1"
    done < ${ccs_folder}/${css_filename}

    id=1
    while read -r aline; 
    do
        if [ $id -gt 1 ]; then
            output_line_isomer[$id]=${aline}
        fi
        #echo $id ${output_line_isomer[$id]}
        let "id = id + 1"
    done < ${isomer_folder}/${input_filename}
    
    echo "Basis,EZPE,U,H,G,E,boltz_G,boltz_E,CCS" > ${output_folder}/${css_filename}
    c=2
    while [ $c -lt 9 ]
    do
        echo ${output_line_isomer[$c]}","${output_line_ccs[$c]} >> ${output_folder}/${css_filename}
        let "c = c+1"
    done
}

#cd ${ccs_folder}
for f in ${isomer_folder}/*.csv; do
    filename=`basename ${f}`
    merge $filename
done