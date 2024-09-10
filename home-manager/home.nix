{ pkgs, ... }: {
  manual.manpages.enable = false;

  imports = [
    ./pkgs.nix
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
    sessionVariables = {
      # for perf-event-rs build
      LINUX_HEADERS_PATH = "/etc/sdk-homes/linux-headers";
    };
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 22;
    };
  };
}
