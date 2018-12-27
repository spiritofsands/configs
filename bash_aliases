source ~/.config/bash_aliases_completion

if type rg &> /dev/null; then
  GREP='rg'
else
  GREP='grep'
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if [[ -r ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi

  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias rgrep='rgrep --color=auto'
fi

# some more ls aliases
alias ll='ls -al'
alias l='ls'

# exit alias
alias :q='exit'

# extended cd. usage:  cd.. 10   cd.. dir
cd..() {
  case $1 in
    *[!0-9]*)
      cd "$( pwd | sed -r "s|(.*/$1[^/]*/).*|\1|" )" || return
      ;;                                               # if not found - not cd
    *)
      cd "$(printf "%0.0s../" $(seq 1 "$1"))" || return
      ;;
  esac
}

is_git() {
  [[ -d '.git' ]] || git rev-parse --is-inside-work-tree &> /dev/null
}

readonly _git_cmd_list=(
  add
  am
  branch
  checkout
  clean
  commit
  config
  diff
  difftool
  fetch
  log
  merge
  mergetool
  pull
  push
  rebase
  remote
  revert
  show
  stage
  stash
  status
  s
  tag
  review
)

_add_git_associations() {
  for git_cmd in "${_git_cmd_list[@]}"; do
    alias "$git_cmd=git $git_cmd"
  done

  _alias_completion
}

_remove_git_associations() {
  if alias | grep -Fq 'alias s='; then
    for git_cmd in "${_git_cmd_list[@]}"; do
        unalias "$git_cmd"
    done
  fi

  _alias_completion
}

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

wine32() {
  INEPREFIX=~/.wine WINEARCH=win32 wine "$@"
}

vm() {
    local -r vm_name="$1"
    local -r command="$2"

    if [[ "$command" == 'show' ]]; then
        virt-viewer -c qemu:///system "$vm_name"
    elif [[ "$command" == 'ip' ]]; then
        virsh -c qemu:///system domifaddr "$vm_name" | grep -Eo '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b'
    else
        virsh -c qemu:///system "$command" "$vm_name"
    fi
}

vm_android() {
    local -r vm_name='Android'
    vm "$vm_name" "$1"
}

vm_ubuntu() {
    local -r vm_name='ubuntu16.04'
    vm "$vm_name" "$1"
}

alias firefox-esr='firefox-esr-52 --P ESR --no-remote'
