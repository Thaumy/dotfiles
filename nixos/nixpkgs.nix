args@{ ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        nur = import
          builtins.fetchTarball
          {
            url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
            sha256 = "0nsjbhfhkicg0z67xwb8fzgsyj20i80c4ai168qyqn41s0xy0h1q";
          }
          {
            inherit pkgs;
          };
      };
      permittedInsecurePackages = [
      ];
    };
    overlays = (import ./overlay/mod.nix) args;
  };
}
