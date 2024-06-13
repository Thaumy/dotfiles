{ ... }:
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
  services.passSecretService.enable = true;
  services.gnome.gnome-keyring.enable = true;
}

