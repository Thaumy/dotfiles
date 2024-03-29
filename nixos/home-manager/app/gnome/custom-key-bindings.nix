{ ... }:
let
  base = path: "org/gnome/settings-daemon/plugins/media-keys${path}";
in
{
  dconf.settings = {
    ${base ""} = {
      home = [ ];
      custom-keybindings = [
        ("/" + base "/custom-keybindings/custom0/")
        ("/" + base "/custom-keybindings/custom1/")
        ("/" + base "/custom-keybindings/custom2/")
        ("/" + base "/custom-keybindings/custom3/")
      ];
    };

    ${base "/custom-keybindings/custom0"} = {
      name = "Run browser";
      binding = "<Super>b";
      command = "chromium";
    };

    ${base "/custom-keybindings/custom1"} = {
      name = "Run terminal";
      binding = "<Super>t";
      command = "gnome-terminal";
    };

    ${base "/custom-keybindings/custom2"} = {
      name = "Run nvim";
      binding = "<Super>v";
      command = "gnome-terminal -- nvim";
    };

    ${base "/custom-keybindings/custom3"} = {
      name = "Open home";
      binding = "<Super>e";
      command = "nautilus -w";
    };
  };
}
