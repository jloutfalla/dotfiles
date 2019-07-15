#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'
alias lal='ls -lah --color=auto --group-directories-first'
alias la='ls -a --color=auto --group-directories-first'

PS1='[\u@\h \W]\$ '

cd ~
