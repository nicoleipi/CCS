#!/bin/bash

function one_model_subdir() {
	model_path=$1
	sub_dir=$2
	python_path0=/aerosol/users/nicole/CCS2/log2Pqr.py
	python_path=/aerosol/users/nicole/CCS2/runLog2Pqr.py
	cd /aerosol/users/nicole/CCS2/${model_path}/${sub_dir} 
	cp ${python_path0} /aerosol/users/nicole/CCS2/${model_path}/${sub_dir}
	cp ${python_path} /aerosol/users/nicole/CCS2/${model_path}/${sub_dir}
	python3 runLog2Pqr.py
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

one_model model1_B3LYP  
one_model model1_D3BJ  
one_model model4_B3LYP  
one_model model4_D3BJ 
