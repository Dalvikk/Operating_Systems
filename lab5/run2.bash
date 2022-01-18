#!/bin/bash

counter=1
k=$1
n=$2

while [[ $counter -le $k ]]
do
    ./newmem.bash $n &
    sleep 1
    counter=$(($counter+1))
done
