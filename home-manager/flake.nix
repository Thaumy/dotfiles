{
  inputs = {
    nur.url = "github:nix-community/nur";
    pkgs-22-11.url = "github:nixos/nixpkgs/nixos-22.11";
    pkgs-23-05.url = "github:nixos/nixpkgs/nixos-23.05";
    pkgs-23-11.url = "github:nixos/nixpkgs/nixos-23.11";
    pkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "pkgs-unstable";
    };

    hyprland.url = "git+https://github.com/hyprwm/hyprland?submodules=1";
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
          pkgs-22-11 = import inputs.pkgs-22-11 pkgs-cfg;
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
