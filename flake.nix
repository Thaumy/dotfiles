{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/8edc0c72e3a38faf5434e40d1f19431125fe4b30"; # 26-10-9

    nur.url = "github:nix-community/nur/4a36b59f78a6215268cf7f74a48c76ba727738e5"; # 26-10-10

    hm = {
      url = "github:nix-community/home-manager/c58f54c733a7894d84fa2fdff26cc12088c4b78c"; # 26-10-10
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/29846367dc2685d9f2397cbd94d3223ddab8f62f"; # 26-10-4

    rust-overlay = {
      url = "github:oxalica/rust-overlay/3100cf6ff140fb298f09192de610f4037d3bab0f"; # 26-10-13
      inputs.nixpkgs.follows = "pkgs";
    };
    rsbin.url = "path:./rsbin";

    nvim.url = "github:nix-community/neovim-nightly-overlay/2582a095725ee836098b0de4c56c52b8ccdb9a94"; # 26-10-13
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
