{ pkgs, ... }:
let
  cache_dir = "/var/cache/sccache";
in
{
  environment = {
    systemPackages = [ pkgs.sccache ];
    sessionVariables = {
      SCCACHE_DIR = cache_dir;
      SCCACHE_CACHE_SIZE = "50G";
    };
  };

  systemd.tmpfiles.rules = [
    "d ${cache_dir} 0770 root bldcache -"
  ];
}
