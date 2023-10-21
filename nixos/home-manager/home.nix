{ config, pkgs, ... }:

{
  manual.manpages.enable = false;

  imports = [
    ./sh.nix
    ./pkgs.nix
    ./app/mod.nix
    ./symlinks.nix
    ./daemon/mod.nix
  ];

  home = {
    username = "thaumy";
    stateVersion = "22.11";
    homeDirectory = "/home/thaumy";
    sessionPath = [
      "/home/thaumy/.dotnet/tools"
    ];
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
