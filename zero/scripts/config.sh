#!/bin/bash

remoteRsyncServer="bruce@lithium"
remoteImageDest="Projects/github/raspberry/zero/images"

relativeImages="../images"
relativeStills="$relativeImages/still"
relativeCurrent="$relativeImages/current"

relativeData="../data"
relativeStats="$relativeData/stats.v2.txt"

stayAwake=false # do not sleep at night
intervalMinutes=5
sleepInterval=$(( $intervalMinutes*55 )) # value as seconds

lat=51.5465589
lng=-0.0352543

ISO=300
jpgQuality=100
cameraTimeout=3 # as seconds
resizeAmount=3
resizeWidth=$(( 3280/$resizeAmount ))
resizeHeight=$(( 2464/$resizeAmount ))
