{ config, pkgs, ... }:

{
  security.sudo.extraRules = [
    {
      users = [ "thaumy" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

}

