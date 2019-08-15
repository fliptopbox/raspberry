#!/bin/bash

this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
Q=`dirname "${this}"`

. "$Q/config.sh"

root="$relativeStills/"
current=`ls -lR $root \
    | grep -E '[0-9]{8}\.*jpg$' \
    | tail -1 \
    | sed -E 's/(.*)-([0-9]{8})(.*)/\2/g' \
    | sed 's/^[0]*//g'`


next=`printf %08d $((current + 1))`
echo "$next $current"
