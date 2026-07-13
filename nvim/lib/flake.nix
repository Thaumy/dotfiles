{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/d38bf033dc578bcc3757ecb3fdda7755f65421bc"; # 25-10-26
    rust-overlay = {
      url = "github:oxalica/rust-overlay/e598b37857b895b81020a65a802ef55f5bbed72f"; # 26-7-11
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
