{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    package = pkgs.hyprland;

    plugins = [
      (pkgs.hyprlandPlugins.hyprfocus.overrideAttrs (_: _: {
        # https://github.com/pyt0xic/hyprfocus/pull/21
        src = pkgs.fetchFromGitHub {
          owner = "pyt0xic";
          repo = "hyprfocus";
          rev = "e80aeff06a04ce1526dc3963280e4de5699d973c";
          hash = "sha256-oMOXbxJC4exyMRkqL+3gpf5QLa48Fw04oPtQJwD80qY=";
        };
        meta.broken = false;
      }))
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
