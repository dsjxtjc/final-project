#!/bin/bash
file="^"$1" "
cat record | grep -v "$file">temp_delete_remainder
grep "$file" record>temp_delete
num=$(cat temp_delete | wc -l)
echo $num

for (( i=1; i<=$num; i=i+1))
do

	chunk=$(cat ~/data_2/temp_delete | head -n $i | tail -n 1 | awk -F ' ' '{print $5}')

	serve=$(cat ~/data_2/temp_delete | head -n $i | tail -n 1 | awk -F ' ' '{print $4}')

	ssh $serve rm $chunk

done

rm record
rm temp_delete
mv temp_delete_remainder record
