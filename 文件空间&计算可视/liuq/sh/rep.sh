#!/bin/bash

file=$1" "
echo $file

rep=$2
shuf record -o record_temp_rep
grep "$file" record_temp_rep | sort -t ' ' -k 2,2 -u>temp_rep
total=$(grep "$file" record | wc -l)

single=$(grep "$file" record | sort -t ' ' -k 2,2 -u | wc -l)

rep_prim=$(($total/$single))
echo $rep_prim

oper=$((rep_prim-rep))
echo $oper

for (( i=1; i<=$oper; i=i+1 ))
do

	for (( j=1; j<=single; j=j+1 ))
        do

	        chunk=$(cat ~/data_2/temp_rep | head -n $j | tail -n 1 | awk -F ' ' '{print $5}')

                serve=$(cat ~/data_2/temp_rep | head -n $j | tail -n 1 | awk -F ' ' '{print $4}')
                ssh $serve rm $chunk
                
        done
	grep -v -f temp_rep record>temp_rep2
	mv temp_rep2 record
        grep "$file" record | sort -t ' ' -k 2,2 -u>temp_rep
done
rm temp_rep

