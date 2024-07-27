{
  inputs = {
    nur.url = "github:nix-community/nur/64f752e6fbf6d89da13f417fa34225a8b081ce92"; # 24-7-16
    pkgs-23-05.url = "github:nixos/nixpkgs/nixos-23.05";
    pkgs-23-11.url = "github:nixos/nixpkgs/nixos-23.11";
    pkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    pkgs.url = "github:NixOS/nixpkgs/bfe7a4a3ee94059c0b8003cdb0b6bccd74d3a0f7"; # 24-7-27

    home-manager = {
      url = "github:nix-community/home-manager/c085b984ff2808bf322f375b10fea5a415a9c43d"; # 24-7-11
      inputs.nixpkgs.follows = "pkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?submodules=1&rev=1d70962892a6e3e1cacd3663b390bbdf81426984"; # 24-6-25
      inputs.nixpkgs.follows = "pkgs";
      inputs.hyprutils.url = "github:hyprwm/hyprutils/6174a2a25f4e216c0f1d0c4278adc23c476b1d09"; # 24-7-10
    };
    hyprfocus = {
      url = "github:pyt0xic/hyprfocus/aa7262d3a4564062f97b9cfdad47fd914cfb80f2"; # 24-5-30
      inputs.hyprland.follows = "hyprland";
    };

    nvim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay/9822e0611d49ae70278ac20c9d7b68e4797b2fab"; # 24-7-6
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
        pkgs = import inputs.pkgs pkgs-cfg;
        extraSpecialArgs = {
          inherit inputs;
          pkgs-23-05 = import inputs.pkgs-23-05 pkgs-cfg;
          pkgs-23-11 = import inputs.pkgs-23-11 pkgs-cfg;
          pkgs-24-05 = import inputs.pkgs-24-05 pkgs-cfg;
        };
        modules = [
          ./home.nix
        ];
      };
      defaultPackage.x86_64-darwin = hm.defaultPackage.x86_64-darwin;
    };
}
