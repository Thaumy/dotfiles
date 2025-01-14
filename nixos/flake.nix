{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/5daca2db3da901cc6c2127f50a9d5b2770d672d0"; # 25-1-6

    nyx = {
      url = "github:chaotic-cx/nyx/705c09ade97041ccc9d04282498af7983874fe19"; # 25-1-13
      inputs.nixpkgs.follows = "pkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay/cf960a1938ee91200fe0d2f7b2582fde2429d562"; # 25-1-13
      inputs.nixpkgs.follows = "pkgs";
    };
  };

  outputs = inputs@{ ... }: {
    nixosConfigurations."nixos" = inputs.pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./os.nix
        inputs.nyx.nixosModules.default
      ];
    };
  };
}
