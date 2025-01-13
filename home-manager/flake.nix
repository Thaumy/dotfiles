{
  inputs = {
    nur.url = "github:nix-community/nur/9d1010316997b38f36f28824d95821e63b305657"; # 24-12-01
    pkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    pkgs.url = "github:NixOS/nixpkgs/18536bf04cd71abd345f9579158841376fdd0c5a"; # 24-10-26

    home-manager = {
      url = "github:nix-community/home-manager/e1aec543f5caf643ca0d94b6a633101942fd065f"; # 24-10-14
      inputs.nixpkgs.follows = "pkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?submodules=1&rev=4520b30d498daca8079365bdb909a8dea38e8d55"; # 24-10-9(0.44.1)
      inputs.nixpkgs.follows = "pkgs";
      inputs.aquamarine.url = "github:hyprwm/aquamarine/8d732fa8aff8b12ef2b1e2f00fc8153e41312b72"; # 24-10-22
      inputs.hyprutils.url = "github:hyprwm/hyprutils/fd4be8b9ca932f7384e454bcd923c5451ef2aa85"; # 24-10-15
    };
    hyprfocus = {
      url = "github:pyt0xic/hyprfocus/aa7262d3a4564062f97b9cfdad47fd914cfb80f2"; # 24-5-30
      inputs.hyprland.follows = "hyprland";
    };

    nvim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay/b81db43451a3f157a6570f9515fce6866ae70dab"; # 24-10-10
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
