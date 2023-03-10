#!/bin/bash

alias clear_ds_store='find . -name '.DS_Store' -type f -delete.'
alias brew_upgrade_all='brew update && brew outdated && brew upgrade'
alias brew_deps="brew deps --tree --installed"

idea_diff () {
  open -na "IntelliJ IDEA.app" --args "diff" "$S1" "$S2"
}
