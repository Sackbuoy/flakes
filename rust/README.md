# Flake for rust dev

## Direnv
```
#!/usr/bin/env bash

nix flake new -t github:nix-community/nix-direnv .


cat > flake.nix << EOF
{
  description = "A simple Rust project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        rustToolchain = pkgs.rust-bin.stable.latest.default;
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            rustToolchain
            pkgs.rust-analyzer
            pkgs.pkg-config
            pkgs.openssl.dev
          ];
        };
      }
    );
}
```
