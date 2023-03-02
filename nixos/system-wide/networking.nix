{ config, pkgs, ... }:

{

  networking = {
    hostName = "nixos";

    # Enable networking
    networkmanager.enable = true;

    # Configure network proxy if necessary
    proxy.default = "http://localhost:7890";
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enables wireless support via wpa_supplicant.
    # wireless.enable = true;

    # firewall.allowedTCPPorts = [ 40040 ];
    # firewall.allowedUDPPorts = [  ];
    firewall.enable = false;
  };

}

