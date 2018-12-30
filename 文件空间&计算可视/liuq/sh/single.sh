#!/bin/bash
size=$(cat creatdata.txt | wc -l)
total=$(cat creatdata.txt | awk -F ' ' '{sum+=$1} END {printf"%.f",sum}')
total_square=$(cat creatdata.txt | awk -F ' ' '{sum+=$1*$1} END {printf"%.f",sum}')
#echo $total
#echo $size
#echo $total_square
mean=$((total/size))
var=$((total_square/size-mean*mean))
echo "mean:"$mean
echo "var:"$var

