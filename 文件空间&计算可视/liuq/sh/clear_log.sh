#!/bin/bash
for (( i=2; i<=5; i++))
do

	ssh "thumm0"$i rm errorlog
	ssh "thumm0"$i touch errorlog

done
