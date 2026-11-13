{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/4fe25e12eb9f4c744966dd3de5a05246cf098601"; # 26-11-6

    nur.url = "github:nix-community/nur/4a36b59f78a6215268cf7f74a48c76ba727738e5"; # 26-10-10

    hm = {
      url = "github:nix-community/home-manager/2c0c1f01521469cf0271180c453c79782d53c2f6"; # 26-11-6
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/29846367dc2685d9f2397cbd94d3223ddab8f62f"; # 26-10-4

    rust-overlay = {
      url = "github:oxalica/rust-overlay/74cebce67ef6671ea48fda353a5be2d229bd2920"; # 26-11-6
      inputs.nixpkgs.follows = "pkgs";
    };
    rsbin.url = "path:./rsbin";

    nvim.url = "github:nix-community/neovim-nightly-overlay/60eb4aa73b9aba4d92a7ee09919a0a579536b6ad"; # 26-11-6
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
