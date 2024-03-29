{ ... }:
let
  base = path: "org/gnome/desktop/wm/preferences${path}";
in
{
  dconf.settings.${base ""} = {
    num-workspaces = 6;
    titlebar-font = "Cantarell Bold 11";
  };
}

