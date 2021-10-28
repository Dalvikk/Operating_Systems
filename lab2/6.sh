#!/bin/bash

max_mem=-1
max_mem_pid=-1

while read pid
do
	VmRSS=`awk '{if ($1=="VmRSS:") print $2}' /proc/$pid/status 2>/dev/null` || continue
	if [[ $VmRSS -gt $max_mem ]]; then
		max_mem=$VmRSS
		max_mem_pid=$pid
	fi
done <<< $(ps -ef | awk '{print $2}')

echo "Using /proc/PID/status: PID=$max_mem_pid, result=$max_mem kB"
top -bo RES | head -n 8 | tail -n 1 | awk '{ print "Using top: PID=" $1 ", result=" $6 " KiB" }'
