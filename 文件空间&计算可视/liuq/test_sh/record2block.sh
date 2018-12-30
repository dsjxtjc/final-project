#！/bin/bash

record_name="record"
counter=0
printf '%s\n' id	file_id	name	datanode_realpath	datanode_id	realpath	types_permissions	link	ownership	group_ownership	size	month	day	time	verbose | paste -sd ',' > block.csv
cat $record_name | while read line; do 
	(( counter=${counter}+1 ))  
	row="$(echo ${counter} $line | tr -s ' ' ',')" # 空格替换为,
	echo $row >> block.csv
done



# file_id=0
# namenode_id=0
# IFS=',' read -r -a arr <<< "`awk -F ',' 'NR!=1{print $2}' datanode.csv`"  # 由于建立时根据datanode的 名称给id,所以这里简化处理，读取第二列即可

# for i in ${!arr[@]};do
# 	echo compare ${arr[$i]}
# 	# datanode名称一致
# 	if [ "${arr[$i]}" == "${ro[3]}" ];then
# 		echo miao $i
# 	else
# 		echo not found
# 	fi
# done

# cat $record_name | while read line; do 
	# (( counter=${counter}+1 ))  
	# echo "Record ${counter}"
	# #echo $line | tr -s ' ' ','  # 添加逗号分隔
	# # echo $line | tr -s ' ' ',' #| IFS=',' read -r -a array 
	# row="$(echo ${counter} $line | tr -s ' ' ',')" # 空格替换为,
	# echo $row
	# #echo "$temp" # 存为一个字符串
	# # IFS=',' read -r -a ro <<< "$row"
	# # echo "datanode" ${ro[3]}
	
	# #mapfile -t targets < targets.mdfs

	# # echo ${#array}
	# # for e in ${array[@]};do echo $e;done
	# # echo ""
	# # echo ""
# done