{ pkgs-25-01-28, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    package = pkgs-25-01-28.hyprland;

    plugins = [
      pkgs-25-01-28.hyprlandPlugins.hyprfocus
    ];

    extraConfig = "source = ~/cfg/hypr/hyprland/hyprland.conf";
  };

  home.packages = with pkgs-25-01-28; [
    hypridle
    hyprlock
    hyprshot
    hyprpaper
    hyprpicker
  ];
}
