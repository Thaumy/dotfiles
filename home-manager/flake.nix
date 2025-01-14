{
  inputs = {
    nur.url = "github:nix-community/nur/9d1010316997b38f36f28824d95821e63b305657"; # 24-12-01
    pkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    pkgs.url = "github:NixOS/nixpkgs/5daca2db3da901cc6c2127f50a9d5b2770d672d0"; # 25-1-6

    home-manager = {
      url = "github:nix-community/home-manager/e1aec543f5caf643ca0d94b6a633101942fd065f"; # 24-10-14
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
