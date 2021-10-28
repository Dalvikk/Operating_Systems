#!/bin/bash

input="./4.txt"
TEMPLATE3="Parent_ProcessID="
TEMPLATE5="Average_Running_Time="

bash ./4.sh
# CLEAR
> 5.txt

last_ppid=-1
count=0
sum=0


function append {
	m=`echo "$sum/$count" | bc -l`
	printf 'Average_Running_Children_of_ParentID=%s is %f\n' $last_ppid $m >> 5.txt
}

while IFS= read -r line
do
	COL3=`echo $line | awk '{ print $3 }'`
	COL5=`echo $line | awk '{ print $5 }'`
	current_ppid=${COL3/#$TEMPLATE3}
	current_art=${COL5/#$TEMPLATE5}
	if [[ $last_ppid != "-1" && $last_ppid != $current_ppid ]]; then
		append
		last_ppid=$current_ppid
		count=1
		sum=$current_art
	else
		last_ppid=$current_ppid
		count=$((count+1))
		sum=`echo "$sum + $current_art" | bc -l`
	fi
	echo $line >> 5.txt
done < "$input"
append

