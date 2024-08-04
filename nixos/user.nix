{ pkgs, ... }: {
  users.users."thaumy" = {
    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
  };
}

