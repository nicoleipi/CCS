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
mkdir -p ${out_dir}/6-311Gdp
mkdir -p ${out_dir}/6-311++Gdp
mkdir -p ${out_dir}/6-311G2df2pd
mkdir -p ${out_dir}/6-311++G2df2pd

for f in ${in_dir}/*;
do
    #creates the output files
    name=`basename ${f} .com`
    cp ${f} ${out_dir}/6-31Gd/${name}.com
    cp ${f} ${out_dir}/6-31Gdp/${name}.com
    cp ${f} ${out_dir}/6-31+Gdp/${name}.com
    cp ${f} ${out_dir}/6-311Gdp/${name}.com
    cp ${f} ${out_dir}/6-311++Gdp/${name}.com
    cp ${f} ${out_dir}/6-311G2df2pd/${name}.com
    cp ${f} ${out_dir}/6-311++G2df2pd/${name}.com

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
