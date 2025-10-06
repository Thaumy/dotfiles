{ inputs, pkgs, ... }: {
  manual.manpages.enable = false;

  imports = [
    ./sh/mod.nix
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
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 22;
    };
  };

  nixpkgs.overlays = [ inputs.nur.overlays.default ];
}
