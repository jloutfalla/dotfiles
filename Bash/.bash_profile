#
# ~/.bash_profile
#

source "$HOME/.profile"

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

[[ -f ~/.bashrc ]] && . ~/.bashrc
