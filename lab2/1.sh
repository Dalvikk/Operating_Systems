#!/bin/bash

ps -ef | awk '{ if ($1 == "user") {print $2 ":" $11}}' > 1.txt
wc -l 1.txt | awk '{print $1}' | cat - 1.txt > 1.txt.tmp
mv 1.txt.tmp 1.txt

