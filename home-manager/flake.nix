{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-06-12
    pkgs-23-05.url = "github:nixos/nixpkgs/nixos-23.05";
    pkgs-23-11.url = "github:nixos/nixpkgs/nixos-23.11";
    pkgs.url = "github:NixOS/nixpkgs/8b89e34d1b10c0eb8bac6f2cc7b7a941f4acb171"; # 24-06-01

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "pkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?submodules=1&rev=ea2501d4556f84d3de86a4ae2f4b22a474555b9f"; # 0.41.0
      inputs.nixpkgs.follows = "pkgs";
      inputs.hyprcursor.url = "github:hyprwm/hyprcursor/57298fc4f13c807e50ada2c986a3114b7fc2e621"; # 0.1.9
      inputs.hyprwayland-scanner.url = "github:hyprwm/hyprwayland-scanner/0f30f9eca6e404130988554accbb64d1c9ec877d"; # 0.3.10
    };
    hyprfocus = {
      url = "github:pyt0xic/hyprfocus/aa7262d3a4564062f97b9cfdad47fd914cfb80f2"; # 24-05-30
      inputs.hyprland.follows = "hyprland";
    };

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
        pkgs = import inputs.pkgs pkgs-cfg;
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
