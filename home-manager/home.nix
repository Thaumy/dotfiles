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
    sessionVariables = {
      QT_SCALE_FACTOR = 1.8;
      # for perf-event-rs build
      LINUX_HEADERS_PATH = "/etc/sdk-homes/linux-headers";
    };
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 22;
    };
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
    permittedInsecurePackages = [
      "nix-2.16.2"
    ];

  };

}
