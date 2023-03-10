#!/bin/bash

__MY_TOOLS_PATH="${HOME}/.${USER}_ext"

## FIXES
# export LANG=en_US.utf8
# export LC_COLLATE="C"

## ALIAS
alias ls='ls --color=auto'
alias ll="ls -lah"
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'

alias code="codium"

du_sort() {
  # -i: hide errors
  local -r base="(du -h --max-depth=1 | sort -h)"
  local suffix
  [ "$#" -eq 1 ] && [[ "$1" == "-i" ]] && suffix="2>/dev/null" || suffix=""
  eval "$base $suffix"
}

[ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ] && \
  source "${__MY_TOOLS_PATH}/.zshrc" && \
  for f in $(find "${__MY_TOOLS_PATH}/shared" "${__MY_TOOLS_PATH}/modules" -type f); do source $f; done

