{ config, pkgs, ... }:

{

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "gnome3";
    sshKeys = [ "03BD55AAF282DD2C697F7960D08167BC2567CCA0" ];
  };

}
