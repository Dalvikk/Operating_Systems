#!/bin/bash

echo $$ > .generator_pid

while true; do
	read line
	echo "$line" > pipe
done
