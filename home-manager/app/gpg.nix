{ pkgs, ... }: {
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    sshKeys = [ "DC0374AB5EFF87F3CD894A20B09E5DBB1A89F1B5" ];
  };
}
