#!/bin/bash

PID=$$
ps -ef --sort=start_time | awk -v ID="$PID" '{ if($2!=ID && $3!=ID) print $2}' | tail -n 1

