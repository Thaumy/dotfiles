{ ... }: {
  nixpkgs = {
    overlays = import ./overlay/mod.nix;

    config.allowUnfree = true;
    config.packageOverrides = pkgs: {
      nur = import
        (builtins.fetchTarball
          "https://github.com/nix-community/NUR/archive/master.tar.gz")
        {
          inherit pkgs;
        };
    };
    config.permittedInsecurePackages = [
      "openssl-1.1.1u"
    ];
  };
}
