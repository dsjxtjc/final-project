#!/bin/bash
aimloc="thumm01:data_2/itmresult"
rm itmresult
scloc="thumm02:/data/dsjxtjc/2018211150/itmresult"
scp $scloc $aimloc
for (( i=3; i<=5; i=i+1))
do
	echo "########"
	cp itmresult temp
	scp "thumm0"$i":/data/dsjxtjc/2018211150/itmresult" $aimloc
	
	cat temp >> itmresult

done
size=$(cat itmresult | awk -F ' ' '{size+=$1} END {print size}')
total=$(cat itmresult | awk -F ' ' '{a=$1*$2;sum+=a} END {printf"%.f",sum}')
total_square=$(cat itmresult | awk -F ' ' '{a=$1*$3;sum+=a} END {printf"%.f",sum}')
mean=$((total/size))
var=$((total_square/size-mean*mean))

echo "mean:"$mean
echo "var:"$var
rm temp

