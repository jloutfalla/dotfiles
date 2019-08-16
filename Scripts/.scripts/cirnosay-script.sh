#!/bin/sh

usage() {
    echo "This script prompt Cirno saying something thanks to cirnosay"
}

if [ "$#" -gt 0 ]
then

    usage
    exit 0

fi

# Default path to the pics of Cirno
CIRNO_IMAGES_PATH="/usr/share/cirnosay/pictures"


cirno="Touhoudex_Chibi_Cirno.png Touhoudex_Cirno.png" #Touhoudex_EX_Cirno.png
nbrRandom=$(random.sh)
randomCirno=$(((nbrRandom % 2) + 1))

quotes="I'm the strongest !|You BAKA !|Yes eye can !"
nbrRandom=$((random.sh))
randomQuotes=$(((nbrRandom % 3) + 1))

cirno=$(echo "$cirno" | cut -d " " -f "$randomCirno")
quotes=$(echo "$quotes" | cut -d "|" -f "$randomQuotes")

echo ""
cirnosay -b a -i "$CIRNO_IMAGES_PATH/$cirno" "$quotes"
