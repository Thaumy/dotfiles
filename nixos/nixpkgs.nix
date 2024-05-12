args@{ ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        nur = import
          (builtins.fetchTarball
            "https://github.com/nix-community/NUR/archive/master.tar.gz")
          {
            inherit pkgs;
          };
      };
      permittedInsecurePackages = [
        "openssl-1.1.1u"
      ];
    };
    overlays = (import ./overlay/mod.nix) args;
  };
}
