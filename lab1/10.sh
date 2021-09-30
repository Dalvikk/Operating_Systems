#!/bin/bash

man bash | tr -s '[[:punct:][:space:]]' '\n' | \
awk '{ if(length($0) >= 4) print }' | sort -r | uniq -c | sort -n -r | head -n 3

