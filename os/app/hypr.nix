{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = (import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/1e23b1be785ea5d625c65aff6de3333831a842fb.tar.gz";
        sha256 = "1l9abaiwvs0vydzc3x2w5yz8nxmzafb4xjsfh8bicvv6cac9zci6";
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
