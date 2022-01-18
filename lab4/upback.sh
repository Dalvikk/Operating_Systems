#!/bin/bash

HOMEDIR="/home/user"
RESTORE="/home/user/restore"

LastBackup=`ls "$HOMEDIR" | grep -E "^Backup-" | sort -n | tail -n 1`
LastBackupDir="$HOMEDIR/$LastBackup"

if [[ -e $RESTORE ]]; then
    rm -rf $RESTORE
fi

mkdir $RESTORE

for file in `find "$LastBackupDir" -type f | grep -Ev ".\.[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}$"`; do
    cp "$file" "$RESTORE"
done
