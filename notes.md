# Sceneery - Android Screensaver Project

## Project Overview

Sceneery is an Android screensaver that uses DreamService to activate but displays a React Native application UI. This allows for fullstack development using React/JavaScript while maintaining native Android screensaver functionality.

## Development Approach: Hybrid Architecture ✅

We've decided on a **Hybrid Approach**:

- Minimal native Android wrapper (DreamService) - small amount of Java/Kotlin code (~50-100 lines)
- React Native UI runs inside the DreamService wrapper
- Best of both worlds: native screensaver integration + React development comfort

### Why Hybrid?

- DreamService is a native Android component that must extend the `DreamService` class
- Cannot directly launch a React Native app as a screensaver
- Hybrid allows React Native view to be hosted inside the native wrapper
- Maintains proper screensaver behavior

## Development Environment

### IDE Choice

- **VSCode** (not Android Studio)
- Will use Android SDK command-line tools only

### Key Dependencies Needed

- Android SDK (command-line tools)
- React Native CLI or Expo
- Gradle (for building)
- ADB (for device/emulator connection)
- Node.js, Yarn, Watchman
- JDK 17

## Current Status

### Completed

- [x] Decided on hybrid approach
- [x] Initial flake.nix created
- [x] Updated flake.nix with proper Android SDK setup using `androidenv`
- [x] Removed Android Studio from dependencies
- [x] Configured Android SDK with API 34 and Build Tools 34.0.0

### TODO

- [ ] Add React Native CLI to dependencies

## Technical Notes

### Native Code Requirements

- Will need ~50-100 lines of Kotlin/Java for DreamService wrapper (unavoidable but minimal)
- DreamService must extend Android's DreamService class
- Native wrapper will host React Native view

### Flake.nix Configuration

1. ✅ Removed `android-studio` from packages (using VSCode instead)
2. ✅ Fixed Android SDK setup - now using `androidenv.composeAndroidPackages`
3. ✅ Android SDK configured with API 34 (Android 14) and Build Tools 34.0.0
4. ✅ ANDROID_HOME now points to Nix-managed SDK
5. ⏳ Still need to add React Native CLI  


### Android SDK Details

- **Platform Version**: API 34 (Android 14)
- **Build Tools**: 34.0.0
- **Emulator**: Disabled (testing on real device)
- **NDK**: Disabled (not needed for React Native)
- **Managed by**: Nix `androidenv` (fully declarative and reproducible)

## Questions for Future Sessions

- Project structure recommendations?
- Minimal native code examples?
- React Native + DreamService integration details?
- Testing strategy for screensaver functionality?

## Resources & References

- Android DreamService: https://developer.android.com/reference/android/service/dreams/DreamService
- React Native: https://reactnative.dev/
- Nix androidenv: https://nixos.org/manual/nixpkgs/stable/#android

---

_Last Updated: 2026-02-21_
