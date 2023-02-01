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

# enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# alias definitions
if [ -f "$HOME/bin/bash_helpers/aliases.bash" ]; then
    source "$HOME/bin/bash_helpers/aliases.bash"
fi

# prompt
__prompt_command() {
  local -r exit="$?"
  local -r reset_color='\[\e[0m\]'
  local -r red='\[\e[0;31m\]'
  local -r cyan='\[\e[36m\]'
  local -r yellow='\[\e[0;33m\]'
  local -r path="$cyan\\w$reset_color"

  local error_hl=''
  if [ "$exit" -ne 0 ]; then
    error_hl="$red\$$reset_color "
  else
    error_hl="$cyan\$$reset_color "
  fi

  local hostname=''
  if _is_ssh; then
      hostname="SSH:$yellow\\h$reset_color "
  fi

  PS1="
$hostname$path$error_hl"

  # initialize git shortcuts where possible
  _init_short_git
}
PROMPT_COMMAND=__prompt_command

# get immediate notification of background job termination
set -o notify

# disable ctrl+d
set -o ignoreeof

# set vi mode
set -o vi

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
if [[ -d "$HOME/bin" ]]; then
    export PATH="$PATH:$HOME/bin"
    if [[ -d "$HOME/bin/etc" ]]; then
        export PATH="$PATH:$HOME/bin/etc"
    fi
fi

# rbenv
if [[ -d "$HOME/.rbenv/bin" ]]; then
  export PATH="$PATH:$HOME/.rbenv/bin"
  eval "$(rbenv init -)"
fi

# fzf
if [[ -d "$HOME/bin/etc/fzf" ]]; then
  source "$HOME/bin/etc/fzf/fzf.bash"

  export FZF_DEFAULT_COMMAND='fdfind --type f --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  # Use fd
  _fzf_compgen_path() {
    fd --follow --exclude ".git" . "$1"
  }
  _fzf_compgen_dir() {
    fd --type d --follow --exclude ".git" . "$1"
  }
fi

# npm n
if [[ -d "$HOME/n" ]]; then
    export N_PREFIX="$HOME/n";
    export PATH="$PATH:$N_PREFIX/bin"
fi

# cargo
if [[ -d "$HOME/.cargo/bin" ]]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

# golang
export GOPATH="$HOME/.local/lib/go"
if [[ -d "$GOPATH/bin" ]]; then
  export PATH="$PATH:$GOPATH/bin"
fi

# android platform tools
if [[ -d "$HOME/bin/android-platform-tools" ]]; then
  export PATH="$PATH:$HOME/bin/android-platform-tools"
  export USE_CCACHE=1
  export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx5G"
fi

if [[ -d "$HOME/bin/etc/pyenv" ]]; then
    export PYENV_ROOT="$HOME/bin/etc/pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    export PATH="$PYENV_ROOT/shims:${PATH}"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi
fi

if [ -d ~/.local/bin ]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

xrdb ~/.Xresources
