#!/bin/bash
oldname=$1
newname=$2
file=$oldname" "
file_new=$newname" "
cat record | grep "$file">temp_record1

sed -i "s/$oldname/$newname/g" record
cat record | grep "$file_new">temp_record_new

num=$(cat temp_record1 | wc -l)
for (( j=1; j<=$num; j=j+1))
do

	chunk=$(cat ~/data_2/temp_record1 | head -n $j | tail -n 1 | awk -F ' ' '{print $5}')

 	serve=$(cat ~/data_2/temp_record1 | head -n $j | tail -n 1 | awk -F ' ' '{print $4}')

	newname=$(cat ~/data_2/temp_record_new | head -n $j | tail -n 1 | awk -F ' ' '{print $5}')

	echo $newname
	echo $chunk
	ssh $serve mv $chunk $newname
done

rm temp_record1
rm temp_record_new

