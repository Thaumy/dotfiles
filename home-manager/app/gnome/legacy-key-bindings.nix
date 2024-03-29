{ ... }:
let
  base = path: "org/gnome/desktop/wm/keybindings${path}";
in
{
  dconf.settings.${base ""} = {
    ## Switch applications
    switch-applications = [ ];
    ## Switch to workspace 1
    switch-to-workspace-1 = [ ];
    ## Switch to last workspace
    switch-to-workspace-last = [ ];

    ## Close window
    close = [ "<Super>BackSpace" ];
    ## Hide window
    maximize = [ ];
    ## Maximize window
    minimize = [ ];

    ## Move to workspace on the left
    switch-to-workspace-left = [ "<Super>a" ];
    ## Move to workspace on the right
    switch-to-workspace-right = [ "<Super>d" ];

    ## Switch windows directly
    cycle-windows = [ "<Alt>Tab" ];
    ## Switch windows backward directly
    cycle-windows-backward = [ "<Shift><Alt>Tab" ];
  };
}

