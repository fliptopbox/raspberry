#!/bin/bash

. ./config.sh

delay=$1
runtime=$2
log="$relativeStats"


begin=`date +%s`
created=`date -u +%s`
expires=$(( created+sleepInterval ))
datetime=$(date -u +"%Y-%m-%dT%H:%M:%S") # UTC date in ISO8601 format
upsince=$(uptime -s)
daytime=$(./day_time.sh)

# Disk and CPU usage
disk=$(df | grep /dev/root)
cpu=$(ps -eo pcpu,cmd | sort -k 1 -r | head -20 | awk '{s+=$1} END {print s}')


# the imageResize image low-res & original path
imageResize=$(find "$relativeCurrent/" -regex ".*jpg$" -ls | awk '{print $11}' | sort | tail -1)
imageFullsize=$(find "$relativeStills/" -regex ".*jpg$" -ls | awk '{print $11}' | sort | tail -1)
imageCount=$(find "$relativeStills/" -regex ".*jpg$" | wc | awk '{print $1}')



payload="cmd=data"
payload+="&created=$created"
payload+="&expires=$expires"
payload+="&timestamp=${datetime}Z"


payload+="&diskDevice=$(echo $disk | awk '{print $1}')"
payload+="&diskTotal=$(echo $disk | awk '{print $2}')"
payload+="&diskAvail=$(echo $disk | awk '{print $3}')"
payload+="&diskUsed=$(echo $disk | awk '{print $4}')"
payload+="&diskPercent=$(echo $disk | awk '{print $5}')"

payload+="&timeSunrise=$(echo $daytime | awk '{print $2}')"
payload+="&timeSunset=$(echo $daytime | awk '{print $4}')"
payload+="&timeUTC=$(echo $daytime | awk '{print $6}')"
payload+="&timeDaytime=$(echo $daytime | awk '{print $8}')"
payload+="&timeUpdate=$(echo $daytime | awk '{print $10}')"
payload+="&timeInterval=$sleepInterval"
payload+="&timeStayawake=$stayAwake"

payload+="&sleepInterval=$sleepInterval"

payload+="&imageResize=$imageResize"
payload+="&imageFullsize=$imageFullsize"
payload+="&imageCount=$imageCount"


payload+="&settingsAwb=$awb"
payload+="&settingsDrc=$drc"
payload+="&settingsEncoding=$encoding"
payload+="&settingsExposure=$exposure"
payload+="&settingsImxfx=$imxfx"
payload+="&settingsMetering=$metering"

payload+="&settingsISO=$ISO"
payload+="&settingsBrightness=$brightness"
payload+="&settingsContrast=$contrast"
payload+="&settingsEv=$ev"
payload+="&settingsInterval=$interval"
payload+="&settingsQuality=$quality"
payload+="&settingsRotation=$rotation"
payload+="&settingsSaturation=$saturation"
payload+="&settingsSharpness=$sharpness"
payload+="&settingsReduction=$reduction"
payload+="&settingsBracket=$bracket"

payload+="&settingsPreview=$preview"

finish=`date +%s`
localTime=$((finish-begin))
runtime=$(( runtime+localTime ))

payload+="&serverRuntime=$runtime"
payload+="&serverUptime=$upsince"
payload+="&serverCPU=$cpu"

echo $payload > ${log}
echo $payload
