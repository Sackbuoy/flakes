{
  description = "Custom Go version flake";

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
    buildGo = {
      version,
      sha256,
    }:
      pkgs.stdenv.mkDerivation {
        pname = "go";
        inherit version;

        src = pkgs.fetchurl {
          url = "https://go.dev/dl/go${version}.linux-amd64.tar.gz";
          inherit sha256;
        };

        sourceRoot = ".";

        nativeBuildInputs = [pkgs.autoPatchelfHook];
        buildInputs = [
          pkgs.stdenv.cc.cc.lib
          pkgs.glibc
          pkgs.zlib
          pkgs.ncurses
          pkgs.util-linux
          pkgs.libtiff
        ];

        installPhase = ''
          mkdir -p $out
          cp -r go/* $out/
        '';

        # Skip unnecessary phases
        dontConfigure = true;
        dontBuild = true;

        meta = with pkgs.lib; {
          description = "Go programming language";
          homepage = "https://go.dev/";
          license = licenses.bsd3;
          platforms = platforms.linux;
        };
      };

    # Predefined Go versions
    # go 1.20.x
    go_1_20_0 = buildGo {
      version = "1.20";
      sha256 = "5a9ebcc65c1cce56e0d2dc616aff4c4cedcfbda8cc6f0288cc08cda3b18dcbf1";
    };

    go_1_20_1 = buildGo {
      version = "1.20.1";
      sha256 = "000a5b1fca4f75895f78befeb2eecf10bfff3c428597f3f1e69133b63b911b02";
    };

    go_1_20_2 = buildGo {
      version = "1.20.2";
      sha256 = "4eaea32f59cde4dc635fbc42161031d13e1c780b87097f4b4234cfce671f1768";
    };

    go_1_20_3 = buildGo {
      version = "1.20.3";
      sha256 = "979694c2c25c735755bf26f4f45e19e64e4811d661dd07b8c010f7a8e18adfca";
    };

    go_1_20_4 = buildGo {
      version = "1.20.4";
      sha256 = "698ef3243972a51ddb4028e4a1ac63dc6d60821bf18e59a807e051fee0a385bd";
    };

    go_1_20_5 = buildGo {
      version = "1.20.5";
      sha256 = "d7ec48cde0d3d2be2c69203bc3e0a44de8660b9c09a6e85c4732a3f7dc442612";
    };

    go_1_20_6 = buildGo {
      version = "1.20.6";
      sha256 = "b945ae2bb5db01a0fb4786afde64e6fbab50b67f6fa0eb6cfa4924f16a7ff1eb";
    };

    go_1_20_7 = buildGo {
      version = "1.20.7";
      sha256 = "f0a87f1bcae91c4b69f8dc2bc6d7e6bfcd7524fceec130af525058c0c17b1b44";
    };

    go_1_20_8 = buildGo {
      version = "1.20.8";
      sha256 = "cc97c28d9c252fbf28f91950d830201aa403836cbed702a05932e63f7f0c7bc4";
    };

    go_1_20_9 = buildGo {
      version = "1.20.9";
      sha256 = "8921369701afa749b07232d2c34d514510c32dbfd79c65adb379451b5f0d7216";
    };

    go_1_20_10 = buildGo {
      version = "1.20.10";
      sha256 = "80d34f1fd74e382d86c2d6102e0e60d4318461a7c2f457ec1efc4042752d4248";
    };

    go_1_20_11 = buildGo {
      version = "1.20.11";
      sha256 = "ef79a11aa095a08772d2a69e4f152f897c4e96ee297b0dc20264b7dec2961abe";
    };

    go_1_20_12 = buildGo {
      version = "1.20.12";
      sha256 = "9c5d48c54dd8b0a3b2ef91b0f92a1190aa01f11d26e98033efa64c46a30bba7b";
    };

    go_1_20_13 = buildGo {
      version = "1.20.13";
      sha256 = "9a9d3dcae2b6a638b1f2e9bd4db08ffb39c10e55d9696914002742d90f0047b5";
    };

    go_1_20_14 = buildGo {
      version = "1.20.14";
      sha256 = "ff445e48af27f93f66bd949ae060d97991c83e11289009d311f25426258f9c44";
    };

    go_1_21_0 = buildGo {
      version = "1.21.0";
      sha256 = "d0398903a16ba2232b389fb31032ddf57cac34efda306a0eebac34f0965a0742";
    };

    go_1_21_1 = buildGo {
      version = "1.21.1";
      sha256 = "b3075ae1ce5dab85f89bc7905d1632de23ca196bd8336afd93fa97434cfa55ae";
    };

    go_1_21_2 = buildGo {
      version = "1.21.2";
      sha256 = "f5414a770e5e11c6e9674d4cd4dd1f4f630e176d1828d3427ea8ca4211eee90d";
    };

    go_1_21_3 = buildGo {
      version = "1.21.3";
      sha256 = "1241381b2843fae5a9707eec1f8fb2ef94d827990582c7c7c32f5bdfbfd420c8";
    };

    go_1_21_4 = buildGo {
      version = "1.21.4";
      sha256 = "73cac0215254d0c7d1241fa40837851f3b9a8a742d0b54714cbdfb3feaf8f0af";
    };

    go_1_21_5 = buildGo {
      version = "1.21.5";
      sha256 = "e2bc0b3e4b64111ec117295c088bde5f00eeed1567999ff77bc859d7df70078e";
    };

    go_1_21_6 = buildGo {
      version = "1.21.6";
      sha256 = "3f934f40ac360b9c01f616a9aa1796d227d8b0328bf64cb045c7b8c4ee9caea4";
    };

    go_1_21_7 = buildGo {
      version = "1.21.7";
      sha256 = "13b76a9b2a26823e53062fa841b07087d48ae2ef2936445dc34c4ae03293702c";
    };

    go_1_21_8 = buildGo {
      version = "1.21.8";
      sha256 = "538b3b143dc7f32b093c8ffe0e050c260b57fc9d57a12c4140a639a8dd2b4e4f";
    };

    go_1_21_9 = buildGo {
      version = "1.21.9";
      sha256 = "f76194c2dc607e0df4ed2e7b825b5847cb37e34fc70d780e2f6c7e805634a7ea";
    };

    go_1_21_10 = buildGo {
      version = "1.21.10";
      sha256 = "e330e5d977bf4f3bdc157bc46cf41afa5b13d66c914e12fd6b694ccda65fcf92";
    };

    go_1_21_11 = buildGo {
      version = "1.21.11";
      sha256 = "54a87a9325155b98c85bc04dc50298ddd682489eb47f486f2e6cb0707554abf0";
    };

    go_1_21_12 = buildGo {
      version = "1.21.12";
      sha256 = "121ab58632787e18ae0caa8ae285b581f9470d0f6b3defde9e1600e211f583c5";
    };

    go_1_21_13 = buildGo {
      version = "1.21.13";
      sha256 = "502fc16d5910562461e6a6631fb6377de2322aad7304bf2bcd23500ba9dab4a7";
    };

    go_1_22_0 = buildGo {
      version = "1.22.0";
      sha256 = "f6c8a87aa03b92c4b0bf3d558e28ea03006eb29db78917daec5cfb6ec1046265";
    };

    go_1_22_1 = buildGo {
      version = "1.22.1";
      sha256 = "aab8e15785c997ae20f9c88422ee35d962c4562212bb0f879d052a35c8307c7f";
    };

    go_1_22_2 = buildGo {
      version = "1.22.2";
      sha256 = "5901c52b7a78002aeff14a21f93e0f064f74ce1360fce51c6ee68cd471216a17";
    };

    go_1_22_3 = buildGo {
      version = "1.22.3";
      sha256 = "8920ea521bad8f6b7bc377b4824982e011c19af27df88a815e3586ea895f1b36";
    };

    go_1_22_4 = buildGo {
      version = "1.22.4";
      sha256 = "ba79d4526102575196273416239cca418a651e049c2b099f3159db85e7bade7d";
    };

    go_1_22_5 = buildGo {
      version = "1.22.5";
      sha256 = "904b924d435eaea086515bc63235b192ea441bd8c9b198c507e85009e6e4c7f0";
    };

    go_1_22_6 = buildGo {
      version = "1.22.6";
      sha256 = "999805bed7d9039ec3da1a53bfbcafc13e367da52aa823cb60b68ba22d44c616";
    };

    go_1_22_7 = buildGo {
      version = "1.22.7";
      sha256 = "fc5d49b7a5035f1f1b265c17aa86e9819e6dc9af8260ad61430ee7fbe27881bb";
    };

    go_1_22_8 = buildGo {
      version = "1.22.8";
      sha256 = "5f467d29fc67c7ae6468cb6ad5b047a274bae8180cac5e0b7ddbfeba3e47e18f";
    };

    go_1_22_9 = buildGo {
      version = "1.22.9";
      sha256 = "84a8f05b7b969d8acfcaf194ce9298ad5d3ddbfc7034930c280006b5c85a574c";
    };

    go_1_22_10 = buildGo {
      version = "1.22.10";
      sha256 = "736ce492a19d756a92719a6121226087ccd91b652ed5caec40ad6dbfb2252092";
    };

    go_1_22_11 = buildGo {
      version = "1.22.11";
      sha256 = "0fc88d966d33896384fbde56e9a8d80a305dc17a9f48f1832e061724b1719991";
    };

    go_1_22_12 = buildGo {
      version = "1.22.12";
      sha256 = "4fa4f869b0f7fc6bb1eb2660e74657fbf04cdd290b5aef905585c86051b34d43";
    };

    go_1_23_0 = buildGo {
      version = "1.23.0";
      sha256 = "905a297f19ead44780548933e0ff1a1b86e8327bb459e92f9c0012569f76f5e3";
    };

    go_1_23_1 = buildGo {
      version = "1.23.1";
      sha256 = "49bbb517cfa9eee677e1e7897f7cf9cfdbcf49e05f61984a2789136de359f9bd";
    };

    go_1_23_2 = buildGo {
      version = "1.23.2";
      sha256 = "542d3c1705f1c6a1c5a80d5dc62e2e45171af291e755d591c5e6531ef63b454e";
    };

    go_1_23_3 = buildGo {
      version = "1.23.3";
      sha256 = "a0afb9744c00648bafb1b90b4aba5bdb86f424f02f9275399ce0c20b93a2c3a8";
    };

    go_1_23_4 = buildGo {
      version = "1.23.4";
      sha256 = "6924efde5de86fe277676e929dc9917d466efa02fb934197bc2eba35d5680971";
    };

    go_1_23_5 = buildGo {
      version = "1.23.5";
      sha256 = "cbcad4a6482107c7c7926df1608106c189417163428200ce357695cc7e01d091";
    };

    go_1_23_6 = buildGo {
      version = "1.23.6";
      sha256 = "9379441ea310de000f33a4dc767bd966e72ab2826270e038e78b2c53c2e7802d";
    };

    go_1_23_7 = buildGo {
      version = "1.23.7";
      sha256 = "4741525e69841f2e22f9992af25df0c1112b07501f61f741c12c6389fcb119f3";
    };

    go_1_24_0 = buildGo {
      version = "1.24.0";
      sha256 = "dea9ca38a0b852a74e81c26134671af7c0fbe65d81b0dc1c5bfe22cf7d4c8858";
    };

    go_1_24_1 = buildGo {
      version = "1.24.1";
      sha256 = "cb2396bae64183cdccf81a9a6df0aea3bce9511fc21469fb89a0c00470088073";
    };

    latest = buildGo {
      version = "1.24.1";
      sha256 = "cb2396bae64183cdccf81a9a6df0aea3bce9511fc21469fb89a0c00470088073";
    };

    # Function to generate a devShell for a specific Go version
    mkGoShell = goPackage:
      pkgs.mkShell {
        buildInputs = [goPackage];

        shellHook = ''
          export GOROOT=${goPackage}
          export PATH=$GOROOT/bin:$PATH
          echo "Go $(go version) activated"
        '';
      };
  in {
    lib = {
      getVersion = filePath: let
        fileContent = builtins.readFile filePath;
        versionMatch = builtins.match ".*toolchain go([^\n]*).*" fileContent;
        version =
          if versionMatch == null
          then "latest"
          else (builtins.head versionMatch);
        versionedPackage =
          if version == "latest"
          then version
          else ("go-" + builtins.replaceStrings ["."] ["-"] version);
      in
        versionedPackage;
    };

    # Make the Go packages available
    packages.x86_64-linux = {
      # go 1.20.x
      go-1-20-14 = go_1_20_14;
      go-1-20-13 = go_1_20_13;
      go-1-20-12 = go_1_20_12;
      go-1-20-11 = go_1_20_11;
      go-1-20-10 = go_1_20_10;
      go-1-20-9 = go_1_20_9;
      go-1-20-8 = go_1_20_8;
      go-1-20-7 = go_1_20_7;
      go-1-20-6 = go_1_20_6;
      go-1-20-5 = go_1_20_5;
      go-1-20-4 = go_1_20_4;
      go-1-20-3 = go_1_20_3;
      go-1-20-2 = go_1_20_2;
      go-1-20-1 = go_1_20_1;
      go-1-20-0 = go_1_20_0;

      # go 1.21.x
      go-1-21-13 = go_1_21_13;
      go-1-21-12 = go_1_21_12;
      go-1-21-11 = go_1_21_11;
      go-1-21-10 = go_1_21_10;
      go-1-21-9 = go_1_21_9;
      go-1-21-8 = go_1_21_8;
      go-1-21-7 = go_1_21_7;
      go-1-21-6 = go_1_21_6;
      go-1-21-5 = go_1_21_5;
      go-1-21-4 = go_1_21_4;
      go-1-21-3 = go_1_21_3;
      go-1-21-2 = go_1_21_2;
      go-1-21-1 = go_1_21_1;
      go-1-21-0 = go_1_21_0;

      # go 1.22.x
      go-1-22-12 = go_1_22_12;
      go-1-22-11 = go_1_22_11;
      go-1-22-10 = go_1_22_10;
      go-1-22-9 = go_1_22_9;
      go-1-22-8 = go_1_22_8;
      go-1-22-7 = go_1_22_7;
      go-1-22-6 = go_1_22_6;
      go-1-22-5 = go_1_22_5;
      go-1-22-4 = go_1_22_4;
      go-1-22-3 = go_1_22_3;
      go-1-22-2 = go_1_22_2;
      go-1-22-1 = go_1_22_1;
      go-1-22-0 = go_1_22_0;

      # go 1.23.x
      go-1-23-7 = go_1_23_7;
      go-1-23-6 = go_1_23_6;
      go-1-23-5 = go_1_23_5;
      go-1-23-4 = go_1_23_4;
      go-1-23-3 = go_1_23_3;
      go-1-23-2 = go_1_23_2;
      go-1-23-1 = go_1_23_1;
      go-1-23-0 = go_1_23_0;

      # go 1.24.x
      go-1-24-0 = go_1_24_0;
      go-1-24-1 = go_1_24_1;
      # Default package
      latest = latest;
      default = latest;
    };

    # Development shells with Go versions
    devShells.x86_64-linux = {
      # go 1.20.x
      go-1-20-14 = mkGoShell go_1_20_14;
      go-1-20-13 = mkGoShell go_1_20_13;
      go-1-20-12 = mkGoShell go_1_20_12;
      go-1-20-11 = mkGoShell go_1_20_11;
      go-1-20-10 = mkGoShell go_1_20_10;
      go-1-20-9 = mkGoShell go_1_20_9;
      go-1-20-8 = mkGoShell go_1_20_8;
      go-1-20-7 = mkGoShell go_1_20_7;
      go-1-20-6 = mkGoShell go_1_20_6;
      go-1-20-5 = mkGoShell go_1_20_5;
      go-1-20-4 = mkGoShell go_1_20_4;
      go-1-20-3 = mkGoShell go_1_20_3;
      go-1-20-2 = mkGoShell go_1_20_2;
      go-1-20-1 = mkGoShell go_1_20_1;
      go-1-20-0 = mkGoShell go_1_20_0;

      # go 1.21.x
      go-1-21-13 = mkGoShell go_1_21_13;
      go-1-21-12 = mkGoShell go_1_21_12;
      go-1-21-11 = mkGoShell go_1_21_11;
      go-1-21-10 = mkGoShell go_1_21_10;
      go-1-21-9 = mkGoShell go_1_21_9;
      go-1-21-8 = mkGoShell go_1_21_8;
      go-1-21-7 = mkGoShell go_1_21_7;
      go-1-21-6 = mkGoShell go_1_21_6;
      go-1-21-5 = mkGoShell go_1_21_5;
      go-1-21-4 = mkGoShell go_1_21_4;
      go-1-21-3 = mkGoShell go_1_21_3;
      go-1-21-2 = mkGoShell go_1_21_2;
      go-1-21-1 = mkGoShell go_1_21_1;
      go-1-21-0 = mkGoShell go_1_21_0;

      # go 1.22.x
      go-1-22-12 = mkGoShell go_1_22_12;
      go-1-22-11 = mkGoShell go_1_22_11;
      go-1-22-10 = mkGoShell go_1_22_10;
      go-1-22-9 = mkGoShell go_1_22_9;
      go-1-22-8 = mkGoShell go_1_22_8;
      go-1-22-7 = mkGoShell go_1_22_7;
      go-1-22-6 = mkGoShell go_1_22_6;
      go-1-22-5 = mkGoShell go_1_22_5;
      go-1-22-4 = mkGoShell go_1_22_4;
      go-1-22-3 = mkGoShell go_1_22_3;
      go-1-22-2 = mkGoShell go_1_22_2;
      go-1-22-1 = mkGoShell go_1_22_1;
      go-1-22-0 = mkGoShell go_1_22_0;

      # go 1.23.x
      go-1-23-7 = mkGoShell go_1_23_7;
      go-1-23-6 = mkGoShell go_1_23_6;
      go-1-23-5 = mkGoShell go_1_23_5;
      go-1-23-4 = mkGoShell go_1_23_4;
      go-1-23-3 = mkGoShell go_1_23_3;
      go-1-23-2 = mkGoShell go_1_23_2;
      go-1-23-1 = mkGoShell go_1_23_1;
      go-1-23-0 = mkGoShell go_1_23_0;

      go-1-24-0 = mkGoShell go_1_24_0;
      go-1-24-1 = mkGoShell go_1_24_1;
      # Default shell
      latest = mkGoShell latest;
      default = mkGoShell latest;
    };
  };
}
