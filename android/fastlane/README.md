# fastlane documentation

## Available Actions

### android test

```
fastlane android test
```

Runs all the tests

### android beta

```
fastlane android beta
```

Submit a new Beta Build to Crashlytics Beta

### android deploy

```
fastlane android deploy
```

Deploy a new version to the Google Play

## Manage secret key

Following [fastlane doc](https://docs.fastlane.tools/actions/supply), we have
generate a json file that contains Play Store credential for fastlane to upload
its artifacts.

To secure our password, while be able to store that json file in this repo, the
json is encrypted via:

```sh
$ openssl aes-256-cbc -a -salt -in play-fastlane.json -out play-fastlane.json.enc
```

And on CI, we will decrypt it via

```sh
$ openssl aes-256-cbc -d -a -in play-fastlane.json.enc -out play-fastlane.json -pass pass:$PASSWORD
```

`$PASSWORD` is the env variable that contains password on CI. Note the syntax to
submitt password into openssl via command line `-pass pass:<real pass>`. See
[here](https://superuser.com/a/724987/549921)
