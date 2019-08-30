#!/bin/sh

usage() {
	echo "USAGE:"
	printf "\t%s VIDEO SUBTITLES OUTPUT_NAME\n" "$(basename "$0")"
	echo
	echo "Create OUTPUT_NAME by adding the SUBTITLES to VIDEO"
}


if [ "$#" -lt 3 ] ||  grep -c -E "(-h|--help)" "$@"
then
	usage
	exit 1
fi

ffmpeg -i "$1" -i "$2" -map 0 -map 1 -c copy -metadata:s:s:0 language=fr "$3"
