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

if [[ "$SHELL" = "/bin/bash" ]]; then
  source ${__MY_TOOLS_PATH}/.bashrc
fi

if [[ "$SHELL" = "/bin/zsh" ]]; then
  source ${__MY_TOOLS_PATH}/.zshrc
fi

## not persisted extensions (local_env.sh is in .gitignore)
if [[ -f "${__MY_TOOLS_PATH}/local_env.sh" ]]; then
  source ${__MY_TOOLS_PATH}/local_env.sh
fi

## Plugins: place *.sh files to be sources in '/plugins' dir
[[ -d "${__MY_TOOLS_PATH}/plugins" ]] && \
for f in $(ls ${__MY_TOOLS_PATH}/plugins/*.sh)
do
 source $f
done
