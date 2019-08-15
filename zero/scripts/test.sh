#!/bin/bash

#_="$(dirname "$0")"
this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
Q=`dirname "${this}"`


. "$Q/config.sh"
echo $relativeStills

