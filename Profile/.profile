#!/bin/sh

if [ -d "$HOME"/.scripts ] && echo "$PATH" | grep -q -v ".scripts"
then

    export PATH="$PATH:$HOME/.scripts"

fi

export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
 
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR"  ] && [ "$XDG_VTNR" -eq 1 ]
then
    startx
fi
