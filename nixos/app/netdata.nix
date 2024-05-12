{ pkgs, ... }: {
  services.netdata = {
    enable = true;

    user = "thaumy";
    group = "users";

    claimTokenFile = "/home/thaumy/cfg/netdata/token";
    config = {
      plugins = {
        psh = "yes";
      };
    };
    extraPluginPaths = [
      "/home/thaumy/cfg/netdata/plugins.d"
    ];
  };

  environment.systemPackages = [ pkgs.netdata ];
}

