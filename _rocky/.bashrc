#!/usr/bin/env bash

# Source global definitions.
if [ -f "/etc/bashrc" ]; then
	source "/etc/bashrc"
fi

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return ;;
esac

# Common ---------------------------------------------------------------------#

export HISTFILE=~/.bash_history
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoreboth

export LANG="en_US"
export LC_ALL=$LANG.UTF-8

export TERM=xterm

# Config ---------------------------------------------------------------------#

shopt -s checkwinsize
shopt -s extdebug
shopt -s globstar
shopt -s histappend

# Completion -----------------------------------------------------------------#

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Prompt ---------------------------------------------------------------------#

# TODO

# Alias defintions -----------------------------------------------------------#

if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

# Function defintions --------------------------------------------------------#

if [ -f "$HOME/.bash_functions" ]; then
    source "$HOME/.bash_functions"
fi

# Hook defintions ------------------------------------------------------------#

if [ -f "$HOME/.bash_hooks" ]; then
    source "$HOME/.bash_hooks"
fi
