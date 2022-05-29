#!/bin/bash

#input directory variable
in_dir=${1}
#output directory variable
out_dir=${2}

#creates output directory
mkdir -p ${out_dir}

initial_basis="6-31Gd"
basis_sets="6-31Gdp 6-31+Gdp 6-311Gdp 6-311++Gdp 6-311G2df2pd 6-311++G2df2pd"

#creates sub-directories
mkdir -p ${out_dir}/${initial_basis}

for basis in ${basis_sets}
do
    mkdir -p ${out_dir}/${basis}
done

for f in ${in_dir}/*;
do
    #creates the output files
    name=`basename ${f} .com`
    cp ${f} ${out_dir}/${initial_basis}/${name}.com

    for basis in ${basis_sets}
    do
        cp ${f} ${out_dir}/${basis_sets}/${name}.com
    done

    #D3BJ
    sed -i '/B3LYP/ c\# B3LYP\/6-31G(d) EmpiricalDispersion=GD3BJ opt=calcfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-31Gd/${name}.com
    sed -i '/B3LYP/ c\# B3LYP\/6-31G(d,p) EmpiricalDispersion=GD3BJ guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-31Gdp/${name}.com
    awk 'NR==10{print ""}1' ${out_dir}/6-31Gdp/${name}.com
    sed -i '/B3LYP/ c\# B3LYP\/6-31+G(d,p) EmpiricalDispersion=GD3BJ guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-31+Gdp/${name}.com
    awk 'NR==10{print ""}1' ${out_dir}/6-31+Gdp/${name}.com
    sed -i '/B3LYP/ c\# B3LYP\/6-311G(d,p) EmpiricalDispersion=GD3BJ guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-311Gdp/${name}.com
    awk 'NR==10{print ""}1' ${out_dir}/6-311Gdp/${name}.com
    sed -i '/B3LYP/ c\# B3LYP\/6-311++G(d,p) EmpiricalDispersion=GD3BJ guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-311++Gdp/${name}.com
    awk 'NR==10{print ""}1' ${out_dir}/6-311++Gdp/${name}.com
    sed -i '/B3LYP/ c\# B3LYP\/6-311G(2df,2pd) EmpiricalDispersion=GD3BJ guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-31G2df2pd/${name}.com
    awk 'NR==10{print ""}1' ${out_dir}/6-31G2df2pd/${name}.com
    sed -i '/B3LYP/ c\# B3LYP\/6-311++G(2df,2pd) EmpiricalDispersion=GD3BJ guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-311++G2df2pd/${name}.com
    awk 'NR==10{print ""}1' ${out_dir}/6-311++G2df2pd/${name}.com

    #B3LYP
    #sed -i '/B3LYP/ c\# B3LYP\/6-31G(d) opt=calcfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-31Gd/${name}.com
    #sed -i '/B3LYP/ c\# B3LYP\/6-31G(d,p) guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-31Gdp/${name}.com
    #awk 'NR==10{print ""}1' ${out_dir}/6-31Gdp/${name}.com
    #sed -i '/B3LYP/ c\# B3LYP\/6-31+G(d,p) guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-31+Gdp/${name}.com
    #awk 'NR==10{print ""}1' ${out_dir}/6-31+Gdp/${name}.com
    #sed -i '/B3LYP/ c\# B3LYP\/6-311G(d,p) guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-311Gdp/${name}.com
    #awk 'NR==10{print ""}1' ${out_dir}/6-311Gdp/${name}.com
    #sed -i '/B3LYP/ c\# B3LYP\/6-311++G(d,p) guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-311++Gdp/${name}.com
    #awk 'NR==10{print ""}1' ${out_dir}/6-311++Gdp/${name}.com
    #sed -i '/B3LYP/ c\# B3LYP\/6-311G(2df,2pd) guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-311G2df2pd/${name}.com
    #awk 'NR==10{print ""}1' ${out_dir}/6-31G2df2pd/${name}.com
    #sed -i '/B3LYP/ c\# B3LYP\/6-311++G(2df,2pd) guess=read geom=checkpoint opt=readfc freq=noraman nosymm integral(ultrafinegrid)' ${out_dir}/6-311++G2df2pd/${name}.com
    #awk 'NR==10{print ""}1' ${out_dir}/6-311++G2df2pd/${name}.com
done