#!./bin/bash

while true
do
	read line
	case $line in
		"+")
			kill -USR1 `cat .handler_pid`
			;;
		"*")
			kill -USR2 `cat .handler_pid`
			;;
		"TERM")
			kill -TERM `cat .handler_pid`
			exit 0
			;;
		*)
			:
			;;
	esac
done

