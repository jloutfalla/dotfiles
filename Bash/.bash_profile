#!/bin/sh
#
# ~/.bash_profile
#

. "$HOME/.profile"

[ "$PS1" ] && [ -f /usr/share/bash-completion/bash_completion ] && \
    . /usr/share/bash-completion/bash_completion

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
