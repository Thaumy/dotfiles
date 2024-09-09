{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/cb39aebe37d7fdaf42011b41df7742b7b03afa95"; # 24-8-10

    rust-overlay = {
      url = "github:oxalica/rust-overlay/8cc45e678e914a16c8e224c3237fb07cf21e5e54"; # 24-9-7
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
