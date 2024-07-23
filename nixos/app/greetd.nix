{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format %H:%M --asterisks -r -c Hyprland";
        user = "greeter";
      };
    };
  };
}
