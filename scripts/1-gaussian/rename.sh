#!/bin/bash

for f in ./*.xyz;
do
	name=`basename ${f} .xyz`
	name=`echo $name | cut -d "_" -f2`
	name=`echo $name | cut -d "-" -f3`
	mv $f $name.xyz
done
