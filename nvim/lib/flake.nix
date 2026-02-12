{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/d38bf033dc578bcc3757ecb3fdda7755f65421bc"; # 25-10-26
    rust-overlay = {
      url = "github:oxalica/rust-overlay/095c394bb91342882f27f6c73f64064fb9de9f2a"; # 26-2-4
      inputs.nixpkgs.follows = "pkgs";
    };
    flake-utils.url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b"; # 24-11-14
  };

  outputs = inputs: inputs.flake-utils.lib.eachSystem
    [ "x86_64-linux" ]
    (system:
      let
        name = "nvimcfg";

        pkgs = import inputs.pkgs {
          inherit system;
          overlays = [ (import inputs.rust-overlay) ];
        };

        rust-toolchain = channel: version:
          pkgs.rust-bin."${channel}"."${version}".complete.override {
            extensions = [ "rust-src" ];
          };
      in
      {
        devShells.default = pkgs.mkShell {
          inherit name;

          # Use nightly fmt for better style
          RUSTFMT = "${rust-toolchain "nightly" "2026-02-04"}/bin/rustfmt";

          nativeBuildInputs = [
            (rust-toolchain "stable" "1.93.0")
          ];
        };

        packages.default = pkgs.rustPlatform.buildRustPackage {
          inherit name;

          nativeBuildInputs = [
            (rust-toolchain "stable" "1.93.0")
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
