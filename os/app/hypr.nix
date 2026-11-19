{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = (import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/e7add4ebef38bd6eed25a2f3de3f50080671d1ce.tar.gz";
        sha256 = "0i8lyhiycc7kw4f20nrr3q790qv6c004j1xs8zis5hbg4pr3z7bm";
      })
      { system = pkgs.stdenv.hostPlatform.system; }
    ).hyprland;
  };

  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprshot
    hyprpaper
    hyprpicker
    hyprpolkitagent
  ];
}
