#!/bin/bash

. ./config.sh

delay=$1
runtime=$2
log="$relativeStats"


begin=`date +%s`
datetime=$(date -u +"%Y %m %d %H %M %S") # UTC date
daytime=$(./day_time.sh)

# Disk and CPU usage
disk=$(df | grep /dev/root)
cpu=$(ps -eo pcpu,cmd | sort -k 1 -r | head -20 | awk '{s+=$1} END {print s}')


# the imageResize image low-res & original path
imageResize=$(find "$relativeCurrent/" -regex ".*jpg$" -ls | awk '{print $11}' | sort | tail -1)
imageFullsize=$(find "$relativeStills/" -regex ".*jpg$" -ls | awk '{print $11}' | sort | tail -1)
imageCount=$(find "$relativeStills/" -regex ".*jpg$" | wc | awk '{print $1}')


finish=`date +%s`
localTime=$((finish-begin))
runtime=$(( runtime+localTime ))

payload="cmd=data"
payload+="\ntimestamp=$datetime"
payload+="\nsleepInterval=$sleepInterval"
payload+="\nserverRuntime=$runtime"
payload+="\ndiskDevice=$(echo $disk | awk '{print $1}')"
payload+="\ndiskTotal=$(echo $disk | awk '{print $2}')"
payload+="\ndiskAvail=$(echo $disk | awk '{print $3}')"
payload+="\ndiskUsed=$(echo $disk | awk '{print $4}')"
payload+="\ndiskPercent=$(echo $disk | awk '{print $5}')"
payload+="\ncpuLoad=$cpu"
payload+="\ntimeSunrise=$(echo $daytime | awk '{print $2}')"
payload+="\ntimeSunset=$(echo $daytime | awk '{print $4}')"
payload+="\ntimeUTC=$(echo $daytime | awk '{print $6}')"
payload+="\ntimeDaytime=$(echo $daytime | awk '{print $8}')"
payload+="\ntimeUpdate=$(echo $daytime | awk '{print $10}')"
payload+="\ntimeStayawake=$stayAwake"

payload+="\nimageResize=$imageResize"
payload+="\nimageFullsize=$imageFullsize"
payload+="\nimageCount=$imageCount"
payload+="\n."

echo -e $payload > ${log}.v2
echo $payload
