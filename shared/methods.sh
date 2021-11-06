#!/bin/bash

## Utils to be used by other scripts

_swap_files() {
  cp $1 $swap_file && mv $2 $1 && mv $swap_file $2
}
