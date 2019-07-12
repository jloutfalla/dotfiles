export ENV="$HOME/.shinit"

if [ -d "$HOME"/.scripts ] && echo "$PATH" | grep -q -v ".scripts"
then

    export PATH="$PATH:$HOME/.scripts"

fi

export VISUAL="vim"
export EDITOR="$VISUAL"
