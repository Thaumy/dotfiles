{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --time-format %H:%M --asterisks -r -c Hyprland";
        user = "greeter";
      };
    };
  };
}
