{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/8e0485bac410ec46a7fb0ebeeed49e00950c152a"; # 26-3-30

    nur.url = "github:nix-community/nur/797a5b4d04ae501c69eb54cadf7e526c1acad3fa"; # 26-2-14

    hm = {
      url = "github:nix-community/home-manager/9340f51314713c83360bf72d75c8b404778ab5b1"; # 26-3-30
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/62d55a8172c5ec028b21d50ea54c7c73107db6aa"; # 26-2-20

    rust-overlay = {
      url = "github:oxalica/rust-overlay/d9f52b51548e76ab8b6e7d647763047ebdec835c"; # 26-3-30
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
