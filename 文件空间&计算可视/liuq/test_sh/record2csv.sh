#!/bin/bash

# 将record一次性按行读入
# 每个空格占一行
# mapfile -t records < record
# for e in ${records[*]}
# do
# 	echo $e
# done

record_name="${1}"

echo Saving "$record_name" to "$record_name".csv

# head of csv
printf '%s\n' filename blockname datanode_realpath datanode realpath types_permissions link ownership group_ownership filesize month day time verbose | paste -sd ',' > $record_name.csv

# for each line split items with "," output to csv
cat $record_name | while read line; do 
	printf '%s\n' $line | paste -sd ',' >> $record_name.csv
	# printf $line | paste -sd ','
done

echo Success!