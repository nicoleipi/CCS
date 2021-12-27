#!/bin/bash

base_folder=$1
boltz_folder=${base_folder}/boltzmann
energy_folder=${base_folder}/energy
output_folder=${base_folder}/isomer
mkdir ${output_folder}

function merge() {
    input_filename=$1

    dos2unix ${boltz_folder}/${input_filename}
    num_lines=`cat ${boltz_folder}/${input_filename}|wc -l`
    if [ $num_lines -eq 7 ]; then
        echo >> ${boltz_folder}/${input_filename}
    fi

    dos2unix ${energy_folder}/${input_filename}
    num_lines=`cat ${energy_folder}/${input_filename}|wc -l`
    if [ $num_lines -eq 7 ]; then
        echo >> ${energy_folder}/${input_filename}
    fi

    id=1
    while read -r aline; 
    do
        if [ $id -gt 1 ]; then
            output_line_boltz[$id]=${aline:2}
        fi
        #echo $id ${output_line_boltz[$id]}
        let "id = id + 1"
    done < ${boltz_folder}/${input_filename}

    id=1
    while read -r aline; 
    do
        if [ $id -gt 1 ]; then
            output_line_energy[$id]=${aline}
        fi
        #echo $id ${output_line_energy[$id]}
        let "id = id + 1"
    done < ${energy_folder}/${input_filename}
    
    echo "Basis,EZPE,U,H,G,E,boltz_G,boltz_E" > ${output_folder}/${input_filename}
    c=2
    while [ $c -lt 9 ]
    do
        echo ${output_line_energy[$c]}","${output_line_boltz[$c]} >> ${output_folder}/${input_filename}
        let "c = c+1"
    done
}

#cd ${boltz_folder}
for f in ${boltz_folder}/*.csv; do
    filename=`basename ${f}`
    merge $filename
done