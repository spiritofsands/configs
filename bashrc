# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXIT="$?"

    local RCol='\[\e[0m\]'
    local Red='\[\e[0;31m\]'
    local Cyan='\[\e[36m\]'
    local Yel='\[\e[0;33m\]'
    # local Gre='\[\e[0;32m\]'
    # local BBlu='\[\e[1;34m\]'
    # local Pur='\[\e[0;35m\]'


    PS1="${Cyan}\w${RCol}"


    if [ $EXIT -ne 0 ]; then
        PS1+="${Red}\$${RCol} "
    else
        PS1+="${Cyan}\$${RCol} "
    fi

    if [[ "$IS_GIT" -eq 1 ]]; then
      git_status="$(git status --porcelain=2 2>/dev/null)"
      if [[ $? -eq 0  ]]; then
        if [[ ! -z "$git_status" ]]; then
          PS1+="${Red}"
        else
          PS1+="${Yel}"
        fi
      fi
      PS1+="git> ${RCol}"
    fi
  }

# Get immediate notification of background job termination
set -o notify


# Fix small typos
shopt -s cdspell

# VI mode
set -o vi
bind -m vi-insert "\C-l":clear-screen

bind "set completion-ignore-case on"

# Disable ctrl-s
stty -ixon

# Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
