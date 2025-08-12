{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
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
