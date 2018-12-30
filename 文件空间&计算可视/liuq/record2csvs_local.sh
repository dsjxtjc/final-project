#！/bin/bash

fetch() {
	# where record located
	record_loc="/home/dsjxtjc/2018211150/data_2/record"
	# (scp 2018211150@szcluster.mmlab.top:$record_loc . )
	wait
	record_name="record" # local

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
}

fetch

# 主循环
play() {
	echo -e -n "\n| Please input your command: " 
	read -r  comm
	
	comm=$(echo $comm | tr [a-z] [A-Z] ) 
	expression=($(echo "$comm" | tr ' ' '\n')) 
	
	while [ ${expression[0]} != "Q" ] && [ ${expression[0]} != "QUIT" ]
	do 
		fetch
		echo `date +"%Y-%m-%d %H:%M:%S"`
		sleep 5
		echo -e -n "\n| Please input your command: " 
		read -r  comm
		comm=$(echo $comm | tr [a-z] [A-Z] ); expression=($(echo "$comm" | tr ' ' '\n')) 
	done
	printf "\n| Bye!\n"
}

# play