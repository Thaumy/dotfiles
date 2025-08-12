{ pkgs, ... }: {
  virtualisation = {
    podman = {
      enable = true;

      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  environment = {
    systemPackages = [ pkgs.podman ];
  };
}
