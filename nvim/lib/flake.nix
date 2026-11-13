{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/4fe25e12eb9f4c744966dd3de5a05246cf098601"; # 26-11-6
    rust-overlay = {
      url = "github:oxalica/rust-overlay/74cebce67ef6671ea48fda353a5be2d229bd2920"; # 26-11-6
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
