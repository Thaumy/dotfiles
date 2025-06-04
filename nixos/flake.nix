{
  inputs = {
    nur.url = "github:nix-community/nur/9ea0c40c52673079dfe50e82ddbb78679723be05"; # 25-4-17
    pkgs.url = "github:NixOS/nixpkgs/e84598116e49651c1be6836fab2a38511ace723d"; # 25-5-19

    dae.url = "github:daeuniverse/flake.nix/5a858e19041acabeaccdd9664a03ff04ed79b16f"; # 25-5-30
    rust-overlay = {
      url = "github:oxalica/rust-overlay/b4270835bf43c6f80285adac6f66a26d83f0f277"; # 25-2-28
      inputs.nixpkgs.follows = "pkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations."nixos" = inputs.pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./os.nix ];
      specialArgs = { inherit inputs; };
    };
  };
}
