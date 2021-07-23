#!/bin/bash

#input directory variable
in_dir=${1}
#output directory variable
out_dir=${2}

#creates output directory
mkdir -p ${out_dir}

#creates sub-directories
mkdir -p ${out_dir}/6-31Gd
mkdir -p ${out_dir}/6-31Gdp
mkdir -p ${out_dir}/6-31+Gdp
mkdir -p ${out_dir}/6-311Gd
mkdir -p ${out_dir}/6-311++Gd
mkdir -p ${out_dir}/6-31G2df2pd
mkdir -p ${out_dir}/6-311++G2df2pd

for f in ${in_dir}/*;
do
    #creates the output files
    name=`basename ${f} .com`
    cp ${f} ${out_dir}/6-31Gd/${name}.com
    cp ${f} ${out_dir}/6-31Gdp/${name}.com
    cp ${f} ${out_dir}/6-31+Gdp/${name}.com
    cp ${f} ${out_dir}/6-311Gd/${name}.com
    cp ${f} ${out_dir}/6-311++Gd/${name}.com
    cp ${f} ${out_dir}/6-31G2df2pd/${name}.com
    cp ${f} ${out_dir}/6-311++G2df2pd/${name}.com

    sed -i '/B3LYP/ c\B3LYP-D3(BJ)' ${out_dir}/6-31Gd/${name}.com
    sed -i '/B3LYP/ c\B3LYP-D3(BJ)' ${out_dir}/6-31Gdp/${name}.com
    sed -i '/B3LYP/ c\B3LYP-D3(BJ)' ${out_dir}/6-31+Gdp/${name}.com
    sed -i '/B3LYP/ c\B3LYP-D3(BJ)' ${out_dir}/6-311Gd/${name}.com
    sed -i '/B3LYP/ c\B3LYP-D3(BJ)' ${out_dir}/6-311++Gd/${name}.com
    sed -i '/B3LYP/ c\B3LYP-D3(BJ)' ${out_dir}/6-31G2df2pd/${name}.com
    sed -i '/B3LYP/ c\B3LYP-D3(BJ)' ${out_dir}/6-311++G2df2pd/${name}.com

    sed -i '/6-31+G(d,p)/ c\6-31G(d)' ${out_dir}/6-31Gd/${name}.com
    sed -i '/6-31+G(d,p)/ c\6-31G(d,p)' ${out_dir}/6-31Gdp/${name}.com
    sed -i '/6-31+G(d,p)/ c\6-31+G(d,p)' ${out_dir}/6-31+Gdp/${name}.com
    sed -i '/6-31+G(d,p)/ c\6-311G(d,p)' ${out_dir}/6-311Gd/${name}.com
    sed -i '/6-31+G(d,p)/ c\6-311++G(d,p)' ${out_dir}/6-311++Gd/${name}.com
    sed -i '/6-31+G(d,p)/ c\6-311G(2df,2pd)' ${out_dir}/6-31G2df2pd/${name}.com
    sed -i '/6-31+G(d,p)/ c\6-311++G(2df,2pd)' ${out_dir}/6-311++G2df2pd/${name}.com
done