{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-personalization
  ];

  services = {
    udev.packages = [ pkgs.yubikey-personalization ];
    pcscd.enable = true;
  };

  # fix pinentry-gnome3 in non-GNOME systems
  services.dbus.packages = [ pkgs.gcr ];
}
