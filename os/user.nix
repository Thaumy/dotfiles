{ pkgs, ... }: {
  users.users."thaumy" = {
    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "docker"
      "bldcache"
      "libvirtd"
      "networkmanager"
    ];
  };

  users.groups."bldcache" = { };
}
