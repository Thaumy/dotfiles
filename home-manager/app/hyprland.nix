{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    package = pkgs.hyprland;

    plugins = [
    ];

    extraConfig = "source = ~/cfg/hypr/hyprland/hyprland.conf";
  };

  home.packages = with pkgs; [
    hypridle
    hyprlock
    hyprshot
    hyprpaper
    hyprpicker
  ];
}
