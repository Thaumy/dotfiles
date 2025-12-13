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
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 22;
    };
  };

  news.display = "silent";

  nixpkgs.overlays = [ inputs.nur.overlays.default ];
}
