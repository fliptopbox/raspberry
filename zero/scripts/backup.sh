#!/bin/bash

this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
Q=`dirname "${this}"`
. "$Q/config.sh"


# Backup timelapse images to remote server,
# exclude current folder, and images taken today & yesterday
# then delete the local files, to free drive space.
# Afterwards remove and empty folders.

if [ -z ${rsyncLogin+x} ]; then
    echo "log=backup;exit;require remote login ($rsyncLogin)"
    exit
fi

# prevent multiple instances
today=$(date -u +"%Y%m%d")
if [ $today -eq $rsyncBackup ]; then
    echo "log=backup;exit;already completed ($today:$rsyncBackup)"
    exit
fi

# update config with today's date
sed -i  "s/rsyncBackup=.*/rsyncBackup=${today}/g" config.sh



# Keep two days of images (ie today, and yesterday)
today=$(date -u +"%Y/%m/%d") # UTC date
yesterday=$(date -u -d "yesterday" +"%Y/%m/%d") # UTC date


dst="$rsyncLogin:$rsyncDest"
echo "log=backup;ok;dst=$dst"

src="$rsyncSource/"
echo "log=backup;src=$src"

# REMEMBER ... using rsync with the dry-run (n) flag and 
# --remove-source-files, together causes the rsync on MacOS to fail

[ "$bracket" -gt 0 ] && activeDest="bracket" || activeDest="still"

exclToday="$activeDest/$today"
exclYesterday="$activeDest/$yesterday"
exclCurrent="current/"

echo "log=backup;exclude=$exclCurrent"
echo "log=backup;exclude=$exclToday"
echo "log=backup;exclude=$exclYesterday"

rsync -ruvz \
    --remove-source-files \
    --exclude $exclCurrent \
    --exclude $exclToday \
    --exclude $exclYesterday \
    $src \
    $dst

# clean up empty folders (not achieveable as an rsync option)
find $src -depth -type d -empty -delete


echo "log=backup;ok;complete"

