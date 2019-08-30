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

# camera arguments
encoding=jpg
exposure=off
ev=0
awb=off
sharpness=0
contrast=0
saturation=25
brightness=50
imxfx=none
metering=average
rotation=0
drc=off
ISO=600
quality=100


# proxy settings
stayAwake=true
sleepInterval=30
jpgQuality=100
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
