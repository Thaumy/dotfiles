{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/bfe7a4a3ee94059c0b8003cdb0b6bccd74d3a0f7"; # 24-7-27

    rust-overlay.url = "github:oxalica/rust-overlay/fb8c8be0313f0e6385b3d70151a04ea1d71e4b68"; # 24-7-14
  };

  outputs = inputs@{ ... }: {
    nixosConfigurations."nixos" = inputs.pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ];
    };
  };
}
