{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/f4341811740ba37cc17962dd1da929bd32dbeb91"; # 24-8-7

    rust-overlay = {
      url = "github:oxalica/rust-overlay/fb8c8be0313f0e6385b3d70151a04ea1d71e4b68"; # 24-7-14
      inputs.nixpkgs.follows = "pkgs";
    };
  };

  outputs = inputs@{ ... }: {
    nixosConfigurations."nixos" = inputs.pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ];
    };
  };
}
