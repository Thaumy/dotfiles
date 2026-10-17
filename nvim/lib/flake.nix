{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/8edc0c72e3a38faf5434e40d1f19431125fe4b30"; # 26-10-9
    rust-overlay = {
      url = "github:oxalica/rust-overlay/3100cf6ff140fb298f09192de610f4037d3bab0f"; # 26-10-13
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
        RUSTFMT = "${rust-toolchain "nightly" "2026-09-16"}/bin/rustfmt";

        nativeBuildInputs = [
          (rust-toolchain "stable" "1.98.1")
        ];
      };

      packages.${system}.default = pkgs.rustPlatform.buildRustPackage {
        inherit name;

        nativeBuildInputs = [
          (rust-toolchain "stable" "1.98.1")
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
