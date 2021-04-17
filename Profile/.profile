#!/bin/sh

# Add scripts to the PATH
if [ -d "$HOME/.local/bin" ] && echo "$PATH" | grep -q -v "$HOME/.local/bin"
then

    export PATH="$PATH:$HOME/.local/bin"

fi


# Default programs
export EDITOR="emacsclient -t -a vim"
export VISUAL="open-emacsclient"
export TERMINAL="st"
export BROWSER="icecat"

# Allow Qt to change theme
export QT_QPA_PLATFORMTHEME=qt5ct

# Set the sudo prompt to use dpass
export SUDO_ASKPASS="$HOME/.local/bin/dpass"

# Fix Java application windows
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT="MToolkit"

# Clean of ~/ :
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export LESSHISTFILE="-"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
RUST_SRC_PATH="$(rustc --print sysroot)"
export RUST_SRC_PATH="$RUST_SRC_PATH/lib/rustlib/src/rust/library"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export _Z_DATA="$XDG_DATA_HOME/z"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$XDG_DATA_HOME/history"


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

# Set SSH_AUTH_SOCK to the GPG Agent socket
unset SSH_AGENT_PID
GPG_SSH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
if [ "${gnu_SSH_AUTH_SOCK_by-0}" -ne $$ ]
then
    export SSH_AUTH_SOCK="$GPG_SSH_SOCK"
    gpgconf --launch gpg-agent
fi


if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR"  ] && [ "$XDG_VTNR" -eq 1 ]
then
    startx "$XDG_CONFIG_HOME/X11/xinitrc"
fi
