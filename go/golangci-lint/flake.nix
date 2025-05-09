{
  description = "Custom Golangci-lint version flake";

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
    buildGolangCi = {
      version,
      sha256,
    }:
      pkgs.stdenv.mkDerivation {
        pname = "golangci-lint";
        inherit version;

        src = pkgs.fetchurl {
          url = "https://github.com/golangci/golangci-lint/releases/download/v${version}/golangci-lint-${version}-linux-amd64.tar.gz";
          inherit sha256;
        };

        sourceRoot = ".";

        installPhase = ''
          mkdir -p $out/bin
          cp ./golangci-lint-${version}-linux-amd64/golangci-lint $out/bin/
        '';

        # Skip unnecessary phases
        dontConfigure = true;
        dontBuild = true;

        meta = with pkgs.lib; {
          description = "Golangci-lint";
          homepage = "https://golangci-lint.run/";
          license = licenses.bsd3;
          platforms = platforms.linux;
        };
      };

    # Predefined Go versions

    v_1_54_0 = buildGolangCi {
      version = "1.54.0";
      sha256 = "ppTxnb+rPqTTlWyxBdLnTB3EnLTAbs6QOjxTS86Gs9w=";
    };

    v_1_54_1 = buildGolangCi {
      version = "1.54.1";
      sha256 = "14ljxg3qmzhw4iv6zmqk914yckcw5ymr1dfrayd0sxs3bp61j60c";
    };

    v_1_54_2 = buildGolangCi {
      version = "1.54.2";
      sha256 = "1csjfi6bvykkk2lpjn2iwssh48md19ksz37k8wyq7ziy4l2wmj8p";
    };

    v_1_55_0 = buildGolangCi {
      version = "1.55.0";
      sha256 = "0yjkl08c1jkz7pvg8k84ln8sq55vrnvqm4zq4zx01s641admfy92";
    };

    v_1_60_1 = buildGolangCi {
      version = "1.60.1";
      sha256 = "1nn90piag2sb7hby1sz78z20q9s552ixza75r7c48ff8brkh7a06";
    };

    v_1_60_2 = buildGolangCi {
      version = "1.60.2";
      sha256 = "096iabivn8j4l0hd7zlxdqw9jy7q5sq653k8w26si6jix0nyjyv0";
    };

    v_1_60_3 = buildGolangCi {
      version = "1.60.3";
      sha256 = "1vq6p2yh61829qq5l3z8ikzlgwal3r3jm1blv0g407w74a0syds0";
    };

    v_1_61_0 = buildGolangCi {
      version = "1.61.0";
      sha256 = "04a1lp1m1iccbq5y7wyj3fh69s30s1j87hy8blfs5nbrjgwhmjvp";
    };

    v_1_64_2 = buildGolangCi {
      version = "1.64.2";
      sha256 = "qJPnySEfcKDLjFEhq4DVsIkQnCOva8KSOCC6i0I2UHI=";
    };

    v_1_64_5 = buildGolangCi {
      version = "1.64.5";
      sha256 = "5r05mgR5xf2Ebc+fOZDSBEi08NHlAn2CNI6rn4D3rHE=";
    };

    v_1_64_6 = buildGolangCi {
      version = "1.64.6";
      sha256 = "138l2n5w9z6pvhxnz2mc6r1hq66wfkxl01cgysj3nyybpan91qki";
    };

    v_1_64_7 = buildGolangCi {
      version = "1.64.7";
      sha256 = "2tpAleq1P4aPkxhA8EuZy0vmVORfUNTTsoMtya077eg=";
    };

    v_1_64_8 = buildGolangCi {
      version = "1.64.8";
      sha256 = "ticGh6+xQ9AZ84fHkc0qbxyzg76bMSTSQcoRvTzi5U4=";
    };

    v_2_0_0 = buildGolangCi {
      version = "2.0.0";
      sha256 = "UOvAGYhCngfSmlVkF6rx7030QafohkVhfPXbMDPA43s=";
    };

    v_2_0_1 = buildGolangCi {
      version = "2.0.1";
      sha256 = "m/w414aYNEQ8A+9fmXfnggfMo4aonCrQ7NK9hczavik=";
    };

    v_2_0_2 = buildGolangCi {
      version = "2.0.2";
      sha256 = "icyKeBDcY7mjeQDaA+N8NgHK9G1CJl13Tg8aXYg9U+I=";
    };

    latest = buildGolangCi {
      version = "2.0.2";
      sha256 = "icyKeBDcY7mjeQDaA+N8NgHK9G1CJl13Tg8aXYg9U+I=";
    };

    # Function to generate a devShell for a specific version
    mkShell = golangciPkg:
      pkgs.mkShell {
        buildInputs = [golangciPkg];

        shellHook = ''
          golangci-lint version
        '';
      };
  in {
    lib = {
      getVersion = filePath: let
        fileContent = builtins.readFile filePath;
        versionMatch = builtins.match ".*GOLANGCI_VERSION: \"v([^\n]*)\".*" fileContent;
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
      # v1.54.x
      v-1-54-0 = v_1_54_0;
      v-1-54-1 = v_1_54_1;
      v-1-54-2 = v_1_54_2;

      # v1.55.x
      v-1-55-0 = v_1_55_0;

      # v1.60.x
      v-1-60-1 = v_1_60_1;
      v-1-60-2 = v_1_60_2;
      v-1-60-3 = v_1_60_3;

      # v1.61.x
      v-1-61-0 = v_1_61_0;

      # v1.64.x
      v-1-64-2 = v_1_64_2;
      v-1-64-5 = v_1_64_5;
      v-1-64-6 = v_1_64_6;
      v-1-64-7 = v_1_64_7;
      v-1-64-8 = v_1_64_8;

      # v2.0.x
      v-2-0-0 = v_2_0_0;
      v-2-0-1 = v_2_0_1;
      v-2-0-2 = v_2_0_2;
      # Default package
      latest = latest;
      default = latest;
    };

    devShells.${system} = {
      # v1.54.x
      v-1-54-0 = mkShell v_1_54_0;
      v-1-54-1 = mkShell v_1_54_1;
      v-1-54-2 = mkShell v_1_54_2;

      # v1.55.x
      v-1-55-0 = mkShell v_1_55_0;

      # v1.60.x
      v-1-60-1 = mkShell v_1_60_1;
      v-1-60-2 = mkShell v_1_60_2;
      v-1-60-3 = mkShell v_1_60_3;

      # v1.61.x
      v-1-61-0 = v_1_61_0;

      # v1.64.x
      v-1-64-2 = mkShell v_1_64_2;
      v-1-64-5 = mkShell v_1_64_5;
      v-1-64-6 = mkShell v_1_64_6;
      v-1-64-7 = mkShell v_1_64_7;

      # v2.0.x
      v-2-0-0 = mkShell v_2_0_0;
      v-2-0-1 = mkShell v_2_0_1;
      v-2-0-2 = mkShell v_2_0_2;
      # Default shell
      latest = mkShell latest;
      default = mkShell latest;
    };
  };
}
