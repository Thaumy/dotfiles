args@{ ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
      ];
    };
    overlays = (import ./overlay/mod.nix) args;
  };
}
