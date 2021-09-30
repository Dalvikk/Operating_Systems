#!/bin/bash
string=""
read current
while [[ $current != "q" ]];
do
	string+=$current
	read current
done
echo $string

