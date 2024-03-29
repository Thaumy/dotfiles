{ pkgs, ... }: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
  };

  programs.dconf.enable = true;
  environment.systemPackages = [ pkgs.virt-manager ];
}
