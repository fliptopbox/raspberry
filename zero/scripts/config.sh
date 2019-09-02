#!/bin/bash

remoteRsyncServer="bruce@lithium"
remoteImageDest="Projects/github/raspberry/zero/images"

relativeImages="../images"
relativeStills="$relativeImages/still"
relativeCurrent="$relativeImages/current"

relativeData="../data"
relativeStats="$relativeData/stats.v2.txt"

intervalMinutes=1

# UI editable settings
# camera - ENUM list values
awb=off
drc=high
encoding=jpg
exposure=off
imxfx=none
metering=average

# camera - primitive values
ISO=50
brightness=50
contrast=0
ev=0
interval=360
quality=100
rotation=0
saturation=26
sharpness=0


# proxy settings
stayAwake=false
sleepInterval=$interval
jpgQuality=$quality
cameraTimeout=3 # as seconds
resizeAmount=3

# sunrise/sunset geolocation
lat=51.5465589
lng=-0.0352543

# relative size calculation
fullsizeWidth=3280
fullsizeHeight=2464

resizeWidth=$(( $fullsizeWidth/$resizeAmount ))
resizeHeight=$(( $fullsizeHeight/$resizeAmount ))
