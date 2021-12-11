#!/bin/bash

function one_conf() {
    num=${1}
    rm data/model1/${1}.csv
    echo "basis_set,ccs" >> data/model1/${1}.csv

    for f in data/B3LYP_model1/*;
    do
        name=`basename ${f} .csv`
        name=`echo ${name} | cut -d "_" -f 3`

        ccs=`cat ${f} | grep ${1}`
        ccs=`echo ${ccs} | cut -d "," -f 2`
        
        d3bj=`cat data/D3BJ_model1/model1_D3BJ_${name}.csv | grep ${1}`
        d3bj=`echo ${d3bj} | cut -d "," -f 2`
        
        echo "${name},${ccs},${d3bj}" >> data/model1/${1}.csv
    done
}

one_conf 214
one_conf 301
one_conf 318
one_conf 342
one_conf 55
one_conf 580
one_conf 628
one_conf 661
one_conf 715
one_conf 719
one_conf 862
one_conf 885