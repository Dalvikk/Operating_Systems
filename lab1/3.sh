#!/bin/bash
echo "Write option:"
echo "1. Nano"
echo "2. Vim"
echo "3. Links"
echo "4. Exit"

read command
case $command in
	1)
	nano
	;;

	2)
	vi
	;;

	3)
	links
	;;

	4)
	exit
	;;
esac

