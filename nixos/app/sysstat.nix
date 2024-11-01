{ pkgs, ... }: {
  services.sysstat.enable = true;
  environment.systemPackages = [
    pkgs.sysstat
  ];
}
