{ pkgs, ... }:
let auto-dark = pkgs.writeShellScriptBin "auto-dark" ''
  #!/usr/bin/env bash

  function action {
    if [[ $1 =~ 'dark' ]] ; then
      dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-dark'"
      dconf write /org/gnome/terminal/legacy/theme-variant "'dark'"
    else
      dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita'"
      dconf write /org/gnome/terminal/legacy/theme-variant "'light'"
    fi
  }

  function filter {
    while read out; do
      declare s=$(echo "$out" | grep -oP "(?<=').+(?=')")
      if [ -z $s ]; then
        continue
      else
        action "$s"
      fi
    done
  }

  dconf watch /org/gnome/desktop/interface/color-scheme | filter
'';
in
{
  systemd.user.services."auto-dark-daemon" = {
    Service = {
      Type = "simple";
      Restart = "always";
      ExecStart = "${auto-dark}/bin/auto-dark";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
