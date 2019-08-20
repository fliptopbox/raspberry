#!/bin/bash

remoteRsyncServer="bruce@lithium"
remoteImageDest="Projects/github/raspberry/zero/images"

relativeImages="../images"
relativeStills="$relativeImages/still"
relativeCurrent="$relativeImages/current"

relativeData="../data"
relativeStats="$relativeData/stats.txt"

stayAwake=true
sleepInterval=$(( 5*60 )) # seconds

lat=51.5465589
lng=-0.0352543

ISO=300
jpgQuality=100
cameraTimeout=3
resizeAmount=3
resizeWidth=$(( 3280/$resizeAmount ))
resizeHeight=$(( 2464/$resizeAmount ))
