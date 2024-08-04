{ pkgs, ... }:
let
  thaumy = {
    users = [ "thaumy" ];
    commands = [
      {
        command = "ALL";
        options = [ "NOPASSWD" ];
      }
    ];
  };
in
{
  security.sudo.extraRules = [ thaumy ];

  services = {
    udev.packages = [ pkgs.yubikey-personalization ];
    pcscd.enable = true;

    passSecretService.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.packages = [ pkgs.gcr ]; # fix pinentry-gnome3 in non-GNOME systems
  };

  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-personalization
  ];
}

