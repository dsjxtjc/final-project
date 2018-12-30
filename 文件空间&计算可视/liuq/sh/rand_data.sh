#!/bin/bash
 random(){
        min=$1
        max=$2
        time=$(date +%s%N)
        num=$[ $max-$min+1]
        out=$[ $time%$num+$min]
        echo $out
}
i=0
while [ "$i" != "6000000" ]
do

	i=$(($i+1))
	random $1 $2>>./creatdata.txt 
done

