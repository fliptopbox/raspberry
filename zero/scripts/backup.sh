#!/bin/bash

this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
Q=`dirname "${this}"`
. "$Q/config.sh"


# Backup timelapse images to remote server,
# excluding the images taken today & yesterday
# then delete the local files, to free drive space.
# Afterwards remove and empty folders.

#dst="bruce@lithium:Projects/github/raspberry/zero/images"
#src="../images/"

dst="$remoteRsyncServer:$remoteImageDest"
src="$relativeImages/"

# Keep two days of images
today=$(date -u +"%Y/%m/%d/") # UTC date
yesterday=$(date -u -d "yesterday" +"%Y/%m/%d/") # UTC date

echo $today
echo $yesterday
echo $dst
echo $src

# REMEMBER ... using rsync with the dry-run (n) flag and 
# --remove-source-files, together causes the rsync on MacOS to fail

rsync -ruvz \
    --remove-source-files \
    --exclude $yesterday \
    --exclude $today \
    $src \
    $dst

# clean up and empty folders (not an rsync option)
find $src -depth -type d -empty -delete


