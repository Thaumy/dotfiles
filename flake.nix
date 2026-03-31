{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/8e0485bac410ec46a7fb0ebeeed49e00950c152a"; # 26-3-30

    nur.url = "github:nix-community/nur/797a5b4d04ae501c69eb54cadf7e526c1acad3fa"; # 26-2-14

    hm = {
      url = "github:nix-community/home-manager/0825a0922a5d677f5f984bb79524569bbd1f9954"; # 26-2-12
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/1800f4eedb940644d99d60833ad0acba9aeeee0e"; # 25-12-16

    rust-overlay = {
      url = "github:oxalica/rust-overlay/095c394bb91342882f27f6c73f64064fb9de9f2a"; # 26-2-4
      inputs.nixpkgs.follows = "pkgs";
    };
    rsbin.url = "path:./rsbin";

    nvim-nightly.url = "github:nix-community/neovim-nightly-overlay/a49f9d17bcaa684b81fc4322fbcbfc3ba501d40e"; # 26-3-30
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
