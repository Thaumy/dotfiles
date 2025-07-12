{ pkgs, ... }: {
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
    sshKeys = [
      "F1A98CC89BCC1AA9888895EDC2E2A1C80812978A" # v3 [A]
    ];
  };
}
