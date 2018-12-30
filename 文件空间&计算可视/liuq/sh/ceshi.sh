#!/bin/bash
function randn(){
	
	touch ./temp
	rm ./temp
	touch ./temp
	a=$(sort temp | uniq | wc -l)
	
	while [ "$a" != "$1" ]
	do
	        c=$(($RANDOM%4+2))
	        echo $c >> temp
	        a=$(sort temp | uniq | wc -l)
	done
	sort temp | uniq>./temp2
}

for ((i=1; i<=10; i=i+1))
do
        echo $i
        randn $1
	
	echo "###########"
        
	for ((j=1; j<=$1; j=j+1))
        do
		id=$(cat ./temp2 | head -n $j | tail -n 1)
		serve="thumm0"$id":/data/dsjxtjc/2018211150/"
		echo $serve
        done
	
	echo "###########"
done

