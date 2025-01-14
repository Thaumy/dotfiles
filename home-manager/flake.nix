{
  inputs = {
    nur.url = "github:nix-community/nur/9d1010316997b38f36f28824d95821e63b305657"; # 24-12-01
    pkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    pkgs.url = "github:NixOS/nixpkgs/5daca2db3da901cc6c2127f50a9d5b2770d672d0"; # 25-1-6

    home-manager = {
      url = "github:nix-community/home-manager/e1aec543f5caf643ca0d94b6a633101942fd065f"; # 24-10-14
      inputs.nixpkgs.follows = "pkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?submodules=1&rev=12f9a0d0b93f691d4d9923716557154d74777b0a"; # 24-11-20(0.45.2)
      inputs.nixpkgs.follows = "pkgs";
      inputs.aquamarine.url = "github:hyprwm/aquamarine/8d732fa8aff8b12ef2b1e2f00fc8153e41312b72"; # 24-10-22
      inputs.hyprcursor.url = "github:hyprwm/hyprcursor/3b3259e52a2d3d604bfcb6593b56cc0ca2b7a050"; # 24-12-22(0.1.11)
      inputs.hyprutils.url = "github:hyprwm/hyprutils/fd4be8b9ca932f7384e454bcd923c5451ef2aa85"; # 24-10-15
    };
    hyprfocus = {
      url = "github:pyt0xic/hyprfocus/bead5b77d80f222c006d1a6c6f44ee8b02021d73"; # 24-11-9
      inputs.hyprland.follows = "hyprland";
    };

    nvim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay/9e2c41b7c12adc3ca17b1b50589f5234bcc0bbac"; # 25-1-13
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
          pkgs-24-05 = import inputs.pkgs-24-05 pkgs-cfg;
        };
        modules = [ ./home.nix ];
      };
      defaultPackage.x86_64-darwin = hm.defaultPackage.x86_64-darwin;
    };
}
