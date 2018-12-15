#!/bin/bash
# Do a fully clean build on working and generate release APK on local development
# machine and CI.
# See https://stackoverflow.com/a/36961021/3869533

# Backup current dir
CUR_DIR=$PWD

# Detect script dir and go up one level to be at root project dir
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load common scripts
# shellcheck source=./common.sh
. "$SCRIPT_DIR/common.sh" || exit 1

# Go to root project dir to start the build
cd "$SCRIPT_DIR/.." || exit 1

missingReleaseConfig=0

echo "$SOMETHING"

info "Make sure that .env.release is available"
if [[ ! -f .env.release ]]; then
  error ".env.release not found, please prepare it."
  exit 1
fi

info "Make sure that required variable is set"

if [[ -z ${RELEASE_STORE_FILE} ]]; then
  missingReleaseConfig=1
  error "RELEASE_STORE_FILE env is not set"
fi

if [[ -z ${RELEASE_STORE_PASSWORD} ]]; then
  missingReleaseConfig=1
  error "RELEASE_STORE_PASSWORD env is not set"
fi

if [[ -z ${RELEASE_KEY_PASSWORD} ]]; then
  missingReleaseConfig=1
  error "RELEASE_KEY_PASSWORD env is not set"
fi

if [[ -z ${RELEASE_KEY_ALIAS} ]]; then
  missingReleaseConfig=1
  error "RELEASE_KEY_ALIAS env is not set"
fi

if [[ $missingReleaseConfig -eq 1 ]]; then
  exit 1
fi

info "Make sure that node_modules is ready"
yarn

info "Clean old gradle build"
cd android/ || exit 1
./gradlew clean

info "Bundle react-native offline package"

ENFILE="../.env.release" ./gradlew assembleRelease

yarn react-native bundle --dev false --platform android \
  --entry-file index.js \
  --bundle-output android/app/build/intermediates/merged_assets/release/mergeReleaseAssets/out/index.android.bundle \
  --assets-dest android/app/build/intermediates/res/merged/release

# we need to "double" build it and geenrate the bundle manually. I just don't
# know why. But this is the only way I know to make have the js bunlded within
# the APK.
ENFILE="../.env.release" ./gradlew assembleRelease

# Go back to the original folder
cd "$CUR_DIR" || exit 1
