{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/4e651defeb9525ca6f62bb317a10863584f7700f"; # 25-3-9

    nyx = {
      url = "github:chaotic-cx/nyx/175a7f545d07bd08c14709f0d0849a8cddaaf460"; # 25-2-11
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay/b4270835bf43c6f80285adac6f66a26d83f0f277"; # 25-2-28
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
