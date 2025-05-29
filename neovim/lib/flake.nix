{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/e84598116e49651c1be6836fab2a38511ace723d"; # 25-5-19
    rust-overlay = {
      url = "github:oxalica/rust-overlay/9c8ea175cf9af29edbcff121512e44092a8f37e4"; # 25-5-27
      inputs.nixpkgs.follows = "pkgs";
    };
    flake-utils.url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b"; # 24-11-14
  };

  outputs = inputs@{ ... }: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import inputs.pkgs {
        inherit system;
        overlays = [ (import inputs.rust-overlay) ];
      };
      name = "nvimcfg";

      rust-toolchain = channel: version:
        pkgs.rust-bin."${channel}"."${version}".complete.override {
          extensions = [ "rust-src" ];
          targets = [
            "x86_64-unknown-linux-gnu"
          ];
        };
    in
    {
      devShells.default = pkgs.mkShell {
        inherit name;

        # Use nightly fmt for better style
        RUSTFMT = "${rust-toolchain "nightly" "2025-05-27"}/bin/rustfmt";

        nativeBuildInputs = [
          (rust-toolchain "stable" "1.87.0")
        ];
      };

      packages.default = pkgs.rustPlatform.buildRustPackage {
        inherit name;

        nativeBuildInputs = [
          (rust-toolchain "stable" "1.87.0")
        ];

        src = ./.;

        cargoLock = {
          lockFile = ./Cargo.lock;
          allowBuiltinFetchGit = true;
        };

        buildPhase = ''
          cargo b -r --offline
        '';

        doCheck = false;

        installPhase = ''
          mkdir -p $out/lib
          cp target/release/lib${name}.so $out/lib
        '';
      };
    });
}
