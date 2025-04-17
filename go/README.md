# Flakes for developing on a go project
I wanted to be able to pull any version of these tools i wanted so i made my own
flakes

## Using with direnv
First, set up https://github.com/nix-community/nix-direnv
I wrote this script to create the flake for the go project, and set it up with
direnv - just run this in the directory of the go project you want these tools
in. It will check the go.mod for a toolchain version, and a GH action workflow
file for the golangci-lint version. Change these to the paths of your go.mod and
workflow file - if no version is found for golangci-lint it defaults to "latest"
```
#!/usr/bin/env bash

nix flake new -t github:nix-community/nix-direnv .


cat > flake.nix << EOF
{
  description = "A basic go dev flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    go-flake.url = "github:Sackbuoy/flakes?dir=go/go";
    golangci-lint-flake.url = "github:Sackbuoy/flakes?dir=go/golangci-lint";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    go-flake,
    golangci-lint-flake,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.\${system};

        golangciPackage = golangci-lint-flake.lib.getVersion ./.github/workflows/pr.yaml;
        goPackage = go-flake.lib.getVersion ./go.mod;
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.bashInteractive
          ];
          buildInputs = [
            golangci-lint-flake.packages.\${system}.\${golangciPackage}
            go-flake.packages.\${system}.\${goPackage}
            pkgs.delve
            pkgs.bashInteractive
            pkgs.gopls
            pkgs.gotools
          ];

          CGO_CFLAGS = "-O2";

          env = {
            GO111MODULE = "on";
          };

          shellHook = ''
            echo "Golang development environment with:"
            echo "Go: \${goPackage}"
            echo "Golangci-lint \${golangciPackage}"
          '';
        };
      }
    );
}
EOF

echo "use flake" >> .envrc && direnv allow
```
