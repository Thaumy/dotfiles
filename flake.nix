{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/d38bf033dc578bcc3757ecb3fdda7755f65421bc"; # 25-10-26
    nur.url = "github:nix-community/nur/a180e837cadff3e66502353a5dbdaffd05b049ac"; # 25-9-1

    hm = {
      url = "github:nix-community/home-manager/1830716059bfee7cbcfbfcc38d7be98e482a5762"; # 25-10-26
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/1b7823fec242bee106e9d2a79ba72c835fb3baaf"; # 25-8-24

    rust-overlay = {
      url = "github:oxalica/rust-overlay/7bc7d2f706ebe5479d230d2c6806b5dc757ae4cd"; # 25-10-28
      inputs.nixpkgs.follows = "pkgs";
    };
    rsbin.url = "path:./rsbin";

    nvim-nightly.url = "github:nix-community/neovim-nightly-overlay/643f5aad118a1bb2db5caa8bfc411da794fb870f"; # 25-10-22
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
