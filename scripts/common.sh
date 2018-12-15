#!/bin/bash

if [ -z ${TERM} ]; then
  TERM="ansi"
fi

# Enhanced echo with green text and a nice box
info() {
  color=$(tput setaf 2)
  reset=$(tput sgr0)
  echo "${color}--------------------------------------------------------------------------------${reset}"
  echo "${color}[INFO] $*${reset}"
  echo "${color}--------------------------------------------------------------------------------${reset}"
}

warn() {
  color=$(tput setaf 3)
  reset=$(tput sgr0)
  echo "${color}--------------------------------------------------------------------------------${reset}"
  echo "${color}[WARN] $*${reset}"
  echo "${color}--------------------------------------------------------------------------------${reset}"
}

error() {
  color=$(tput setaf 1)
  reset=$(tput sgr0)
  echo "${color}--------------------------------------------------------------------------------${reset}"
  echo "${color}[ERROR] $*${reset}"
  echo "${color}--------------------------------------------------------------------------------${reset}"
}



# Make sure that the script that source this script will exit on Ctrl-C
trap "exit" INT
