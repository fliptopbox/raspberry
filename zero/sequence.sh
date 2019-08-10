#!/bin/bash

LOG="./stats.txt"
IMAGES="./images/"

## 2019 08 09 18 34 08 3456
DATE=$(date +"%Y %m %d %H %M %S %4N")
TODAY=$(date +"%Y/%m/%d/")
DEST="$IMAGES$TODAY"
PREFIX="seq"
FILENAME="$PREFIX%08d.jpg"


# Create the parent folders
echo "$IMAGESTODAY"
mkdir -p  "$IMAGESTODAY"

# Overwrite existing stats
echo "$DATE" > $LOG

df | grep /dev/root >> $LOG
echo "" >> $LOG

du $IMAGES >> $LOG
echo "" >> $LOG

find $IMAGES -regex ".*$PREFIX.*jpg$" >> $LOG
echo "." >> $LOG

raspistill -v -t 30000 -tl 3000 -o $DEST$FILENAME

# ls -R | sort -V | grep seq[0-9].*jpg | tail -1 | awk '\d+'
