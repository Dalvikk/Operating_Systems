#!/bin/bash

TRASH=~/.trash
LOG=~/.trash.log
FILENAME=$1
FILE=`pwd`/$FILENAME

if [[ ! -f $FILE ]]; then
	echo "Error when opening file $FILE"
	exit 1
fi

if [[ ! -d $TRASH ]]; then
	mkdir $TRASH
fi

LINK=`ls $TRASH | sort | tail -n 1`
if [[ -z  "$LINK" ]]; then
    LINK=0
fi
LINK=$(($LINK+1))

ln $FILE $TRASH/$LINK &&
rm -rf $FILE &&
echo "$FILE $TRASH/$LINK" >> $LOG &&
echo "File deleted sucessful and data was logged"
