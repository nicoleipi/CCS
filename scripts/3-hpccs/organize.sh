#!/bin/bash

path=/scratch/nicole/CCS2

function dir() {
	full_path=$1
	
	for d in ${full_path}/*;
	do
		#cd ${d}
		mkdir ${d}/hpccs
		mv ${d}/*.out ${d}/hpccs/
		mkdir ${d}/pqr
		mv ${d}/*.pqr ${d}/pqr/
		mkdir ${d}/gaussian
		mv ${d}/*.log ${d}/gaussian/
	done
}

#dir ${path}/model1_B3LYP
#dir ${path}/model4_B3LYP
#dir ${path}/model1_D3BJ
dir ${path}/model4_D3BJ
