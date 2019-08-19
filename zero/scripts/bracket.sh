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
fstops=8
seq=""

while getopts ":p:n:e:b:s:" opt; do
    case $opt in
        p) path=`echo $OPTARG` ;;
        n) name=`echo $OPTARG` ;;
        s) seq=`echo $OPTARG` ;;

        b) bracket=`echo $OPTARG` ;;
        e) encoding=`echo $OPTARG` ;;
        f) fstops=`echo $OPTARG` ;;
        \?) echo "Invalid option -$OPTARG" >&2 ;;
    esac
done

mkdir -p $path

# Bracketing range
ev="0"
range=$(($bracket + $bracket + 1))

# Generate the bracketed photos
while [ $ev -lt $range ]; do

    # Cast linear int to signed byte
    # eg. 1= -24, ... 4=0 ... 7= +24
    exposure=$(( $fstops*(ev -bracket) ))
    ev=$(($ev + 1))

    filename="${path}${name}"

    
    if [ $seq ]; then
        sn="-$seq"
    fi

    # create the new filename
    # eg. seq-00000001-EV1.jpg
    output="${filename}-ev${ev}${sn}.${encoding}"

    # echo ">>> $exposure $output ($encoding)"
    raspistill -t 2 -q 100 -ev $exposure -e $encoding -o $output

    if [ $exposure -eq 0 ]; then
        current=$output
    fi
done

echo $current $range
