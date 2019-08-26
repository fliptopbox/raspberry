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

width=720
height=480
path="../images/still/"


while getopts ":p:w:h:" opt; do
    case $opt in
        w) width=`echo $OPTARG` ;;
        h) height=`echo $OPTARG` ;;
        p) path=`echo $OPTARG` ;;

        \?) echo "Invalid option -$OPTARG" >&2 ;;
    esac
done

parent=$(echo `pwd` | sed -r 's/\/([^\/]+)$//');
folder=$(echo "$path" | sed -r 's/(^[^\/]+)//')
images="${parent}${folder}"
output="${images}clip-${width}x${height}.mkv"

tmp="${parent}/ffmpeg_frames.txt"

find $images -regex ".*jpg$" -printf "file %p\n" | sort -V > $tmp

# ffmpeg -f concat -safe 0 -i <(find images/ -regex ".*jpg$" -printf "file `pwd`/%p\n" | sort -V) -vf scale=640x480 text.mkv
ffmpeg -y -f concat -safe 0 -i $tmp -vf scale=${width}x${height} $output

rm $tmp


