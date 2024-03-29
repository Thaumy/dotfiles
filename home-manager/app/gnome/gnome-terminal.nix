{ ... }:
let
  base = path: "org/gnome/terminal/legacy/keybindings${path}";
in
{
  dconf.settings.${base ""} = {
    close-tab = "disabled";
    close-window = "disabled";
    copy = "<Alt>c";
    find = "disabled";
    find-clear = "disabled";
    find-next = "disabled";
    find-previous = "disabled";
    full-screen = "disabled";
    move-tab-left = "disabled";
    move-tab-right = "disabled";
    new-tab = "disabled";
    new-window = "disabled";
    next-tab = "<Super>j";
    paste = "<Alt>v";
    prev-tab = "<Super>k";
    switch-to-tab-1 = "disabled";
    switch-to-tab-10 = "disabled";
    switch-to-tab-2 = "disabled";
    switch-to-tab-3 = "disabled";
    switch-to-tab-4 = "disabled";
    switch-to-tab-5 = "disabled";
    switch-to-tab-6 = "disabled";
    switch-to-tab-7 = "disabled";
    switch-to-tab-8 = "disabled";
    switch-to-tab-9 = "disabled";
    zoom-in = "disabled";
    zoom-normal = "disabled";
    zoom-out = "disabled";
  };
}

