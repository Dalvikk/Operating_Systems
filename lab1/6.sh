#!/bin/bash
LOGPATH="/var/log/anaconda/X.log"
OUTPUT="full.log"

awk '{if ($3 == "(WW)") { $3="Warning:"; print }}' $LOGPATH > $OUTPUT
awk '{if ($3 == "(II)") { $3="Information:"; print }}' $LOGPATH >> $OUTPUT

cat $OUTPUT

