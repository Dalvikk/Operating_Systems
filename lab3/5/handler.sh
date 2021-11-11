#!/bin/bash

num=1
mode="+"

function print_result {
	echo "Result: $num"
}

(tail -f pipe) |
while true; do
	read line;
	case $line in
		"+")
				mode="+"
				;;
		"*")
				mode="*"
				;;
		[0-9]*)
				if [[ $mode == "+" ]]; then
					num=$(( $num + $line ))
				else
					num=$(( $num * $line ))
				fi
				print_result
				;;
		"QUIT")
				echo "All done."
				print_result
				kill $!
				kill `cat .generator_pid`
				exit 0
				;;
		*)
				echo "Incorrect input: $line."
				print_result
				kill $!
				kill `cat .generator_pid`
				exit 1
				;;
		esac
done
