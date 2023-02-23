{ config, pkgs, ... }:

{

  imports = [
    ./pkgs.nix
    ./app/gpg.nix
    ./app/git.nix
    ./app/fish.nix
    ./app/neovim.nix
  ];

  home = {
    username = "thaumy";
    stateVersion = "22.11";
    homeDirectory = "/home/thaumy";
  };

  nixpkgs.config = {

    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import
        (builtins.fetchTarball
          "https://github.com/nix-community/NUR/archive/master.tar.gz")
        {
          inherit pkgs;
        };
    };

  };

}
