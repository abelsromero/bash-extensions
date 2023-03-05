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
alias du_sort="du -h --max-depth=1 | sort -h"

[ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ] && \
  source "${__MY_TOOLS_PATH}/.zshrc" && \
  for f in $(find "${__MY_TOOLS_PATH}/shared" "${__MY_TOOLS_PATH}/plugins" -type f); do source $f; done

