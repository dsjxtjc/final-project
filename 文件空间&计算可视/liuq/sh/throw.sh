#!/bin/baoh
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
record="/home/dsjxtjc/2018211150/data_2/record"

name=$1

file_oper=$(echo ${name##*/})
prefix=$file_oper"_"
#split -b $2 $1 -d -a 2 $prefix
split -b $2 $1 -d -a 2 $prefix

filename=$prefix"*"
num=$(ls -l $filename | wc -l)
echo $num

join=$(ls -h $filename)
OLD_IFS="$IFS"
IFS=" "
arr=($join)
IFS="$OLD_IFS"

for s in ${arr[@]}
do
	randn $3

	for ((j=1; j<=$3; j=j+1))
        do
                id=$(cat ./temp2 | head -n $j | tail -n 1)
                serve="thumm0"$id":/data/dsjxtjc/2018211150/"$s
                scp $s $serve
		
		echo -n $file_oper >> $record
		echo -ne " " >> $record
		echo -ne $s >> $record
		echo -ne " " >> $record
		echo -ne $serve >> $record
		echo -ne " " >> $record
		echo -ne "thumm0"$id >> $record
		echo -ne " " >> $record
		echo -ne "/data/dsjxtjc/2018211150/"$s >> $record
		echo -ne " " >> $record
		echo $(ls -l $s) >> $record
        done
done
rm $filename 
