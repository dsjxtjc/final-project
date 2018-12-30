#！/bin/bash
record_name=$1

# record to file.csv
printf "%s\n" id name | paste -sd ',' > datanode.csv
awk '{print $4}' $record_name | sort -u | nl -n rz | tr -s '\t' ','  >> datanode.csv

# record to datanode.csv
printf "%s\n" id name | paste -sd ',' > file.csv
awk '{print $1}' record | sort -u | nl -n rz | tr -s '\t' ','  >> file.csv

# record to block.csv
counter=0
printf '%s\n' id	file_id	name	datanode_realpath	datanode_id	realpath	types_permissions	link	ownership	group_ownership	size	month	day	time	verbose | paste -sd ',' > block.csv
cat $record_name | while read line; do 
	(( counter=${counter}+1 ))  
	row="$(echo ${counter} $line | tr -s ' ' ',')" # 空格替换为,
	echo $row >> block.csv
done