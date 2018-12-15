# React Native Hello World

This is an extended version of `react-native init` that come with fully
configured CI/CD.

It's pretty much build on the knowledge of my other 2 similar projects, which
are for a single platform. If you're interesting in building native application
(not React Native), you might want to check them out:

- [Android Hello World](https://github.com/letientai299/android-hello-world/)
- [iOS Hello World](https://github.com/letientai299/ios-hello-world)

## Prerequisites

- [Yarn](https://yarnpkg.com/en/) for Nodejs package management. NPM is fine, but
  we don't want to be have conflict dependencies resolution between the 2,
  hence, we just pick Yarn and go with it.

- [Android SDK and Studio](https://developer.android.com/studio/) for building
  apk and troubleshoot Android building issues. Please also make sure that `adb`
  is available in PATH.

- [Xcode 10+](https://developer.apple.com/xcode/) for build iOS and troubleshoot
  iOS build issues.

## Run the app locally

- Clone the repo and get into the folder
- Run the setup script.

  ```sh
  make setup
  ```

  Or, if you don't have `make`

  ```
  ./scripts/setup.sh
  ```

- Run the app on android (make sure to have at least one device or emulator
  connected, check with `adb devices`)

  ```sh
  yarn react-native run-android
  ```

- Run the app on iOS simulator:

  ```sh
  yarn react-native run-ios
  ```

## Build debug packge

Sometime it's handy to share a prebuilt package that doesn't depend on js The
step to do this is not easy, hence, some script are prepared for you.

### Build debug apk for Android

Run

```sh
make build.android.debug
```

The APK will be available at `./android/app/build/outputs/apk/debug/`

**Note**: when upgrading Android SDK version, or React Native version, we might
need to update the script, as the js bundle location may change.

### Build debug ipa for iOS

> TODO build debug ipa for iOS

## Build release package

### Release Android

First, besure to prepare an `.env.release` file that set production value for
the variable defined in `.env.template`

Then, generate a `release.keystore` following [this
guide](https://github.com/letientai299/android-hello-world/#sign-the-app), put
it inside project folder and run following command

```sh
RELEASE_STORE_FILE="\$PWD/release.keystore" \
 RELEASE_STORE_PASSWORD="..." \
 RELEASE_KEY_ALIAS="..." \
 RELEASE_KEY_PASSWORD="..." \
 make build.android.release
```

Please filter the missing pieces in above command base on your release key
infomation. The filename can also be changed

If success, the command will report release package info, just like with debug
build:

```
--------------------------------------------------------------------------------
[INFO] Done. Here is target information
--------------------------------------------------------------------------------
-rw-r--r--  1 tai.le  1032302077   9.5M Dec 14 04:15 ./android/app/build/outputs/apk/release/app-release.apk
-rw-r--r--  1 tai.le  1032302077   234B Dec 14 04:15 ./android/app/build/outputs/apk/release/output.json
```

## Fastlane

See the document for fastlance in `android/fastlance` or `iOS/fastlance`
folder, as there's many different between the 2 platforms. This section would
only discuss common things.

### First android release must be created manually

From [here](https://github.com/fastlane/fastlane/issues/10711), I've learned
that

> Supply will not publish apps but can release updates for published ones, you
> will need to manually release the first version then subsequent updates can be
> released via supply.

That means we will have to manual create crete our first release variants
(Internal track, closed track and Production). It took me a quite to understand
why `fastlance android beta` and `fastlane android deploy` run successfully
without upload anything to Play Console.

## What else?

If anything go wrong, you may want to reset your workspace and start over
with a clean build. There's a script will help you to do that.
Use `make clean`, also check `./scripts/clean.sh` to learn what it does.
