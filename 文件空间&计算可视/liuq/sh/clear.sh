#!/bin/bash
for ((i=2 ;i<=5 ;i=i+1))
do

	a="thumm0"$i
	b="/data/dsjxtjc/2018211150/*"
	ssh $a rm $b

done
cat /dev/null>record
