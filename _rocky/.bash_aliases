#!/usr/bin/env bash

alias cp='cp --interactive --verbose' 
alias diff='colordiff'
alias grep='grep --line-number --text --color=auto'
alias la='ls -l --classify --human-readable --color=auto --almost-all'
alias ls='ls -l --classify --human-readable --color=auto'
alias mkdir='mkdir --parents --verbose'
alias mv='mv --interactive --verbose'
alias path='echo -e ${PATH//:/ \\n}'
alias ping='ping -c 5'
alias pingf='ping -c 100 -i .2'
alias sdate='date -Iseconds'
