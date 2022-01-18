#!/bin/bash

HOMEDIR="/home/user"
SOURCEDIR="/home/user/source"
REPORT="/home/user/backup-report"

LastBackupTime=`ls "$HOMEDIR" | grep -E "^Backup-" | sed 's/Backup-//' | sort -n | tail -n 1`
LastBackupTimeSec=`date -d "$LastBackupTime" +"%s"`

CurrentTime=`date +"%Y-%m-%d"`
CurrentTimeSec=`date -d "$CurrentTime" +"%s"`

Diff_days=`echo "($CurrentTimeSec - $LastBackupTimeSec) / 60 / 60 / 24" | bc`

if [[ -z $LastBackupTime || $Diff_days -gt 7 ]]; then
    CurrentBackupDir="$HOMEDIR/Backup-$CurrentTime"
    mkdir "$CurrentBackupDir"

    echo "New backup: $CurrentTime" >> $REPORT
    for file in `ls $SOURCEDIR`; do
        cp "$SOURCEDIR/$file" "$CurrentBackupDir"
        echo "$file" >> REPORT
    done
    echo "" >> $REPORT
else
    LastBackupDir="$HOMEDIR/Backup-$LastBackupTime"
    echo "Update backup: $LastBackupDir at $CurrentTime" >> $REPORT

    new_changes=""
    update_changes=""

    for file in `ls $SOURCEDIR`; do
        if ! [[ -e "$LastBackupDir/$file" ]]; then
            cp "$SOURCEDIR/$file" "$LastBackupDir"
            new_changes=`echo -e "$new_changes\n$file"`
        else
                sourceSize=`wc -c "$SOURCEDIR/$file" | awk '{print $1}'`
                backupSize=`wc -c "$LastBackupDir/$file" | awk '{print $1}'`
                if [[ $sourceSize != $backupSize ]]; then
                    mv "$LastBackupDir/$file" "$LastBackupDir/$file.$CurrentTime"
                    cp "$SOURCEDIR/$file" "$LastBackupDir"
                    update_changes=`echo -e "$update_changes\n$file $file.$CurrentTime"`
                fi
        fi
    done

    if [[ "$new_changes" != "" ]]; then
        echo $new_changes >> $REPORT
    fi
    if [[ "$update_changes" != "" ]]; then
        echo $update_changes >> $REPORT
    fi
    echo "" >> $REPORT
fi
