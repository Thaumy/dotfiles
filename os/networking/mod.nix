_: {
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = false;
    hostFiles = [ ./org-hosts ];
  };
}
