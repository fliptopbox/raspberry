#!/bin/bash

remoteRsyncServer="bruce@lithium"
remoteImageDest="Projects/github/raspberry/zero/images"

relativeImages="../images"
relativeStills="$relativeImages/still"
relativeCurrent="$relativeImages/current"

relativeData="../data"
relativeStats="$relativeData/stats.txt"

stayAwake=true
sleepInterval=$(( 1*60 )) # seconds

lat=51.5465589
lng=-0.0352543
