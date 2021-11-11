#!/bin/bash

nice -n 9 bash ./someprocess.sh &
# bash ./someprocess.sh &
pid1=$!
disown $pid1
# cpulimit -p $pid1 -l 10

bash ./someprocess.sh &
pid2=$!
disown $pid2

bash ./someprocess.sh &
pid3=$!
disown $pid3

function print_usage {
	cpu=`top -b -n 1 | awk -v pid=$pid1 '{ if ($1==pid) print $9 }'`
	echo "CPU usage: $cpu %"
}

print_usage

kill $pid3

print_usage

kill $pid1
kill $pid2
