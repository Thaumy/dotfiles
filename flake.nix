{
  inputs = {
    nur.url = "github:nix-community/nur/9ea0c40c52673079dfe50e82ddbb78679723be05"; # 25-4-17
    pkgs.url = "github:NixOS/nixpkgs/6ada30eca4f5df9a61abe5e2c9c2de6a00f50252"; # 25-9-1

    hm = {
      url = "github:nix-community/home-manager/29ab63bbb3d9eee4a491f7ce701b189becd34068"; # 25-9-1
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/1b7823fec242bee106e9d2a79ba72c835fb3baaf"; # 25-8-24

    rust-overlay = {
      url = "github:oxalica/rust-overlay/b29e5365120f344fe7161f14fc9e272fcc41ee56"; # 25-9-1
      inputs.nixpkgs.follows = "pkgs";
    };
    rsbin.url = "path:./rsbin";

    nvim-nightly.url = "github:nix-community/neovim-nightly-overlay/d794f8296742e8552e884f2b4f3d626263f90d95"; # 25-9-1
    libnvimcfg.url = "path:./neovim/lib";
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
