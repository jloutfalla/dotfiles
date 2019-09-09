#!/bin/sh

if [ -d "$HOME"/.scripts ] && echo "$PATH" | grep -q -v ".scripts"
then

    export PATH="$PATH:$HOME/.scripts"

fi

export VISUAL="vim"
export EDITOR="$VISUAL"


if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]
then

    startx

fi

