{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/18536bf04cd71abd345f9579158841376fdd0c5a"; # 24-10-26

    nyx = {
      url = "github:chaotic-cx/nyx/9b30ea4a39c8c5a2b6a6519f85da38f72b7f29f0"; # 24-9-26
      inputs.nixpkgs.follows = "pkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay/17cadbc36da05e75197d082decb382a5f4208e30"; # 24-10-26
      inputs.nixpkgs.follows = "pkgs";
    };
  };

  outputs = inputs@{ ... }: {
    nixosConfigurations."nixos" = inputs.pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.nyx.nixosModules.default
      ];
    };
  };
}
