{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/723ce9394b443fc4ce83d6d5a54aee528c5bb328"; # 25-8-2
    rust-overlay = {
      url = "github:oxalica/rust-overlay/08ff39bf869cadca3102b39824f4c7025186b7dc"; # 25-8-2
      inputs.nixpkgs.follows = "pkgs";
    };
    flake-utils.url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b"; # 24-11-14
  };

  outputs = inputs: inputs.flake-utils.lib.eachSystem
    [ "x86_64-linux" ]
    (system:
      let
        pkgs = import inputs.pkgs {
          inherit system;
          overlays = [ (import inputs.rust-overlay) ];
        };

        rust-toolchain = channel: version:
          pkgs.rust-bin."${channel}"."${version}".complete.override {
            extensions = [ "rust-src" ];
          };

        build-pkg = name: bin-name: pkgs.rustPlatform.buildRustPackage {
          inherit name;

          nativeBuildInputs = [
            (rust-toolchain "stable" "1.88.0")
          ];

          src = ./. + "/${name}";

          cargoLock = {
            lockFile = ./. + "/${name}/Cargo.lock";
            allowBuiltinFetchGit = true;
          };

          buildPhase = ''
            cargo b -r --offline
          '';

          doCheck = false;

          installPhase = ''
            mkdir -p $out/bin
            cp target/release/${name} $out/bin/${bin-name}
          '';
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "rsbin";

          # Use nightly fmt for better style
          RUSTFMT = "${rust-toolchain "nightly" "2025-08-02"}/bin/rustfmt";

          nativeBuildInputs = [
            (rust-toolchain "stable" "1.88.0")
          ];
        };

        packages = {
          edit-config = build-pkg "edit-config";
        };
      });
}
