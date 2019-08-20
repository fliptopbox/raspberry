#!/bin/bash

. ./config.sh

# grab the last image in todays directory
# and generate a 1080p resized copy
# and put that in ../images/current/
# and delete the previous file(s)

mkdir -p $relativeCurrent

filename=$(echo $1 | awk -F'/' '{print $NF}')
resizedImage="$relativeCurrent/$filename"

# it is MUCH quicker to take a new low-res photo 
# than to resize existing with imagemagick "convert"
## convert $1 -resize x1080 $resizedImage

raspistill \
    -w $resizeWidth \
    -h $resizeHeight \
    -t $cameraTimeout \
    -ISO $ISO \
    -q $jpgQuality \
    -o $resizedImage

# Delete older files AFTER we have a replacement
count=`ls $relativeCurrent/*.jpg | wc -l`
rm `ls -tr $relativeCurrent/*.jpg | head -$(( $count-1 ))` 

echo ">> $resizedImage"
