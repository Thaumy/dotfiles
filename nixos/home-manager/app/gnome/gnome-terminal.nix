{ ... }:
let
  base = path: "org/gnome/terminal/legacy/keybindings${path}";
in
{
  dconf.settings.${base ""} = {
    copy = "<Alt>c";
    paste = "<Alt>v";
  };
}

