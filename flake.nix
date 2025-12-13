{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/3a00309b9659c2c51b3a75cdc7183515d453bbd5"; # 25-12-10
    nur.url = "github:nix-community/nur/a180e837cadff3e66502353a5dbdaffd05b049ac"; # 25-9-1

    hm = {
      url = "github:nix-community/home-manager/13cc1efd78b943b98c08d74c9060a5b59bf86921"; # 25-12-10
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/1b7823fec242bee106e9d2a79ba72c835fb3baaf"; # 25-8-24

    rust-overlay = {
      url = "github:oxalica/rust-overlay/c3cea2a0ec0d5debbef4aa2a0cfe59bd0fb0aeeb"; # 25-11-16
      inputs.nixpkgs.follows = "pkgs";
    };
    rsbin.url = "path:./rsbin";

    nvim-nightly.url = "github:nix-community/neovim-nightly-overlay/ac9bde3d5fcec88383a16a63dc1bdb1702f7233e"; # 25-12-10
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
