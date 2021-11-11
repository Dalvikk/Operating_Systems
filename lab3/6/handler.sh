#!/bin/bash

echo $$ > .handler_pid
num=1
mode="usr1"

function print_result {
	echo "Result: $num"
}

function usr1 {
	mode="usr1"
}

function usr2 {
	mode="usr2"
}

function term {
	mode="term"
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'term' TERM

while true
do
	case $mode in
		"usr1")
				num=$(( num + 2 ))
				print_result
				;;
		"usr2")
				num=$(( num * 2 ))
				print_result
				;;
		"term")
				echo "All done."
				print_result
				exit 0
				;;
	esac
	sleep 1
done

