{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/7b033cac491de078d36d15b07f0036ab197a3180"; # 26-9-16

    nur.url = "github:nix-community/nur/797a5b4d04ae501c69eb54cadf7e526c1acad3fa"; # 26-2-14

    hm = {
      url = "github:nix-community/home-manager/f2785222a14e90f8c5ad2ff62474ce88453c3421"; # 26-9-17
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/aff5c0459967ac021a7eef45bff6d04d62c75f54"; # 26-9-18

    rust-overlay = {
      url = "github:oxalica/rust-overlay/35ca0490d13a3d38c4602d0eb9600a30fa63a367"; # 26-9-16
      inputs.nixpkgs.follows = "pkgs";
    };
    rsbin.url = "path:./rsbin";

    nvim.url = "github:nix-community/neovim-nightly-overlay/8406b7a1e0c6b058cb8d54f60c2abf74f33b61d5"; # 26-9-16
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
