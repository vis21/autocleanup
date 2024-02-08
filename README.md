# autocleanup
## Description
Simple script written in Bash to remove any files older than 30 days and record their names in a log file, and if no files can be found, then log an error. This script was created for a specific work purpose, which is why directories were already created and there's no need for an if statement to create directories if they didn't exist.

However, if you would like the script to create the directories that don't exist for you, you can easily change the if statements accordingly. For example, for main directory, the script uses:
```
if [ ! -d "$mainDir" ]; then
  echo "Main directory does not exist: $mainDir"
  exit 1
fi
```
Replace the above with the below:
```
if [! -d "$mainDir" ]; then
    mkdir -p "$mainDir"
fi
```

This script was tested and deployed to a production environment running on Ubuntu 22.04 and worked without any issues.
