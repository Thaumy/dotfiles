{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-personalization
  ];

  services = {
    udev.packages = [ pkgs.yubikey-personalization ];
    pcscd.enable = true;
  };
}
