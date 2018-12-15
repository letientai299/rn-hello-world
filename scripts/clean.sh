#!/bin/bash

# Backup current dir
CUR_DIR=$PWD

# Detect script dir and go up one level to be at root project dir
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load common scripts
# shellcheck source=./common.sh
. "$SCRIPT_DIR/common.sh"
ROOT_DIR="$SCRIPT_DIR/.."

# Go to project root dir
cd $SCRIPT_DIR/..

warn "This will clean up the workspace, remove node_modules, build folders,
etc. Redownload them again may take time."
read -p "Are you sure? [y/n]  " -n 3 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "You choose $REPLY"
  # handle exits from shell or function but don't exit interactive shell
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

info "Remove android build dir"
cd $ROOT_DIR/android; ./gradlew clean; cd $ROOT_DIR

info "Remove ios build dir"
cd $ROOT_DIR/ios; rm -rf ./build/; cd $ROOT_DIR

info "Remove node_modules"
rm -rf node_modules

info "Done clean up. You may want to run setup.sh again."

# Go back to the original folder
cd "$CUR_DIR" || exit 1

