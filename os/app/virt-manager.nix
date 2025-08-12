{ pkgs, ... }: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
  };

  environment.systemPackages = [ pkgs.virt-manager ];
}
