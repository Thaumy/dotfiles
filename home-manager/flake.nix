{
  inputs = {
    nur.url = "github:nix-community/nur/9ea0c40c52673079dfe50e82ddbb78679723be05"; # 25-4-17
    pkgs.url = "github:NixOS/nixpkgs/0a9e4b8f21ef750df60b9b9670e48fc6d0263fd1"; # 25-7-26

    hm = {
      url = "github:nix-community/home-manager/479f8889675770881033878a1c114fbfc6de7a4d"; # 25-7-1
      inputs.nixpkgs.follows = "pkgs";
    };

    nvim-nightly.url = "github:nix-community/neovim-nightly-overlay/d23aed1e00bf4e133f582fbd435eac02199db22c"; # 25-7-4
    libnvimcfg.url = "path:///home/thaumy/cfg/neovim/lib";
  };

  outputs = inputs: {
    homeConfigurations."thaumy" = inputs.hm.lib.homeManagerConfiguration {
      pkgs = import inputs.pkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./home.nix ];
    };
  };
}
