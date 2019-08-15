#!/bin/bash

this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
Q=`dirname "${this}"`
. "$Q/config.sh"

delay=$1
runtime=$2
log="$relativeStats"


# Overwrite existing stats
datetime=$(date -u +"%Y %m %d %H %M %S") # UTC date
echo "$datetime $delay" > $log

# Disk and CPU usage
disk=$(df | grep /dev/root)
cpu=$(ps -eo pcpu,cmd | sort -k 1 -r | head -20 | awk '{s+=$1} END {print s}')
echo "$disk $cpu $runtime" >> $log

# Current daytime status
echo $(./day_time.sh) >> $log

# the current image low-res & original path
current=$(find "$relativeCurrent/" -regex ".*jpg$" -ls | awk '{print $11}' | sort | tail -1)
frames=$(find "$relativeStills/" -regex ".*jpg$" -ls | awk '{print $11}' | sort | tail -1)
echo "$current" >> $log
echo "$frames" >> $log

# EOF fullstop
echo "." >> $log
