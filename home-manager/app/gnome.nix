{ pkgs, ... }: {
  home.packages = with pkgs; [
    eog
    sushi # file preview
    geary # mail
    evince # docs reader
    nautilus
    file-roller # archive
    dconf-editor
    gnome-tweaks
    gnome-calendar
    gnome-calculator
    gnome-font-viewer
    gnome-disk-utility
  ];
}
