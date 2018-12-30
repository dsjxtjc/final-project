#!/bin/bash
fileloc=$1
serve=$2
logloc="errorlog"

opfile="/data/dsjxtjc/2018211150/itmresult"
mean=$(awk '{sum+=$1;account+=1} END {print (sum/account)}' $fileloc)
if [ "$?" != "0" ];then
	echo -ne "$fileloc" >> $logloc
	echo -ne " " >> $logloc
	echo "$serve" >> $logloc
fi
var=$(awk '{sum+=$1*$1;account+=1} END {print (sum/account)}' $fileloc)
size=$(cat $fileloc | wc -l)

echo -n $size >> $opfile
echo -n " " >> $opfile
echo -n $mean >> $opfile
echo -n " " >> $opfile
echo $var >> $opfile


