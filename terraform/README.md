# Terraform project dev env
I use https://github.com/stackbuilders/nixpkgs-terraform to pull in any version
of terraform i want

## Usage with direnv:
Script to initialize the dev flake and activate direnv:
```
#!/usr/bin/env bash

nix flake new -t github:nix-community/nix-direnv .


cat > flake.nix << EOF
{
  description = "Terraform development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-terraform,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [
          "terraform"
        ];
    };
    terraformVersion = "1.11.2";
    terraform = nixpkgs-terraform.packages.\${system}.\${terraformVersion};
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [
        terraform
        pkgs.tflint
      ];
    };
  };
}
EOF

echo "use flake" >> .envrc && direnv allow
```

