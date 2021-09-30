#!/bin/bash

value=$(printf '%s\n%s\n%s\n' $1 $2 $3 | sort -n | tail -n 1)
if [[ $value == "" ]]; then value=0; fi
echo $value

