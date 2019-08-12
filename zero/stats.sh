#!/bin/bash

log="./stats.txt"
images="./images/"
delay=$1
datetime=$(date +"%Y %m %d %H %M %S")

# ls -R | sort -V | grep seq[0-9].*jpg | tail -1 | awk '\d+'
# Overwrite existing stats
echo "$datetime $delay" > $log

df | grep /dev/root >> $log
echo "" >> $log

find $images -regex ".*jpg$" >> $log
echo "." >> $log

