{
  inputs = {
    nur.url = "github:nix-community/nur/64f752e6fbf6d89da13f417fa34225a8b081ce92"; # 24-7-16
    pkgs-23-05.url = "github:nixos/nixpkgs/nixos-23.05";
    pkgs-23-11.url = "github:nixos/nixpkgs/nixos-23.11";
    pkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    pkgs.url = "github:NixOS/nixpkgs/cb39aebe37d7fdaf42011b41df7742b7b03afa95"; # 24-8-10

    home-manager = {
      url = "github:nix-community/home-manager/c085b984ff2808bf322f375b10fea5a415a9c43d"; # 24-7-11
      inputs.nixpkgs.follows = "pkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?submodules=1&rev=9a09eac79b85c846e3a865a9078a3f8ff65a9259"; # 24-8-8(0.42.0)
      inputs.nixpkgs.follows = "pkgs";
      inputs.hyprwayland-scanner.url = "github:hyprwm/hyprwayland-scanner/a048a6cb015340bd82f97c1f40a4b595ca85cc30"; # 24-7-19
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
          pkgs-23-05 = import inputs.pkgs-23-05 pkgs-cfg;
          pkgs-23-11 = import inputs.pkgs-23-11 pkgs-cfg;
          pkgs-24-05 = import inputs.pkgs-24-05 pkgs-cfg;
        };
        modules = [ ./home.nix ];
      };
      defaultPackage.x86_64-darwin = hm.defaultPackage.x86_64-darwin;
    };
}
