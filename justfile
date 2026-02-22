[doc('Display the list of recipes')]
[private]
default:
    @just --list

[doc('Start Metro bundler for React Native development')]
dev:
    yarn start

[doc('Build Android APK (debug)')]
build:
    cd android && ./gradlew assembleDebug

[doc('Build Android APK (release)')]
build-release:
    cd android && ./gradlew assembleRelease

[doc('Install app to connected device/emulator')]
install:
    cd android && ./gradlew installDebug

[doc('View Android logcat logs')]
logs:
    adb logcat | grep -E "ReactNative|Sceneery"

[doc('Clean build artifacts')]
clean:
    cd android && ./gradlew clean
    rm -rf node_modules

[doc('Install dependencies')]
deps:
    yarn install

[doc('Run on Android device')]
android:
    yarn android

[doc('Format code')]
fmt:
    alejandra flake.nix
    yamlfmt notes.md
