{ ... }:
let
  base = path: "org/gnome/settings-daemon/plugins/power${path}";
in
{
  dconf.settings.${base ""} = {
    idle-dim = false;
    power-button-action = "nothing";
    sleep-inactive-ac-type = "nothing";
    sleep-inactive-battery-type = "nothing";
  };
}

