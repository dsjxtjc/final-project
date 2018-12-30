#!/bin/bash
fileloc=$1
opfile="/data/dsjxtjc/2018211150/itmresult"

mean=$(awk '{sum+=$1;account+=1} END {print (sum/account)}' $fileloc)
var=$(awk '{sum+=$1*$1;account+=1} END {print (sum/account)}' $fileloc)
size=$(cat $fileloc | wc -l)

echo -n $size >> $opfile
echo -n " " >> $opfile
echo -n $mean >> $opfile
echo -n " " >> $opfile
echo $var >> $opfile


