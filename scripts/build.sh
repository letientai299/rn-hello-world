#!/bin/bash

# Source the common.sh script
# shellcheck source=./common.sh
. "$(git rev-parse --show-toplevel || echo ".")/scripts/common.sh"

cd "$PROJECT_DIR" || exit 1

build_android_debug() {
  info "Building android debug package ..."
  ./scripts/build-android-debug.sh

  info "Done. Here is target information"
  ls -lah -d ./android/app/build/outputs/apk/debug/*

  info "Done building android debug package"
}

build_android_release() {
  info "Build android release package ..."
  if ./scripts/build-android-release.sh; then
    info "Done. Here is target information"
    ls -lah -d ./android/app/build/outputs/apk/release/*
    info "Done building android debug package"
    exit
  fi

  error "Fail to build Android release package"
  exit 1
}

show_help() {
  cat <<EOF
  Build deployable artifacts for this project.

  Usage:
  ./build.sh <target>

  Known targets are:

  android.debug      Build Andorid debug pacakge
  android.release    Build Android release package
  android            Alias for android.debug

EOF
}

while :; do
  case $1 in
    -h | --help)
      show_help # Display a usage synopsis.
      exit
      ;;
    android | android.debug)
      build_android_debug
      exit
      ;;
    android.release)
      build_android_release
      exit
      ;;
    *) # Default case: No more options.
      show_help
      break ;;
  esac

  shift
done

cd "$WORKING_DIR" || exit 1
