{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/d9e7fc09f3a8408496bcaa8d48d5d15de66fffc5"; # 25-1-28

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
