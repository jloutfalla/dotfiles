#!/bin/sh

# Source environment variables set by SystemD
# https://github.com/systemd/systemd/issues/7641#issuecomment-693117066
set -a
. /dev/fd/0 <<EOF
$(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
EOF
set +a

# Add scripts to the PATH
if [ -d "$HOME/.local/bin" ] && echo "$PATH" | grep -q -v "$HOME/.local/bin"
then

    export PATH="$PATH:$HOME/.local/bin"

fi


# Default programs
export EDITOR="emacsclient -t -a vim"
export VISUAL="open-emacsclient"
export TERMINAL="st"
export BROWSER="firefox"

# Allow Qt to change theme
export QT_QPA_PLATFORMTHEME=qt5ct

# Set the sudo prompt to use dpass
export SUDO_ASKPASS="$HOME/.local/bin/dpass"

# Fix Java application windows
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT="MToolkit"

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
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export LESSHISTFILE="-"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
RUST_SRC_PATH="$(rustc --print sysroot)"
export RUST_SRC_PATH="$RUST_SRC_PATH/lib/rustlib/src/rust/library"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export _Z_DATA="$XDG_DATA_HOME/z"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$XDG_DATA_HOME/history"
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export CABAL_DIR="$XDG_CACHE_HOME/cabal"


# Set SSH_AUTH_SOCK to the GPG Agent socket
unset SSH_AGENT_PID
GPG_SSH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
if [ "${gnu_SSH_AUTH_SOCK_by-0}" -ne $$ ]
then
    export SSH_AUTH_SOCK="$GPG_SSH_SOCK"
    gpgconf --launch gpg-agent
fi

[ "$(pgrep -fc 'emacs --.*daemon')" -eq 0 ] && \
	emacs --daemon &

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR"  ] && [ "$XDG_VTNR" -eq 1 ]
then
    startx "$XDG_CONFIG_HOME/X11/xinitrc"
fi
