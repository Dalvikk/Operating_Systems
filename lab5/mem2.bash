#!/bin/bash

REPORT="report2.log"

array=()
counter=0

echo "" > $REPORT

while true
do
	array+=(1 2 3 4 5 6 7 8 9 10)
	counter=$(($counter+1))
	if [[ $counter -eq 100000 ]]
	then
		counter=0
		echo "${#array[@]}" >> $REPORT
	fi
done
