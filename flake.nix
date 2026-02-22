{
  inputs = {
    systems.url = "github:nix-systems/default-linux";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      ...
    }:
    flake-parts.lib.mkFlake
      {
        inherit inputs;
      }
      (
        {
          withSystem,
          flake-parts-lib,
          inputs,
          self,
          ...
        }:
        {
          systems = import inputs.systems;
          perSystem =
            { pkgs, ... }:
            let
              androidComposition = pkgs.androidenv.composeAndroidPackages {
                platformVersions = [ "34" ];
                buildToolsVersions = [ "34.0.0" ];
                includeEmulator = false;
                includeNDK = false;
                includeSources = false;
                includeSystemImages = false;
              };
              androidSdk = androidComposition.androidsdk;
            in
            {
              devShells.default = pkgs.mkShellNoCC {
                name = "react-native-dev";

                packages = [
                  # Packages from nixpkgs, for Nix, Flakes or local tools.

                  pkgs.pre-commit # Git Hooks
                  pkgs.just # Command Runner
                  pkgs.process-compose # Process Orchestration

                  # React Native Development
                  pkgs.nodejs_20
                  pkgs.yarn
                  pkgs.watchman
                  pkgs.jdk17

                  # Android Development
                  pkgs.gradle
                  androidSdk

                  # Tools / Formaters Linters etc
                  pkgs.alejandra # Nix
                  pkgs.yamlfmt # YAML
                  pkgs.keep-sorted # General Sorting tool
                ];

                shellHook = ''
                  export NIXPKGS_ACCEPT_ANDROID_SDK_LICENSE=1
                  export ANDROID_HOME="${androidSdk}/libexec/android-sdk"                            
                  export PATH=$PATH:$ANDROID_HOME/platform-tools                                     
                  export PATH=$PATH:$ANDROID_HOME/build-tools/34.0.0                                 
                  export JAVA_HOME=${pkgs.jdk17}                                                     
                '';
              };
            };
        }
      );
}
