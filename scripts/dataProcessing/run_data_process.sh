#!/bin/bash
data_path=/cygdrive/c/Users/pinic/Documents/REHS21/CCS2/data
output_path=/cygdrive/c/Users/pinic/Documents/REHS21/CCS2/output
model=$1
output_name=$2
ccs_search_output=""

function find_value {

    search_file=$1
    search_string=$2

    tmp_value=""

    while read -r aline; 
    do
        input_ccs=`echo $aline | cut -d "," -f1`

        if [ "$input_ccs" == ${search_string} ]; then
            tmp_value=`echo $aline | cut -d "," -f2`
        fi
    done < ${search_file}

    if [ ${#tmp_value} -eq 0 ]; then
        tmp_value=0
    fi

    ccs_search_output=${tmp_value}

}


cd $data_path/$model/basis_set
cat *.csv > /tmp/output_all.csv
cat /tmp/output_all.csv | cut -d "," -f1  | sort |uniq > /tmp/list_ccs_value

while read -r ccs;
do
    
    if [ ${#ccs} -gt 0 ]; then
        echo "$ccs ${#ccs}" ;

        echo "basis_set,CCS" > ${output_path}/${output_name}_${ccs}.csv

        find_value $data_path/$model/basis_set/${output_name}_6-31+Gdp.csv ${ccs}
        echo 4,${ccs_search_output} >> ${output_path}/${output_name}_${ccs}.csv

        find_value $data_path/$model/basis_set/${output_name}_6-31Gd.csv ${ccs}
        echo 0,${ccs_search_output} >> ${output_path}/${output_name}_${ccs}.csv

        find_value $data_path/$model/basis_set/${output_name}_6-31Gdp.csv ${ccs}
        echo 1,${ccs_search_output} >> ${output_path}/${output_name}_${ccs}.csv

        find_value $data_path/$model/basis_set/${output_name}_6-311++G2df2pd.csv ${ccs}
        echo 6,${ccs_search_output} >> ${output_path}/${output_name}_${ccs}.csv

        find_value $data_path/$model/basis_set/${output_name}_6-311++Gdp.csv ${ccs}
        echo 5,${ccs_search_output} >> ${output_path}/${output_name}_${ccs}.csv

        find_value $data_path/$model/basis_set/${output_name}_6-311G2df2pd.csv ${ccs}
        echo 3,${ccs_search_output} >> ${output_path}/${output_name}_${ccs}.csv

        find_value $data_path/$model/basis_set/${output_name}_6-311Gdp.csv ${ccs}
        echo 2,${ccs_search_output} >> ${output_path}/${output_name}_${ccs}.csv

    fi

done < /tmp/list_ccs_value