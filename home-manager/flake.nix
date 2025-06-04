{
  inputs = {
    nur.url = "github:nix-community/nur/9ea0c40c52673079dfe50e82ddbb78679723be05"; # 25-4-17
    pkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    pkgs.url = "github:NixOS/nixpkgs/e84598116e49651c1be6836fab2a38511ace723d"; # 25-5-19

    home-manager = {
      url = "github:nix-community/home-manager/97118a310eb8e13bc1b9b12d67267e55b7bee6c8"; # 25-5-18
      inputs.nixpkgs.follows = "pkgs";
    };

    nvim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay/a666b0a2cc977c586cebd60e7cb8735dcffd09ae"; # 25-4-10
    libnvimcfg.url = "path:///home/thaumy/cfg/neovim/lib";
  };

  outputs = inputs:
    let
      pkgs-cfg = {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations."thaumy" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.pkgs pkgs-cfg;
        extraSpecialArgs = {
          inherit inputs;
          pkgs-24-05 = import inputs.pkgs-24-05 pkgs-cfg;
        };
        modules = [ ./home.nix ];
      };
    };
}
