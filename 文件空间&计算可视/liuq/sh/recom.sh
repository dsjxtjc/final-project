#!/bin/bash

goal=$1
awk -F ',' '{if($1=="'$goal'"){print}}' ratings.csv>goal.txt
awk -F ',' '{if($1!="'$goal'"){print}}' ratings.csv>sample

prefix="sample_"
filename=$prefix"*"
split -l 5000060 sample -d -a 2 $prefix

join=$(ls -h $filename)
OLD_IFS="$IFS"
IFS=" "
arr=($join)
IFS="$OLD_IFS"

id=2
for s in ${arr[@]}
do
	cat goal.txt>>$s
	echo $s
	serve="thumm0"$id
	loc="thumm0"$id":"$s
	scp recommendation.py $serve":"	
	scp $s $loc
	ssh  $serve python recommendation.py 3 $goal $s &
	id=$((id+1))
done
rm sample*
