#!/bin/bash

# CLEAR
> 4.txt.tmp

while read pid
do
	ppid=`awk '{if ($1=="PPid:") print $2}' /proc/$pid/status 2>/dev/null` || continue
	p=`awk '{if ($1=="se.sum_exec_runtime") print $3}' /proc/$pid/sched 2>/dev/null` || continue
	q=`awk '{if ($1=="nr_switches") print $3}' /proc/$pid/sched 2>/dev/null` || continue
	art=`echo "$p/$q" | bc -l | awk '{printf "%f", $0}'`
	echo "$pid $ppid $art" >> 4.txt.tmp
done <<< $(ps -ef | awk '{print $2}')

TEMPLATE="ProcessID=%s : Parent_ProcessID=%s : Average_Running_Time=%s\n"

sort -n -k 2 < 4.txt.tmp | awk -v str="$TEMPLATE" '{printf str, $1, $2, $3}' > 4.txt
rm 4.txt.tmp

