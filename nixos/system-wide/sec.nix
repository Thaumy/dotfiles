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
}

