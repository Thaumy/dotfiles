{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/723ce9394b443fc4ce83d6d5a54aee528c5bb328"; # 25-8-2
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
        pkgs = import inputs.pkgs {
          inherit system;
          overlays = [ (import inputs.rust-overlay) ];
        };

        rust-toolchain = channel: version:
          pkgs.rust-bin."${channel}"."${version}".complete.override {
            extensions = [ "rust-src" ];
          };

        build-pkg = src: bin-name: bin-rename: pkgs.rustPlatform.buildRustPackage {
          inherit src;

          name = bin-name;

          nativeBuildInputs = [
            (rust-toolchain "stable" "1.92.0")
          ];

          cargoLock = {
            lockFile = "${src}/Cargo.lock";
            allowBuiltinFetchGit = true;
          };

          buildPhase = ''
            cargo b -r --offline
          '';

          doCheck = false;

          installPhase = ''
            mkdir -p $out/bin
            cp target/release/${bin-name} $out/bin/${bin-rename}
          '';
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "rsbin";

          # Use nightly fmt for better style
          RUSTFMT = "${rust-toolchain "nightly" "2026-01-18"}/bin/rustfmt";

          nativeBuildInputs = [
            (rust-toolchain "stable" "1.92.0")
          ];
        };

        packages = {
          edit-config = build-pkg ./edit-config "edit-config";
          dup-img-finder = build-pkg
            (pkgs.fetchFromGitHub {
              owner = "Thaumy";
              repo = "dup-img-finder";
              rev = "v0.3.0";
              hash = "sha256-rjp3mONHWAJY043rxPckrvoRg5W5a7WQOLod1qF2aW4=";
            }) "dup-img-finder";
          git-abort = build-pkg ./git-abort "git-abort";
          safe-remove = build-pkg ./safe-remove "safe-remove";
          screenshot = build-pkg ./screenshot "screenshot";
          sh-history-filter = build-pkg
            (pkgs.fetchFromGitHub {
              owner = "Thaumy";
              repo = "sh-history-filter";
              rev = "v0.0.5";
              hash = "sha256-+r3S84KQEESPoSA86glyjZK/QSpoF2ujyQ1DwZaUNYw=";
            }) "sh-history-filter";
          vi-project = build-pkg ./vi-project "vi-project";
          vi-visual-pane = build-pkg ./vi-visual-pane "vi-visual-pane";
          wm-action = build-pkg ./wm-action "wm-action";
        };
      });
}
