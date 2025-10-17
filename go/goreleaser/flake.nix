{
  description = "Custom Goreleaser version flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # Function to build a specific Go version
    buildGoreleaser = {
      version,
      sha256,
    }:
      pkgs.stdenv.mkDerivation {
        pname = "goreleaser";
        inherit version;

        src = pkgs.fetchurl {
          url = "https://github.com/goreleaser/goreleaser/releases/download/v${version}/goreleaser_Linux_x86_64.tar.gz";
          inherit sha256;
        };

        sourceRoot = ".";

        installPhase = ''
          mkdir -p $out/bin
          cp ./goreleaser $out/bin/
        '';

        # Skip unnecessary phases
        dontConfigure = true;
        dontBuild = true;

        meta = with pkgs.lib; {
          description = "goreleaser";
          homepage = "https://goreleaser.com/";
          license = licenses.bsd3;
          platforms = platforms.linux;
        };
      };

    # Predefined Go versions

    v_2_10_2 = buildGoreleaser {
      version = "2.10.2";
      sha256 = "dVfRA9Zu+tLMPGHEWLbslI2MsMSfc0+7lAden3dAdt8=";
    };

    latest = buildGoreleaser {
      version = "2.10.2";
      sha256 = "dVfRA9Zu+tLMPGHEWLbslI2MsMSfc0+7lAden3dAdt8=";
    };

    # Function to generate a devShell for a specific version
    mkShell = goreleaserPkg:
      pkgs.mkShell {
        buildInputs = [goreleaserPkg];

        shellHook = ''
          goreleaser --version
        '';
      };
  in {
    lib = {
      getVersion = filePath: let
        fileContent = builtins.readFile filePath;
        versionMatch = builtins.match ".*GORELEASER_VERSION: \"v([^\n]*)\".*" fileContent;
        version =
          if versionMatch == null
          then "latest"
          else (builtins.head versionMatch);
        versionedPackage =
          if version == "latest"
          then version
          else ("v-" + builtins.replaceStrings ["."] ["-"] version);
      in
        versionedPackage;
    };

    packages.${system} = {
      # v2.10.x
      v-2-10-2 = v_2_10_2;

      # Default package
      latest = latest;
      default = latest;
    };

    devShells.${system} = {
      # v2.10.x
      v-2-10-2 = mkShell v_2_10_2;

      # Default shell
      latest = mkShell latest;
      default = mkShell latest;
    };
  };
}
