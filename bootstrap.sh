#!/bin/bash

__MY_TOOLS_PATH="${HOME}/.${USER}_ext"

## FIXES

# export LANG=en_US.utf8
# export LC_COLLATE="C"

## ALIAS

alias ls='ls --color=auto'
alias ll="ls -lah"
alias du_sort="du -h --max-depth=1 | sort -h"

## EXTENSIONS

if [[ "$SHELL" = "/usr/bin/bash" ]]; then
  source ${__MY_TOOLS_PATH}/.bashrc
fi

if [[ "$SHELL" = "/usr/bin/zsh" ]]; then
  source ${__MY_TOOLS_PATH}/.zshrc
fi

## not persisted extensions (local_env.sh is in .gitignore)
if [[ -f "${__MY_TOOLS_PATH}/local_env.sh" ]]; then
  source ${__MY_TOOLS_PATH}/local_env.sh
fi
