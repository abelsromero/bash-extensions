#!/usr/bin/env bash

set -euo pipefail

readonly mail=$(cat ~/.gitconfig | grep '[^#].*email')

if [[ "$mail" == *gmail.com ]]; then
  new_mail=""
else
  new_mail=""
fi

[ -n "$new_mail" ] && git config --global user.email "$new_mail" && echo "set: $new_mail"
