#!/bin/bash

this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
Q=`dirname "${this}"`
. "$Q/config.sh"


# eg "../images/bracket/" "kilroy" "png"

hms=$(date +"%H%M%S")
name="bracket-$hms"
encoding="jpg"
path="./"
bracket=3
stops=8

while getopts ":p:n:e:b:s:" opt; do
    case $opt in
        p) path=`echo $OPTARG` ;;
        b) bracket=`echo $OPTARG`;;
        e) encoding=`echo $OPTARG`;;
        s) stops=`echo $OPTARG`;;
        n) name=`echo $OPTARG`;;
        \?) echo "Invalid option -$OPTARG" >&2 ;;
    esac
done

clear

printf "\n\nPiCamera - LDR bracketing:\n\n"
echo "Destination: $path"
echo "Filename: $name"
echo "Encoding: $encoding"
echo "Bracket: ${bracket}"
echo "Stops: ${stops}"
printf "\n\n"

mkdir -p $path

# Bracketing range
ev="0"
range=$(($bracket + $bracket + 1))
filename="${path}${name}"

# Generate the bracketed photos
while [ $ev -lt $range ]; do

    # Cast linear int to signed byte
    # eg. 1= -24, ... 4=0 ... 7= +24
    exposure=$(( $stops*(ev -bracket) ))
    ev=$(($ev + 1))

    # create the new filename
    # eg. seq-00000001-EV1.jpg
    output="${filename}-EV${ev}.${encoding}"

    echo ">>> $exposure $output ($encoding)"
    raspistill -t 2 -q 100 -ev $exposure -e $encoding -o $output

done