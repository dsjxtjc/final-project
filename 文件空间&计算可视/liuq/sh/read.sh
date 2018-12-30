#!/bin/bash

name=$1" "
loc="thumm01:"$2
shuf record -o temp_record_read
grep "$name" temp_record_read | sort -t ' ' -k 2,2 -u>temp_record

total=$(grep "$name" record | wc -l)
single=$(cat temp_record | wc -l)
rep_prim=$(($total/$single))

#cat temp_record
#ls -h
num=$(cat temp_record | wc -l)
echo $num
temp_loc="thumm01:~/data_2/temp_loc"

for (( i=1; i<=$num; i=i+1 ))
do
	
	chunk=$(cat ~/data_2/temp_record | head -n $i | tail -n 1 | awk -F ' ' '{print $2}')

	echo $chunk
	
	serve=$(cat ~/data_2/temp_record | head -n $i | tail -n 1 | awk -F ' ' '{print $3}')
	
	scp $serve $temp_loc
	
	if [ "$?" == "1" ]; then
	
		for (( j=1; j<=$rep_prim; j=j+1 ))
	        do
        	        serve_rep=$(grep "$chunk" ~/data_2/record | head -n $j | tail -n 1 | awk -F ' ' '{print $3}')
			echo "#########"
			echo $serve_rep
			echo "#########"
                	scp $serve_rep $temp_loc
        	        
			if [ "$?" == "0" ]; then
				cat temp_loc2 | while read line
				do
					scp $temp_loc"/"$chunk $line
                	        done
				cat /dev/null>temp_loc2
				break
	                else
				echo $serve_rep >> temp_loc2
	                        continue
	                fi
        	done
	fi
done

cat ~/data_2/temp_loc/* >> ~/data_2/temp_loc/$1
cp ~/data_2/temp_loc/$1 $2
#rm temp_loc2
rm ~/data_2/temp_loc/*
rm temp_record
rm temp_record_read
