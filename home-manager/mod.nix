{ pkgs, ... }: {
  manual.manpages.enable = false;

  imports = [
    ./sh/mod.nix
    ./app/mod.nix
    ./nixpkgs.nix
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
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 22;
    };
  };
}
