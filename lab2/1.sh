#!/bin/bash

ps a --no-header -u user | awk '{print $1 ":" $5}' > 1.txt
# Count line numbers and push front
wc -l 1.txt | awk '{print $1}' | cat - 1.txt > 1.txt.tmp
mv 1.txt.tmp 1.txt

