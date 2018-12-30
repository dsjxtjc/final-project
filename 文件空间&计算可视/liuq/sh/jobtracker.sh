#!/bin/bash
function map(){
	
	scp ~/data_2/map.sh $serve":"
	ssh $1 bash "map.sh" $2 &
		
}
function reduce(){
	
	bash reduce.sh

}
name=$1" "
shuf record -o record_temp
grep "$name" record_temp | sort -t ' ' -k 2,2 -u>temp_map
num=$(cat temp_map | wc -l)
echo $num

for (( i=1; i<=$num; i=i+1 ))
do

	fileloc=$(cat ~/data_2/temp_map | head -n $i | tail -n 1 | awk -F ' ' '{print $5}')

	serve=$(cat ~/data_2/temp_map | head -n $i | tail -n 1 | awk -F ' ' '{print $4}')

	map $serve $fileloc
done

wait
reduce
echo "over!"
rm record_temp

