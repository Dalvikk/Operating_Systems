#!/bin/bash

TRASH=~/.trash
LOG=~/.trash.log
FILENAME=$1

cat "$LOG" | while read LINE; do
    FILEPATH=`echo "$LINE" | awk '{ print $1 }'`
    TRASH_PATH=`echo "$LINE" | awk '{ print $2 }'`

    if [[ `basename $FILEPATH` != $FILENAME ]]; then
        continue
    fi

    read -p "Restore $FILEPATH ? (y/n):" YN < /dev/tty
    case $YN in
        "y")
            RESTORE_DIR=`dirname $FILEPATH`
            NEW_FILENAME="$FILENAME"

            if ! [[ -d $RESTORE_DIR ]]; then
                echo "$RESTORE_DIR doesn't exists, restoring at $HOME..."
                RESTORE_DIR=$HOME
            fi

            while [[ -e "$RESTORE_DIR/$NEW_FILENAME" ]]
            do
                read -p "$NEW_FILENAME in $RESTORE_DIR path already exists. New name: " NEW_FILENAME < /dev/tty
            done

            ln "$TRASH_PATH" "$RESTORE_DIR/$NEW_FILENAME" &&
            rm "$TRASH_PATH" &&
            echo "$RESTORE_DIR/$NEW_FILENAME restored successfully"

            grep -v "$LINE" "$LOG" > .trash.log.tmp
            mv .trash.log.tmp "$LOG"

            exit 0
        ;;
        "n")
        ;;
        *)
            echo "Invalid answer: $YN"
            exit 1
        ;;
    esac
done
