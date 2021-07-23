#!/bin/bash

in_dir=${1}

find ${in_dir} -name "*.com" > list.txt

while read -r aline; do
  ./gau-sub.sh "${aline}"
done <list.txt