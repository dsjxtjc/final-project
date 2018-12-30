#!/bin/bash
function map(){
	
	scp ~/data_2/map_tol.sh $serve":"
	ssh $1 bash "map_tol.sh" $2 $1 &
		
}
function reduce(){
	
	bash reduce_tol.sh

}

function correct(){
	echo "**************"
        logloc="errorlog"
	scp $1":"$logloc ./temp_loc_correct
	len=$(cat temp_loc_correct | wc -l)
	echo $len
	if [ "$len"!="0" ];then
	for (( i=1; i<=$len; i=i+1 ))
        do
		
		errorloc=$(cat temp_loc_correct | head -n $i | tail -n 1 | awk -F ' ' '{print $1}')
		echo "errorloc",$errorloc
                errorserve=$(cat temp_loc_correct | head -n $i | tail -n 1 | awk -F ' ' '{print $2}')
		echo "errorserve:",$errorserve
                normalserve=$(cat record | grep "$errorloc" | grep -v "$errorserve" | head -n 1 | awk -F ' ' '{print $4}')
		normalloc=$(cat record | grep "$errorloc" | grep -v "$errorserve" | head -n 1 | awk -F  ' ' '{print $5}')

                map $normalserve $normalloc
        done
	fi
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
#**********错误处理************
for (( i=2; i<=5; i=i+1))
do

        correct "thumm0"$i

done
#******************************
wait
reduce
echo "over!"
rm record_temp

