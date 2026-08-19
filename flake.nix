{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/81788f7597ea358312f10f38300753746b2a90e4"; # 26-8-10

    nur.url = "github:nix-community/nur/797a5b4d04ae501c69eb54cadf7e526c1acad3fa"; # 26-2-14

    hm = {
      url = "github:nix-community/home-manager/5bd505963717a894b02a57cdbcc00db28d9b029f"; # 26-8-16
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/e13041c9a160defbc6aac95bcb88ba5c43cf25ae"; # 26-6-14

    rust-overlay = {
      url = "github:oxalica/rust-overlay/b211eadeba8b180da9453ec3413a8a3535c85b3f"; # 26-8-16
      inputs.nixpkgs.follows = "pkgs";
    };
    rsbin.url = "path:./rsbin";

    nvim.url = "github:nix-community/neovim-nightly-overlay/3dc8fa3b0b2220ffd0836012407b15aa6747d3fe"; # 26-8-16
    libnvimcfg.url = "path:./nvim/lib";
  };

  outputs = inputs: {
    nixosConfigurations."nixos" = inputs.pkgs.lib.nixosSystem {
      modules = [ ./os/mod.nix ];
      specialArgs = { inherit inputs; };
    };

    homeConfigurations."thaumy" = inputs.hm.lib.homeManagerConfiguration {
      pkgs = import inputs.pkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./hm/mod.nix ];
    };
  };
}
