#!/bin/sh

if [ -d "$HOME/.local/bin" ] && echo "$PATH" | grep -q -v "$HOME/.local/bin"
then

    export PATH="$PATH:$HOME/.local/bin"

fi


# Default programs
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export TERMINAL="alacritty"
export BROWSER="firefox"

# Clean of ~/ :
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export ATOM_HOME="$XDG_DATA_HOME/atom"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache.config"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export LESSHISTFILE="-"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export _Z_DATA="$XDG_DATA_HOME/z"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$XDG_DATA_HOME/zsh/history"

 
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR"  ] && [ "$XDG_VTNR" -eq 1 ]
then
    startx "$XDG_CONFIG_HOME/X11/xinitrc"
fi

