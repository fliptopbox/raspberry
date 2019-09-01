#!/bin/bash

relativeImages="../images"
relativeStills="$relativeImages/still"
relativeCurrent="$relativeImages/current"

relativeData="../data"
relativeStats="$relativeData/stats.v2.txt"

# daily maintainance via rsync
rsyncBackup=20190901
rsyncLogin="bruce@lithium"
rsyncSource="$relativeImages/"
rsyncDest="Projects/github/raspberry/zero/images"


# UI editable settings
# camera - ENUM list values
awb=auto
drc=high
encoding=jpg
exposure=auto
imxfx=none
metering=average

# camera - primitive values
ISO=50
brightness=50
contrast=0
ev=0
interval=300
timeout=3
quality=100
rotation=0
saturation=26
sharpness=0

# helper settings/values
reduction=3



# proxy settings
stayAwake=false
sleepInterval=$interval
jpgQuality=$quality
cameraTimeout=$timeout
resizeAmount=$reduction

# sunrise/sunset geolocation
lat=51.5465589
lng=-0.0352543

# relative size calculation
fullsizeWidth=3280
fullsizeHeight=2464

resizeWidth=$(( $fullsizeWidth/$resizeAmount ))
resizeHeight=$(( $fullsizeHeight/$resizeAmount ))
