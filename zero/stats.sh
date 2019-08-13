#!/bin/bash

log="./stats.txt"
images="./images/"
delay=$1
datetime=$(date -u +"%Y %m %d %H %M %S") # UTC date

# ls -R | sort -V | grep seq[0-9].*jpg | tail -1 | awk '\d+'
# Overwrite existing stats
echo "$datetime $delay" > $log

# Disk usage
df | grep /dev/root >> $log

# Current daytime status
echo $(sh day_time.sh) >> $log

# the list of all images
find $images -regex ".*jpg$" | sort -V >> $log

# EOF fullstop
echo "." >> $log
