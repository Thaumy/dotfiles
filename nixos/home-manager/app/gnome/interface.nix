{ lib, ... }:
let
  base = path: "org/gnome/desktop/interface${path}";
in
{
  dconf.settings. ${base ""} = {
    #color-scheme = "prefer-dark";
    cursor-size = 32;
    document-font-name = "Cantarell 11";
    enable-animations = true;
    enable-hot-corners = false;
    font-antialiasing = "grayscale";
    font-hinting = "slight";
    font-name = "Cantarell 11";
    gtk-theme = "Adwaita-dark";
    monospace-font-name = "JetBrains Mono 10";
    scaling-factor = lib.hm.gvariant.mkUint32 2;
    show-battery-percentage = true;
    text-scaling-factor = 1.7;
    toolkit-accessibility = false;
  };
}

