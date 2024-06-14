{ ... }: {
  networking = {
    hostName = "nixos";

    # Enable networking
    networkmanager.enable = true;

    # Enables wireless support via wpa_supplicant.
    # wireless.enable = true;

    # firewall.allowedTCPPorts = [ 40040 ];
    # firewall.allowedUDPPorts = [  ];
    firewall.enable = false;
  };
}

