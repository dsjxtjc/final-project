#!/bin/bash

file=$1" "
grep "$file" record |awk -F ' ' '{print $2,$3}'
line=$(grep "$file" record |awk -F ' ' '{print $2,$3}' | wc -l)
echo $line
if [ "$line" == "0" ];then
	echo "No exist!"
fi
