# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# history length
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and update if necessary
shopt -s checkwinsize

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# prompt
PROMPT_COMMAND=__prompt_command
__prompt_command() {
  local EXIT="$?"
  local RCol='\[\e[0m\]'
  local Red='\[\e[0;31m\]'
  local Cyan='\[\e[36m\]'
  local Yel='\[\e[0;33m\]'

  PS1="${Cyan}\w${RCol}"

  if [ $EXIT -ne 0 ]; then
    PS1+="${Red}\$${RCol} "
  else
    PS1+="${Cyan}\$${RCol} "
  fi

  # git shortcuts where possible
  if is_git; then
    _add_git_associations
  else
    _remove_git_associations
  fi
}

# get immediate notification of background job termination
set -o notify

# disable ctrl+d
set -o ignoreeof

# fix small typos
shopt -s cdspell

# ctrl+l in vi mode
bind -m vi-insert "\C-l":clear-screen

# editor
export VISUAL=vim
export EDITOR="$VISUAL"

# ignore case completion
bind "set completion-ignore-case on"

# disable ctrl-s, ctrl-q
stty stop ''
stty start ''
stty -ixon
stty -ixoff


#
# PATH ADDITIONS
#

# add user's bin
if [[ -d ~/bin ]]; then
  export PATH="$PATH:$HOME/bin"
fi

# rbenv
if [[ -d ~/.rbenv/bin ]]; then
  export PATH="$PATH:$HOME/.rbenv/bin"
  eval "$(rbenv init -)"
fi

# fzf
if [[ -d ~/.local/lib/fzf ]]; then
  if [[ -d ~/.local/lib/fzf/bin ]]; then
    export PATH="$PATH:$HOME/.local/lib/fzf/bin"
  fi

  if [[ -f ~/.local/lib/fzf/shell/key-bindings.bash ]]; then
    source ~/.local/lib/fzf/shell/key-bindings.bash
  fi

  export FZF_DEFAULT_COMMAND='fd --type f --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  # Use fd
  _fzf_compgen_path() {
    fd --follow --exclude ".git" . "$1"
  }
  _fzf_compgen_dir() {
    fd --type d --follow --exclude ".git" . "$1"
  }
fi

# yarn
if [[ -d ~/bin/yarn-v1.6.0/bin ]]; then
  export PATH="$PATH:$HOME/bin/yarn-v1.6.0/bin"
fi

# npm n
if [[ -d ~/.local/lib/n/bin ]]; then
  # git clone https://github.com/tj/n ~/.local/lib/n
  export PATH="$PATH:$HOME/.local/lib/n/bin"
  export N_PREFIX="$HOME/.local/lib/n"
fi

# cargo
if [[ -d ~/.cargo/bin ]]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

# golang
export GOPATH="$HOME/.local/lib/go"
if [[ -d "$GOPATH/bin" ]]; then
  export PATH="$PATH:$GOPATH/bin"
fi

# android platform tools
if [[ -d ~/bin/android-platform-tools ]]; then
  export PATH="$PATH:$HOME/bin/android-platform-tools"
  export USE_CCACHE=1
  export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx5G"
fi

# added by travis gem
if [[ -f /home/kos/.travis/travis.sh ]]; then
  source /home/kos/.travis/travis.sh
fi

if [[ -d ~/.local/lib/oclint-0.13.1/bin ]]; then
  export PATH="$PATH:$HOME/.local/lib/oclint-0.13.1/bin"
fi

#if [[ -d ~/.local/lib/cmake-3.5.1-Linux-x86_64/bin ]]; then
#  export PATH="$PATH:$HOME/.local/lib/cmake-3.5.1-Linux-x86_64/bin"
#fi

if [[ -d ~/.local/bin ]]; then
export PATH="$PATH:$HOME/.local/bin"
fi
