{ config, ... }: {
  programs.ccache = {
    enable = true;
    group = "bldcache";
  };

  systemd.tmpfiles.rules = [
    "a+ ${config.programs.ccache.cacheDir} - - - - g:nixbld:rwx"
  ];

  nixpkgs.overlays = [
    (self: super: {
      ccacheWrapper = super.ccacheWrapper.override {
        extraConfig = ''
          export CCACHE_COMPRESS=1
          export CCACHE_DIR="${config.programs.ccache.cacheDir}"
          export CCACHE_UMASK=007
          export CCACHE_SLOPPINESS=random_seed
          if [ ! -d "$CCACHE_DIR" ]; then
            echo "====="
            echo "Directory '$CCACHE_DIR' does not exist"
            echo "Please check your tmpfiles rules"
            echo "====="
            exit 1
          fi
          if [ ! -w "$CCACHE_DIR" ]; then
            echo "====="
            echo "Directory '$CCACHE_DIR' is not accessible for user $(whoami)"
            echo "Please verify its access permissions"
            echo "====="
            exit 1
          fi
        '';
      };
    })
  ];

  nix.settings.extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
}
