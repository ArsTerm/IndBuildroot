#!/bin/sh

mkdir $2
/bin/mount $1 $2
retVal="$?"
if [ "$retVal" -ne "0" ]; then
    rmdir $2
fi