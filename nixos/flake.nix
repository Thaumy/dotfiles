{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/5daca2db3da901cc6c2127f50a9d5b2770d672d0"; # 25-1-6

    nyx = {
      url = "github:chaotic-cx/nyx/175a7f545d07bd08c14709f0d0849a8cddaaf460"; # 25-2-11
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
