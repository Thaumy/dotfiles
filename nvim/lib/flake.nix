{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/81788f7597ea358312f10f38300753746b2a90e4"; # 26-8-10
    rust-overlay = {
      url = "github:oxalica/rust-overlay/b211eadeba8b180da9453ec3413a8a3535c85b3f"; # 26-8-16
      inputs.nixpkgs.follows = "pkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";

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
      devShells.${system}.default = pkgs.mkShell {
        inherit name;

        # Use nightly fmt for better style
        RUSTFMT = "${rust-toolchain "nightly" "2026-07-11"}/bin/rustfmt";

        nativeBuildInputs = [
          (rust-toolchain "stable" "1.97.0")
        ];
      };

      packages.${system}.default = pkgs.rustPlatform.buildRustPackage {
        inherit name;

        nativeBuildInputs = [
          (rust-toolchain "stable" "1.97.0")
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
    };
}
