{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/fdd4f3a74622d9d192ef665eecd6ac9ed0359a8d"; # 25-12-20

    nur.url = "github:nix-community/nur/a180e837cadff3e66502353a5dbdaffd05b049ac"; # 25-9-1

    hm = {
      url = "github:nix-community/home-manager/bb35f07cc95a73aacbaf1f7f46bb8a3f40f265b5"; # 25-12-20
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/1800f4eedb940644d99d60833ad0acba9aeeee0e"; # 25-12-16

    rust-overlay = {
      url = "github:oxalica/rust-overlay/4b7472a78857ac789fb26616040f55cfcbd36c6e"; # 26-01-18
      inputs.nixpkgs.follows = "pkgs";
    };
    rsbin.url = "path:./rsbin";

    nvim-nightly.url = "github:nix-community/neovim-nightly-overlay/4ae5c0c99f5e7fe02f0df0220a7d09b1945df646"; # 26-2-4
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
