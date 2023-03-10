#!/bin/bash

sdk_ls() {
  cat <(sdk ls "$1")
}