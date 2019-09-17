#!/bin/sh

usage() {
    echo "USAGE: $(basename "$0") IMAGE"
    echo ""
    echo "Set IMAGE as the background image"
}

if [ -z "$1" ] || [ ! -f "$1" ]
then

    usage
    exit 1
    
else

    feh --bg-scale "$1"
    
fi
