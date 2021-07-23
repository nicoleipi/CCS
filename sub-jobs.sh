#!/bin/bash

in_dir=${1}

find ${in_dir} -name "*.com" > list.txt

execpath=/aerosol/users/nicole/ccs-files

while read -r aline; do
  filepath=`dirname ${aline}`
  filename=`basename ${aline}`

  cd ${execpath}/${filepath}
  echo ${execpath}/gau-sub.sh "${filename}"
done <list.txt