#!/bin/bash

# Methods to handle installing/removing scripts from custom path dir 'scripts'

install_script() {
  [ "$#" -ne 1 ] && echo "Expected arg: script name" && return 1
  cp "$1" "$__MY_TOOLS_PATH/scripts"
  chmod 700 "$__MY_TOOLS_PATH/scripts/$1"
}

uninstall_scripts() {
  [ "$#" -ne 1 ] && echo "Expected arg: script name" && return 1
  rm "$__MY_TOOLS_PATH/scripts/$1"
}

_uninstall_scripts_completion() {
  echo "$(find "$__MY_TOOLS_PATH/scripts/" -name '*.sh' -exec basename {} \;)"
  COMPREPLY=($(compgen -W "$scs" -- "${COMP_WORDS[1]}"))
}

if ! typeset -f foo > /dev/null; then
  # Fix: for reasons compinit methods are not available at this point, so we copy 'complete' defintion
  complete () {
    emulate -L zsh
    local args void cmd print remove
    args=("$@")
    zparseopts -D -a void o: A: G: W: C: F: P: S: X: a b c d e f g j k u v p=print r=remove
    if [[ -n $print ]]
    then
      printf 'complete %2$s %1$s\n' "${(@kv)_comps[(R)_bash*]#* }"
    elif [[ -n $remove ]]
    then
      for cmd
      do
        unset "_comps[$cmd]"
      done
    else
      compdef _bash_complete\ ${(j. .)${(q)args[1,-1-$#]}} "$@"
    fi
  }
fi

complete -F _uninstall_scripts_completion uninstall_scripts
