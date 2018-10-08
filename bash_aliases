if type rg &> /dev/null; then
  GREP='rg'
else
  GREP='grep'
fi

# Automatically add completion for all aliases to commands having completion functions
_alias_completion() {
    local namespace="alias_completion"

    # parse function based completion definitions, where capture group 2 => function and 3 => trigger
    local compl_regex='complete( +[^ ]+)* -F ([^ ]+) ("[^"]+"|[^ ]+)'
    # parse alias definitions, where capture group 1 => trigger, 2 => command, 3 => command arguments
    local alias_regex="alias ([^=]+)='(\"[^\"]+\"|[^ ]+)(( +[^ ]+)*)'"

    # create array of function completion triggers, keeping multi-word triggers together
    eval "local completions=($(complete -p | sed -Ene "/$compl_regex/s//'\3'/p"))"
    (( ${#completions[@]} == 0 )) && return 0

    # create temporary file for wrapper functions and completions
    rm -f "/tmp/${namespace}-*.tmp" # preliminary cleanup
    local tmp_file; tmp_file="$(mktemp "/tmp/${namespace}-${RANDOM}XXX.tmp")" || return 1

    local completion_loader; completion_loader="$(complete -p -D 2>/dev/null | sed -Ene 's/.* -F ([^ ]*).*/\1/p')"

    # read in "<alias> '<aliased command>' '<command args>'" lines from defined aliases
    local line; while read line; do
        eval "local alias_tokens; alias_tokens=($line)" 2>/dev/null || continue # some alias arg patterns cause an eval parse error
        local alias_name="${alias_tokens[0]}" alias_cmd="${alias_tokens[1]}" alias_args="${alias_tokens[2]# }"

        # skip aliases to pipes, boolean control structures and other command lists
        # (leveraging that eval errs out if $alias_args contains unquoted shell metacharacters)
        eval "local alias_arg_words; alias_arg_words=($alias_args)" 2>/dev/null || continue
        # avoid expanding wildcards
        read -a alias_arg_words <<< "$alias_args"

        # skip alias if there is no completion function triggered by the aliased command
        if [[ ! " ${completions[*]} " =~ " $alias_cmd " ]]; then
            if [[ -n "$completion_loader" ]]; then
                # force loading of completions for the aliased command
                eval "$completion_loader $alias_cmd"
                # 124 means completion loader was successful
                [[ $? -eq 124 ]] || continue
                completions+=($alias_cmd)
            else
                continue
            fi
        fi
        local new_completion="$(complete -p "$alias_cmd")"

        # create a wrapper inserting the alias arguments if any
        if [[ -n $alias_args ]]; then
            local compl_func="${new_completion/#* -F /}"; compl_func="${compl_func%% *}"
            # avoid recursive call loops by ignoring our own functions
            if [[ "${compl_func#_$namespace::}" == $compl_func ]]; then
                local compl_wrapper="_${namespace}::${alias_name}"
                    echo "function $compl_wrapper {
                        (( COMP_CWORD += ${#alias_arg_words[@]} ))
                        COMP_WORDS=($alias_cmd $alias_args \${COMP_WORDS[@]:1})
                        (( COMP_POINT -= \${#COMP_LINE} ))
                        COMP_LINE=\${COMP_LINE/$alias_name/$alias_cmd $alias_args}
                        (( COMP_POINT += \${#COMP_LINE} ))
                        $compl_func
                    }" >> "$tmp_file"
                    new_completion="${new_completion/ -F $compl_func / -F $compl_wrapper }"
            fi
        fi

        # replace completion trigger by alias
        new_completion="${new_completion% *} $alias_name"
        echo "$new_completion" >> "$tmp_file"
    done < <(alias -p | sed -Ene "s/$alias_regex/\1 '\2' '\3'/p")
    source "$tmp_file" && rm -f "$tmp_file"
}

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
alias ll='ls -alhF'
alias l='ls -CF'

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

_add_git_associations() {
  alias add='git add'
  alias am='git am'
  alias branch='git branch'
  alias checkout='git checkout'
  alias clean='git clean'
  alias commit='git commit'
  alias config='git config'
  alias diff='git diff'
  alias difftool='git difftool'
  alias fetch='git fetch'
  alias log='git log'
  alias merge='git merge'
  alias mergetool='git mergetool'
  alias pull='git pull'
  alias push='git push'
  alias rebase='git rebase'
  alias remote='git remote'
  alias revert='git revert'
  alias show='git show'
  alias stage='git stage'
  alias stash='git stash'
  alias status='git status'
  alias s='git status'
  alias tag='git tag'

  _alias_completion
}

_remove_git_associations() {
  if alias | ${GREP} -Fq 'alias s='; then
    unalias add
    unalias am
    unalias branch
    unalias checkout
    unalias clean
    unalias commit
    unalias config
    unalias diff
    unalias difftool
    unalias fetch
    unalias log
    unalias merge
    unalias mergetool
    unalias pull
    unalias push
    unalias rebase
    unalias remote
    unalias revert
    unalias show
    unalias stage
    unalias stash
    unalias status
    unalias s
    unalias tag
  fi
}

# add an "alert" alias for long running commands. use like:  sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

wine32() {
  INEPREFIX=~/.wine WINEARCH=win32 wine "$@"
}
