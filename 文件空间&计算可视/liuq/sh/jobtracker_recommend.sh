#!/bin/bash
function map(){

        scp ~/data_2/recommend_map.py $1":"
        ssh $1 python recommend_map.py 3 100 $2 $2".txt" &


}
function reduce(){

        python recommend_reduce.py
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
	scp goal.txt $serve":/data/dsjxtjc/2018211150"

	scp merge.sh $serve":/data/dsjxtjc/2018211150"

	ssh $serve bash "/data/dsjxtjc/2018211150/merge.sh" "/data/dsjxtjc/2018211150/goal.txt" $fileloc
	#ssh $serve cat /data/dsjxtjc/2018211150/goal.txt >> $fileloc
        map $serve $fileloc
done
wait
echo "DONE!"
