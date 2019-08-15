#!/bin/bash

this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
Q=`dirname "${this}"`
. "$Q/config.sh"

# grab the last image in todays directory
# and generate a 1080p resized copy
# and put that in ../images/current/
# and delete the previous file(s)


filename=$(echo $1 | awk -F'/' '{print $NF}')
resizedImage="$relativeCurrent/$filename"

rm $relativeCurrent/*
convert $1 -resize x1080 $resizedImage

echo ">> $resizedImage"
