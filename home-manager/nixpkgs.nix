{ ... }: {
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
        "nix-2.16.2"
      ];
    };
  };
}
