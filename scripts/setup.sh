#!/bin/bash

# Backup current dir
CUR_DIR=$PWD

# Detect script dir and go up one level to be at root project dir
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

# Load common scripts
. $SCRIPT_DIR/common.sh

# Go to project root dir
cd $SCRIPT_DIR/..

if ! command -v yarn > /dev/null 2>&1; then
  error "yarn not found! Please install from https://yarnpkg.com/"
  exit
fi

info "Install nodejs modules"
yarn

if ! command -v gem > /dev/null 2>&1; then
  warn "gem not found! It's required for installing some tools.\n"\
    "Please consider install Ruby and gem"
  exit
else
  info "Install bundler"
  gem install bundler
  info "Install gems"
  bundle install
fi


if [[ "$OSTYPE" == "darwin"* ]]; then
  if ! command -v pod > /dev/null 2>&1; then
    error "pod not found. Please check Gemfile and install pod via bundle"
  else
    # Use SCRIPT_DIR to avoid any error happen during pod install
    info "Install cocoapods for building iOS app"
    cd $SCRIPT_DIR/../ios
    rm -rf Pods
    pod setup
    pod install
    cd $SCRIPT_DIR/..
  fi
fi

# if the .env file is not existed
if [ ! -f $ROOT_DIR/.env ]; then
  info "Init local .env file"
  cp env.template .env
  info "Please edit the .env file base on your local development setup. Below are
  the current content"
  cat .env
else
  info "Found local .env file with following contents"
  cat .env
fi

# Go back to the original folder
cd $CUR_DIR
