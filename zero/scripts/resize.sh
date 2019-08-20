#!/bin/bash

this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
Q=`dirname "${this}"`
. "$Q/config.sh"

# grab the last image in todays directory
# and generate a 1080p resized copy
# and put that in ../images/current/
# and delete the previous file(s)

mkdir -p $relativeCurrent

filename=$(echo $1 | awk -F'/' '{print $NF}')
resizedImage="$relativeCurrent/$filename"

# convert $1 -resize x1080 $resizedImage
raspistill -h 1080 -t 3 -ISO 300 -q 100 -o $resizedImage

# Delete older files AFTER we have a replacement
count=`ls $relativeCurrent/*.jpg | wc -l`
rm `ls -tr $relativeCurrent/*.jpg | head -$(( $count-1 ))` 

echo ">> $resizedImage"
