{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      gnome.gnome-boxes
      gnome.gnome-tweaks
    ];

    gnome.excludePackages = with pkgs;[
      kgx
      epiphany
      gnome-tour
      gnome.yelp
      gnome.totem
      gnome.gnome-maps
      gnome.gnome-music
      gnome.simple-scan
      gnome.gnome-clocks
      gnome.gnome-weather
      gnome.gnome-calendar
      gnome.gnome-contacts
    ];
  };
}

