#!/bin/bash
# Simple script to remove any files older than 30 days and record their names in a log file
# and if no files can be found then log an error
# Author: vis21
# Version: 1.0

# Colours to use for log file entries
RED="\e[31m"
GREEN="\e[32m"

# Directory to search in
export MAINDIR=/data/example/

# Directory for the log files
export LOGDIR=/data/autocleanup-logs/

# Format of the log file
export LOGFILE="$(date +%Y-%m-%d)_log.txt"

# Check if the MAINDIR exists and if not return error
if [ ! -d "$MAINDIR" ]; then
  echo "Main directory does not exist: $MAINDIR"
  exit 1
fi

# Check if the LOGDIR exists and if not return error
if [ ! -d "$LOGDIR" ]; then
  echo "Log directory does not exist: $LOGDIR"
  exit 1
fi

file_removal() {
    # This function looks for any files older than 30 days in MAINDIR and removes them
    cd $MAINDIR
    FILES=$(find -type f -mtime +30)
    if [ -n "$FILES" ]; then
        echo -e "${GREEN}${NOW}: Successfully removed the following files: ${FILES}" >> "$LOGDIR/$LOGFILE"
        rm $FILES
    else
        echo -e "${RED}${NOW}: No files to be removed." >> "$LOGDIR/$LOGFILE"
    fi
}

log_cleanup() {
    # This function looks for any log files older than 30 days in LOGDIR and removes them
    cd $LOGDIR
    find -name "*_log.txt" -type f -mtime +30 -exec rm {} \;
}

file_removal
log_cleanup
