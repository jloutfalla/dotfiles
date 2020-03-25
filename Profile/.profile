#!/bin/sh

if [ -d "$HOME/.local/bin" ] && echo "$PATH" | grep -q -v "$HOME/.local/bin"
then

    export PATH="$PATH:$HOME/.local/bin"

fi


# Default programs
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export TERMINAL="alacritty"
export BROWSER="icecat"

# Clean of ~/ :
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export LESSHISTFILE="-"
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export _Z_DATA="$XDG_DATA_HOME/z"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$XDG_DATA_HOME/zsh/history"

 
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR"  ] && [ "$XDG_VTNR" -eq 1 ]
then
    startx "$XDG_CONFIG_HOME/X11/xinitrc"
fi

