{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/d38bf033dc578bcc3757ecb3fdda7755f65421bc"; # 25-10-26
    rust-overlay = {
      url = "github:oxalica/rust-overlay/4b7472a78857ac789fb26616040f55cfcbd36c6e"; # 26-01-18
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
          RUSTFMT = "${rust-toolchain "nightly" "2026-01-18"}/bin/rustfmt";

          nativeBuildInputs = [
            (rust-toolchain "stable" "1.92.0")
          ];
        };

        packages.default = pkgs.rustPlatform.buildRustPackage {
          inherit name;

          nativeBuildInputs = [
            (rust-toolchain "stable" "1.92.0")
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
