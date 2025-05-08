{ pkgs, ... }:
let
  thaumy = {
    users = [ "thaumy" ];
    commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
  };
  u2f_keys = pkgs.writeText "u2f_keys" ''
    thaumy:Wb4JR3yJJ3CnZAZ2UCB0QmrVOLfNFXrsvSz3pPyRp/2o47Ufp0RJnU4uYqqWwkv1rW2fefMwimBn/YWMqxiXjg==,xAs8vXCAmGl2nC/cahp9YVSkJRGajuuZgRGokan040a3LC/z/s/bKjBLS8GsgDywSoPNIASR1Lfxgff1nHEtYg==,es256,+presence
  '';
in
{
  security = {
    sudo.enable = false;
    sudo-rs.enable = true;
    sudo-rs.extraRules = [ thaumy ];

    pam.u2f = {
      enable = true;
      settings = {
        cue = true;
        authfile = u2f_keys;
      };
    };
  };

  services = {
    udev.packages = [ pkgs.yubikey-personalization ];
    pcscd.enable = true;

    passSecretService.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.packages = [ pkgs.gcr ]; # fix pinentry-gnome3 in non-GNOME systems
  };

  environment.systemPackages = with pkgs; [
    pam_u2f
    seahorse
    pamtester
    yubico-pam
    gnome-keyring
    yubikey-manager
    yubikey-personalization
  ];
}

