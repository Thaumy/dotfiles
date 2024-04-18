{ lib, ... }:
let
  base = path: "org/gnome/desktop/interface${path}";
in
{
  dconf.settings. ${base ""} = {
    font-hinting = "slight";
    font-antialiasing = "grayscale";
    font-name = "Sarasa UI SC 11";
    document-font-name = "Sarasa UI SC 11";
    monospace-font-name = "JetBrains Mono 10";

    cursor-size = 22;
    enable-animations = true;
    enable-hot-corners = false;

    scaling-factor = lib.hm.gvariant.mkUint32 2;
    text-scaling-factor = 1;

    clock-show-seconds = false;
    clock-show-weekday = true;
    toolkit-accessibility = false;
    show-battery-percentage = true;
  };
}

