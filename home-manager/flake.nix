{
  inputs = {
    nur.url = "github:nix-community/nur";
    pkgs-23-05.url = "github:nixos/nixpkgs/nixos-23.05";
    pkgs-23-11.url = "github:nixos/nixpkgs/nixos-23.11";
    pkgs-unstable.url = "github:NixOS/nixpkgs/8b89e34d1b10c0eb8bac6f2cc7b7a941f4acb171"; # 24-06-01

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "pkgs-unstable";
    };

    hyprland.url = "git+https://github.com/hyprwm/hyprland?submodules=1";

    nvim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs:
    let
      hm = inputs.home-manager;
      pkgs-cfg = {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations."thaumy" = hm.lib.homeManagerConfiguration {
        pkgs = import inputs.pkgs-unstable pkgs-cfg;
        extraSpecialArgs = {
          inherit inputs;
          pkgs-23-05 = import inputs.pkgs-23-05 pkgs-cfg;
          pkgs-23-11 = import inputs.pkgs-23-11 pkgs-cfg;
        };
        modules = [
          ./home.nix
        ];
      };
      defaultPackage.x86_64-darwin = hm.defaultPackage.x86_64-darwin;
    };
}
