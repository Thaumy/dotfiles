{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/55dbedb9590009e44aa4b1844754700dd5d722e4"; # 24-7-1

    rust-overlay.url = "github:oxalica/rust-overlay/fb8c8be0313f0e6385b3d70151a04ea1d71e4b68"; # 24-7-14
  };

  outputs = inputs@{ ... }: {
    nixosConfigurations."nixos" = inputs.pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
