{ pkgs, ... }: {
  users.users."thaumy" = {
    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "docker"
      "libvirtd"
      "networkmanager"
    ];
  };
}

