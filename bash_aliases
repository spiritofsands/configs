source ~/.config/bash_helpers

if _is_installed rg; then
  GREP='rg'
else
  GREP='grep'
fi

alias 'cd..'='_change_dir'

if [ -x /usr/bin/dircolors ]; then
  if [[ -r ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi

  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# some more ls aliases
alias ll='ls -al'
alias l='ls'

# exit alias
alias ':q'='exit'

alias alert='notify-send --urgency=low -i \
    "$([ $? = 0 ] && echo terminal || echo error)" \
    "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if _is_installed wine; then
    alias wine32='INEPREFIX=~/.wine WINEARCH=win32 wine'
fi

alias vm_ubuntu='_vm ubuntu16.04'

alias firefox-esr='firefox-esr-52 --P ESR --no-remote'
