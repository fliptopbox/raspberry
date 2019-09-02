#!/bin/bash
#
#                          ██                               ██
#                         ░██                              ░██
#    ██████████   ██████  ░██  ██  █████        ██████████ ░██  ██ ██    ██
#   ░░██░░██░░██ ░░░░░░██ ░██ ██  ██░░░██      ░░██░░██░░██░██ ██ ░██   ░██
#    ░██ ░██ ░██  ███████ ░████  ░███████       ░██ ░██ ░██░████  ░░██ ░██
#    ░██ ░██ ░██ ██░░░░██ ░██░██ ░██░░░░        ░██ ░██ ░██░██░██  ░░████
#    ███ ░██ ░██░░████████░██░░██░░██████ █████ ███ ░██ ░██░██░░██  ░░██
#   ░░░  ░░  ░░  ░░░░░░░░ ░░  ░░  ░░░░░░ ░░░░░ ░░░  ░░  ░░ ░░  ░░    ░░
#
#       Usage example:
#       ./make_mkv.sh -w 1920 -h 1080 -p "../images/still/"
#       ./make_mkv.sh -p "../images/still/"
#
#
#       FFmpeg requires that the "frames" list uses absolute path
#       using PWD (to this file) chop off the tail (ie /scripts)
#       so the path is relative to the parent folder.
#
#

width=1920
height=1080
path="../images/still/"


while getopts ":p:w:h:" opt; do
    case $opt in
        w) width=`echo $OPTARG` ;;
        h) height=`echo $OPTARG` ;;
        p) path=`echo $OPTARG` ;;

        \?) echo "Invalid option -$OPTARG" >&2 ;;
    esac
done

parent=$(echo `pwd` | sed -E 's/\/[a-z]+$//')
folder=$(echo "$path" | sed 's/\.\.//')
images="${parent}${folder}"
tmp="${images}/ffmpeg_frames.txt"

# find $images -regex ".*jpg$" -print0 | xargs -0 echo "file %i\n" | sort -V > $tmp
find $images -regex ".*jpg$" | sort > $tmp
sed -i -e 's/^/file /' $tmp

frames=$(wc -l $tmp | awk '{print $1}')
output="${images}clip-f${frames}-${width}x${height}.mkv"


ffmpeg -hide_banner -y -f concat -safe 0 -i $tmp -vf scale=${width}x${height} $output
cat $tmp
# rm $tmp


