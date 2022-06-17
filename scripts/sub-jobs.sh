#!/bin/bash

#input directory variable
in_dir=${1}

#sets the path the script is initiated
exec_path=/aerosol/users/nicole/CCS

#makes a list of all the .com files in the directory
find ${in_dir} -name "*.com" > list.txt

while read -r aline; do
    #gets file path of each file in the list
    file_path=`dirname ${aline}`
    #gets the name of each file in the list
    file_name=`basename ${aline}`

    #enters the directory the file is in
    cd ${exec_path}/${file_path}

    #runs the job submission script
    ${exec_path}/gau-sub.sh "${file_name}"
done <list.txt