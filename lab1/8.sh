#!/bin/bash

FILEPATH="/etc/passwd"

awk -F ":" '{ print $3, $1 }' $FILEPATH | sort -n
