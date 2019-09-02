#!/bin/bash

this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
Q=`dirname "${this}"`
. "$Q/config.sh"


# eg "../images/bracket/" "kilroy" "png"

hms=$(date +"%H%M%S")
name="bracket-$hms"
mimetype="jpg"
path="./"
brackets=3
fstops=4
seq=""

while getopts ":p:n:e:b:s:" opt; do
    case $opt in
        p) path=`echo $OPTARG` ;;
        n) name=`echo $OPTARG` ;;
        s) seq=`echo $OPTARG` ;;

        b) brackets=`echo $OPTARG` ;;
        e) mimetype=`echo $OPTARG` ;;
        f) fstops=`echo $OPTARG` ;;
        \?) echo "Invalid option -$OPTARG" >&2 ;;
    esac
done

mkdir -p $path

# Bracketing range
ev="0"
fstops=$(( 24 / brackets ))
range=$(( $brackets + $brackets + 1 ))

# Generate the bracketed photos
while [ $ev -lt $range ]; do

    # Cast linear int to signed byte
    # eg. 1= -24, ... 4=0 ... 7= +24
    exposure=$(( $fstops*(ev - brackets) ))
    ev=$(($ev + 1))
    evz=$(printf "%02d" $ev)

    filename="${path}${name}"

    if [ $seq ]; then
        sn="-$seq"
    fi

    # create the new filename
    # eg. bracket-1330-ev01-00000012.jpg
    output="${filename}-ev${evz}${sn}.${mimetype}"
    # echo "log=bracket;$output"

    # echo ">>> $exposure $output ($mimetype)"
    raspistill -t 2 -q 100 -ev $exposure -e $mimetype -o $output

    if [ $exposure -eq 0 ]; then
        current=$output
    fi
done

echo $current $range
