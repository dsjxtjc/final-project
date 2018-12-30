#!/bin/bash

function map(){

	scp ~/data_2/map_tol.sh $serve":"
	ssh $1 bash "map_tol.sh" $2 $1 &

}
function correct(){

	logloc="errorlog"
	ssh $1 cat $logloc | while read line
	do
		errorloc=$(echo $line | awk ' ' '{print $1}')
		errorserve=$(echo $line | awk ' ' '{print $2}')
        	
	        normal=$(cat record | grep "$errorloc" | grep -v "$errorserve" | head -n 1)
        	normalserve=$(echo normal | awk ' ' 'print($4)')
	        mormalloc=$(echo normal | wak ' ' 'print($5)')
	        map $normalserve $normalloc
	done
}

for (( i=2; i<=5; i=i+1))
do

	corrcet "thumm0"$i

done
