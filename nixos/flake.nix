{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/caea1cba7d888e70ffc85b041a5aef36febc50e4"; # 25-4-17

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
      ];
    };
  };
}
