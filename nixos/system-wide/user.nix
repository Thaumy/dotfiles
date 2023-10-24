{ pkgs, ... }: {
  users.users."thaumy" = {
    description = "Thaumy";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };
}

