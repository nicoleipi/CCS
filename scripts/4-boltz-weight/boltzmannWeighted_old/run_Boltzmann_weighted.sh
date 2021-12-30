#!/bin/bash

main_data_path=/cygdrive/c/Users/pinic/Documents/REHS21/CCS/data
model_path=$1
boltzmann_file_name=$2
ccs_file_name=$3
boltzmann_path=${main_data_path}/${model_path}/boltzmann
ccs_path=${main_data_path}/${model_path}/ccs
output_path=${main_data_path}/${model_path}/final_calc

num_rows=30
num_columns=3
actual_num_rows=0
declare -A boltzmann_v
declare -a ccs_v

for ((i=1;i<=num_rows;i++)) do
    ccs_v[$i]=0
    for ((j=1;j<=num_columns;j++)) do
        boltzmann_v[$i,$j]=0
    done
done

function calculte_boltzmann() {

    input_fileid=$1

    id=0
    while read -r aline; 
    do
        #echo $aline
        if [ $id -ge 1 ]; then
            read_id=`echo $aline | cut -d "," -f1`
            
            let "read_id = read_id + 1"
            #echo $read_id `echo $aline | cut -d "," -f2`
            ccs_v[$read_id]=`echo $aline | cut -d "," -f2`
        fi
        let "id = id + 1"
    done < ${ccs_path}/${ccs_file_name}_${input_fileid}.csv

    echo ${ccs_v[1]}

    echo $id ccs value imported

    # fix a problem of incomplete last line in boltzmann file
    num_lines=`cat ${boltzmann_path}/${boltzmann_file_name}_${input_fileid}.csv|wc -l`
    if [ $num_lines -eq 7 ]; then
        echo >> ${boltzmann_path}/${boltzmann_file_name}_${input_fileid}.csv
    fi

    id=0
    while read -r aline; 
    do
        #echo $aline
        if [ $id -ge 1 ]; then
            boltzmann_v[$id, 1]=`echo $aline | cut -d "," -f2`
            boltzmann_v[$id, 2]=`echo $aline | cut -d "," -f3`
        fi

        let "id = id + 1"
    done < ${boltzmann_path}/${boltzmann_file_name}_${input_fileid}.csv
    #cat  ${boltzmann_path}/${boltzmann_file_name}_${input_fileid}.csv | wc -l

    echo $id boltzmann cofficient imported

    # create output file
    echo "basis_set,G,E" > $output_path/${ccs_file_name}_${input_fileid}.csv
    id=0
    index=1
    while [ $id -lt 7 ]; do

        #echo ${boltzmann_v[$index, 1]} ${boltzmann_v[$index, 2]} 
        #${ccs_v[$index]}

        a1=${boltzmann_v[$index, 1]}
        a2=${boltzmann_v[$index, 2]}
        b1=${ccs_v[$index]}

        cal_1=`awk -v a="$a1" -v b="$b1" 'BEGIN { printf "%.6e\n", a * b }'`
        cal_2=`awk -v a="$a2" -v b="$b1" 'BEGIN { printf "%.6e\n", a * b }'`

        echo $id"," $cal_1"," $cal_2 >> $output_path/${ccs_file_name}_${input_fileid}.csv

        let "id = id + 1"
        let "index = index + 1"
    done

}

# get a list of subfolder
for filename in ${ccs_path}/*.csv; do
    fileid=`echo $filename | cut -d "_" -f4`
    extracted_id=${fileid:0:3}

    echo "  -- $extracted_id -- "

    calculte_boltzmann $extracted_id

done
