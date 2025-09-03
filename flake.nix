{
  inputs = {
    nur.url = "github:nix-community/nur/9ea0c40c52673079dfe50e82ddbb78679723be05"; # 25-4-17
    pkgs.url = "github:NixOS/nixpkgs/34ea16dab521dc5648ab5078040ead131b50f27b"; # 25-8-15

    hm = {
      url = "github:nix-community/home-manager/29ab63bbb3d9eee4a491f7ce701b189becd34068"; # 25-9-1
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/5a858e19041acabeaccdd9664a03ff04ed79b16f"; # 25-5-30

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
