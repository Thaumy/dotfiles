{
  inputs = {
    nur.url = "github:nix-community/nur/9d1010316997b38f36f28824d95821e63b305657"; # 24-12-01
    pkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    pkgs.url = "github:NixOS/nixpkgs/d9e7fc09f3a8408496bcaa8d48d5d15de66fffc5"; # 25-1-28

    home-manager = {
      url = "github:nix-community/home-manager/0db5c8bfcce78583ebbde0b2abbc95ad93445f7c"; # 25-1-23
      inputs.nixpkgs.follows = "pkgs";
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
