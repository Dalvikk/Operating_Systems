#!/bin/bash


function search {
	filename=$1
	# CLEAR
	> $filename
	while read line
	do
		pid=`echo $line | awk '{print $2}'`
		command=`echo $line | awk '{print $8}'`
		bytes=`awk '{if ($1=="read_bytes:") print $2}' /proc/$pid/io 2>/dev/null` || continue
		echo $pid $command $bytes >> $filename
	done <<< $(ps -aef)
}

search 7.txt.tmp1
sleep 60
search 7.txt.tmp2

# CLEAR
> 7.txt

while read line
do
	pid=`echo $line | awk '{print $1}'`
	command=`echo $line | awk '{print $2}'`
	bytes_end=`echo $line | awk '{print $3}'`
	bytes_start=`grep "$pid" 7.txt.tmp1 | awk '{print $3}'`
	if (bytes_start==""); then
		bytes_start="0"
	fi
	diff=`echo $bytes_end - $bytes_start | bc -l`
	echo $pid $command $diff >> 7.txt
done < 7.txt.tmp2

cat 7.txt | sort -n -r -k 3 | head -n 3 | awk '{print $1 " : " $2 " : " $3 " bytes "}'
rm -f 7.txt.tmp1
rm -f 7.txt.tmp2
rm -f 7.txt
