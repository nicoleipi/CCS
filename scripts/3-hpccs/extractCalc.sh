#!/bin/bash

path=/scratch/nicole/CCS2

function one_model_subdir() {
	full_path=$1
	sub_dir=$2
	for f in ${full_path}/${sub_dir}/*.out;
	do
		name=`basename ${f} .out`
		name=`echo ${name} | cut -d "_" -f 2`
		name=`echo ${name} | cut -d "-" -f 3`
		cs=`cat ${f} | grep -i "Average TM cross section"`
		cs=`echo ${cs} | cut -d " " -f 6`
		
		method=`echo ${full_path} | cut -d "/" -f 5`
		echo "${name},${cs}" >> ${method}_${sub_dir}.csv
	done

}

function one_model() {
	model_path=$1
	one_model_subdir ${model_path} 6-311G2df2pd  
	one_model_subdir ${model_path} 6-311++G2df2pd  
	one_model_subdir ${model_path} 6-311Gdp  
	one_model_subdir ${model_path} 6-311++Gdp  
	one_model_subdir ${model_path} 6-31Gd  
	one_model_subdir ${model_path} 6-31+Gdp  
	one_model_subdir ${model_path} 6-31Gdp 
}

one_model ${path}/model1_B3LYP  
one_model ${path}/model1_D3BJ  
one_model ${path}/model4_B3LYP  
one_model ${path}/model4_D3BJ 
