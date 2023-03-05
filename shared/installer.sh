#!/bin/bash

# Methods to handle installing/removing scripts from custom path dir 'scripts'

__install_to() {
  local -r program="$1"
  local -r target="$2"
  echo "program: $1"
  echo "target: $2"
  cp "$program" "$2"
  chmod u+x "$2/$program"
}

install_script() {
  [ "$#" -ne 1 ] && echo "Expected 1 arg: script file" && return 1
  __install_to "$1" "$__MY_TOOLS_PATH/scripts/"
}

uninstall_script() {
  [ "$#" -ne 1 ] && echo "Expected 1 arg: script file" && return 1
  rm "$__MY_TOOLS_PATH/scripts/$1"
}

install_to_path() {
  [ "$#" -ne 1 ] && echo "Expected 1 arg: binary file" && return 1
  __install_to "$1" "$HOME/.local/bin/"
}

uninstall_from_path() {
  [ "$#" -ne 1 ] && echo "Expected 1 arg: binary file" && return 1
  rm "$HOME/.local/bin/$1"
}

__uninstall_completion() {
  local files
  if [ "$#" -eq 2 ]; then
    files="$(find "$1" -name "$2" -exec basename {} \;)"
  else
    files="$(find "$1" -exec basename {} \;)"
  fi
  COMPREPLY=($(compgen -W "$files" -- "${COMP_WORDS[1]}"))
}

_uninstall_scripts_completion() {
  __uninstall_completion "$__MY_TOOLS_PATH/scripts/" "*.sh"
}

_uninstall_from_path_completion() {
  __uninstall_completion "$HOME/.local/bin/"
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

complete -F _uninstall_scripts_completion uninstall_script
complete -F _uninstall_from_path_completion uninstall_from_path
