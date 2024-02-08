#!/bin/bash
# Author: vis21
# Version: 1.1

# Colours to use for log file entries
red="\e[31m"
green="\e[32m"

# Directory to search in
mainDir=/data/example/

# Directory for the log files
logDir=/data/autocleanup-logs/

# Format of the log file
logFile="$(date +%Y-%m-%d)_log.txt"

# Check if the mainDir exists and if not return error
if [ ! -d "$mainDir" ]; then
  echo "Main directory does not exist: $mainDir"
  exit 1
fi

# Check if the logDir exists and if not return error
if [ ! -d "$logDir" ]; then
  echo "Log directory does not exist: $logDir"
  exit 1
fi

file_removal() {
    # This function looks for any files older than 30 days in mainDir and removes them
    now=${date +"%Y-%m-%d %H:%M:%S"}

    cd $mainDir
    files=$(find -type f -mtime +30)
    if [ -n "$files" ]; then
        echo -e "${green}${now}: Successfully removed the following files: ${files}" >> "$logDir/$logFile"
        rm $files
    else
        echo -e "${red}${now}: No files to be removed." >> "$logDir/$logFile"
    fi
}

log_cleanup() {
    # This function looks for any log files older than 30 days in logDir and removes them
    cd $logDir
    find -name "*_log.txt" -type f -mtime +30 -exec rm {} \;
}

file_removal
log_cleanup
