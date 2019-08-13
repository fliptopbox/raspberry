#!/bin/bash

delay=$1
count=20
log="../data/stats.txt"
images="../images/"
datetime=$(date -u +"%Y %m %d %H %M %S") # UTC date
cpu=$(ps -eo pcpu,cmd | sort -k 1 -r | head -20 | awk '{s+=$1} END {print s}')
disk=$(df | grep /dev/root)

# list of absolute image path
frames=$(find $images -regex ".*jpg$" -ls | awk '{print $11}' | sort | tail -${count})
# frames=$(find $images -regex ".*jpg$" | sort -V | tail -${count})
# frames=$(ls -ltRr $images | grep ".*jpg$" | tail -${count})

# Overwrite existing stats
echo "$datetime $delay" > $log

# Disk and CPU usage
echo "$disk $cpu" >> $log

# Current daytime status
echo $(sh day_time.sh) >> $log

# the list of last 20 images
# find images/ -regex ".*jpg$" -ls | awk '{print $11, $10}' | sort -V | tail -250
# find $images -regex ".*jpg$" | sort -V | tail -${count} >> $log
echo "$frames" >> $log

# EOF fullstop
echo "." >> $log
