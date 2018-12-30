#!/bin/bash

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

sort temp | uniq | cat














