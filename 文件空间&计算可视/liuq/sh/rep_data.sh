#!/bin/bash
for (( i=1; i<=$1; i++))
do
	cp creatdata.txt ./temp_creatdata	
	cat ./temp_creatdata >> creatdata.txt

done
rm ./temp_creatdata

